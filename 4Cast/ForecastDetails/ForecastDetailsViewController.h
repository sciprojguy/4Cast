//
//  ForecastDetailsViewController.h
//  4Cast
//
//  Created by Chris Woodard on 3/23/18.
//  Copyright © 2018 SampleSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Forecast-Swift.h"

@protocol ForecastDetailsDelegate <NSObject>
-(ForecastListItem *)forecastDetailsAtIndex:(NSInteger)index;
@end

@interface ForecastDetailsViewController : UIViewController
@property (nonatomic, strong) id<ForecastDetailsDelegate>delegate;
@property (nonatomic, assign) NSInteger itemIndex;
@end
