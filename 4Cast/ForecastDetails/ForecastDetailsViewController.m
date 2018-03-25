//
//  ForecastDetailsViewController.m
//  4Cast
//
//  Created by Chris Woodard on 3/23/18.
//  Copyright © 2018 SampleSoft. All rights reserved.
//

#import "ForecastDetailsViewController.h"
#import "IconCache.h"

@interface ForecastDetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *timeAndDate;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *lowTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *highTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *humidityLabel;
@end

@implementation ForecastDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if(self.delegate && [self.delegate respondsToSelector:@selector(forecastDetailsAtIndex:)]) {
        ForecastListItem *item = [self.delegate forecastDetailsAtIndex:self.itemIndex];
        [self constructUI:item];
    }
    else {
        //internal error alert...
    }
}

-(void)constructUI:(ForecastListItem *)item {

    NSDateFormatter *fmtr = [[NSDateFormatter alloc] init];
    fmtr.dateFormat = @"EEEE, MMMM dd yyyy h:mm a";
    self.timeAndDate.text = [fmtr stringFromDate:item.dateTime];
    
    UIImage *iconImg = [[IconCache sharedCache] iconNamed:item.icon];
    self.iconView.image = iconImg;
    self.descriptionLabel.text = item.weatherDescription;
    
    self.lowTempLabel.text = [[NSString alloc] initWithFormat:@"Low of %.1f ºF", item.tempMin];
    self.highTempLabel.text = [[NSString alloc] initWithFormat:@"High of %.1f ºF", item.tempMax];
    
    self.humidityLabel.text = [[NSString alloc] initWithFormat:@"Rel Humidity %ld%%", item.humidity];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
