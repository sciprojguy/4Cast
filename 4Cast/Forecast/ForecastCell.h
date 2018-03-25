//
//  ForecastCell.h
//  4Cast
//
//  Created by Chris Woodard on 3/24/18.
//  Copyright © 2018 SampleSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Forecast-Swift.h"

@interface ForecastCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *dateAndTime;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *lowTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *highTempLabel;

-(void)setFromForecastItem:(ForecastListItem *)item;

@end
