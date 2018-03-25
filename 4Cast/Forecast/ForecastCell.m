//
//  ForecastCell.m
//  4Cast
//
//  Created by Chris Woodard on 3/24/18.
//  Copyright © 2018 SampleSoft. All rights reserved.
//

#import "ForecastCell.h"
#import "IconCache.h"
#import "_Cast-Swift.h"

@implementation ForecastCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setFromForecaseItem:(ForecastListItem *)item {
    //move this into ForecastCell
    self.iconView.image = [[IconCache sharedCache] iconNamed:item.icon];
    self.descriptionLabel.text = item.weatherDescription;
    
    self.lowTempLabel.text = [[NSString alloc] initWithFormat:@"Low: %.1f F", item.tempMin];
    self.highTempLabel.text = [[NSString alloc] initWithFormat:@"High: %.1f F", item.tempMax];
    NSDateFormatter *fmtr = [[NSDateFormatter alloc] init];
    fmtr.dateFormat = @"MMM d yy hh:mm a";
    self.dateAndTime.text = [fmtr stringFromDate:item.dateTime];
}

@end
