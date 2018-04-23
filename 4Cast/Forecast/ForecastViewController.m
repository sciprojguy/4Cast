//
//  ViewController.m
//  4Cast
//
//  Created by Chris Woodard on 3/23/18.
//  Copyright © 2018 SampleSoft. All rights reserved.
//

#import "ForecastViewController.h"
#import "ForecastDetailsViewController.h"
#import "SearchView.h"
#import "ForecastCell.h"

#import "MBProgressHUD.h"

#import "IconCache.h"
#import "RESTClient.h"
#import "Forecast-Swift.h"

@interface ForecastViewController () <UITableViewDelegate, UITableViewDataSource, ForecastDetailsDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) RESTClient *weatherClient;
@property (weak, nonatomic) IBOutlet UITableView *forecastsTable;
@property (weak, nonatomic) IBOutlet UILabel *cityAndCountryLabel;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (nonatomic, strong) FiveDay3HourForecast *forecast;
@end

@implementation ForecastViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchTheWeather:) forControlEvents:UIControlEventValueChanged];
    [self.forecastsTable addSubview:self.refreshControl];
    self.searchBar.accessibilityIdentifier = @"SearchField";
    self.weatherClient = [RESTClient shared];
    [self fetchTheWeather:nil];
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger numRows = [self.forecast listCount];
    return numRows;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 84;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ForecastListItem *item = [self.forecast itemAtIndex:indexPath.row];

    ForecastCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ForecastCell"];
    if(nil == cell) {
        cell = [[ForecastCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ForecastCell"];
    }
    
    [cell setFromForecastItem:item];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"ForecastDetails" sender:indexPath];
}

- (IBAction)toggleSearchView:(id)sender {
//    if(self.searchBar.hidden) {
//        [UIView animateWithDuration:0.5 animations:^{
//            self.searchBar.hidden = NO;
//            [self.view bringSubviewToFront:self.searchBar];
//        }];
//    }
//    else {
//        [UIView animateWithDuration:0.25 animations:^{
//            self.searchBar.hidden = YES;
//        }];
//    }
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {

}

-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    return YES;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self fetchTheWeather:nil];
}

- (void)displayConnectionErrorAlert {
    UIAlertController *alert = [[UIAlertController alloc] init];
    [alert setTitle:@"Error"];
    [alert setMessage:@"Unable to retrieve your forecast due to a network error.  Please try again when you have a connection."];
    [alert addAction:[UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)displayAPIErrorAlert {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alert = [[UIAlertController alloc] init];
        [alert setTitle:@"Error"];
        [alert setMessage:@"Unable to retrieve a forecast for that city.  Please check its spelling and try again."];
        [alert addAction:[UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    });
}

- (void)downloadIconsIfNecessary {
    IconCache *ic = [IconCache sharedCache];
    NSInteger numForecasts = [self.forecast listCount];
    for( NSInteger i=0; i<numForecasts; i++ ) {
        ForecastListItem *item = [self.forecast itemAtIndex:i];
        UIImage *icon = [ic iconNamed:item.icon];
        icon = nil;
        if(nil == icon) {
            [self.weatherClient downloadIcon:item.icon completion:^(NSDictionary *results) {
                if(results[@"Data"]) {
                    [ic storeIcon:results[@"Data"] withName:item.icon];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.forecastsTable reloadData];
                    });
                }
            }];
        }
    }
}

//MARK: fetches the weather forecast

-(IBAction)fetchTheWeather:(id)sender {

    NSString *city = self.searchBar.text;
    if(nil == city || [@"" isEqualToString:city]) {
        self.cityAndCountryLabel.text = @"";
        return;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
//    self.searchBar.hidden = YES;
//    [self.searchBar resignFirstResponder];
    
dispatch_async( dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //#2 - get forecast
        [self.weatherClient forecastForCity:city completion:^(NSDictionary *forecast, NSError *err) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [hud hideAnimated:YES];
                    [self.refreshControl endRefreshing];
                });
                if(err) {
                    [self displayConnectionErrorAlert];
                }
                else {
                    self.forecast = [[FiveDay3HourForecast alloc] initFromDict:forecast];
                    
                    if(200 == self.forecast.statusCode) {
                        [self downloadIconsIfNecessary];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            self.cityAndCountryLabel.text = self.forecast.cityName;
                            self.cityAndCountryLabel.accessibilityValue = self.forecast.cityName;
                            [self.forecastsTable reloadData];
                        });
                    }
                    else {
                        [self displayAPIErrorAlert];
                    }
                }
        }];
    });
}

//MARK: Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([@"ForecastDetails" isEqualToString:segue.identifier]) {
        ForecastDetailsViewController *dvc = (ForecastDetailsViewController *)[segue destinationViewController];
        NSIndexPath *indexPath = (NSIndexPath *)sender;
        dvc.delegate = self;
        dvc.itemIndex = indexPath.row;
    }
}

-(ForecastListItem *)forecastDetailsAtIndex:(NSInteger)index {
    return [self.forecast itemAtIndex:index];
}

@end
