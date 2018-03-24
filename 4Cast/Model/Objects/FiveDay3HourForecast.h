//
//  FiveDay3HourForecast.h
//  4Cast
//
//  Created by Chris Woodard on 3/24/18.
//  Copyright © 2018 SampleSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ForecastListItem.h"

@interface FiveDay3HourForecast : NSObject

@property (nonatomic, assign) NSInteger statusCode;
@property (nonatomic, strong) NSString *statusMsg;
@property (nonatomic, assign) NSInteger listCount;

//city
@property (nonatomic, strong) NSNumber *cityId;
@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong) NSString *cityCountry;
@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, strong) NSNumber *longitude;

@property (nonatomic, strong) NSMutableArray *list;

-(instancetype)initFromJson:(NSData *)jsonData;
-(ForecastListItem *)itemAtIndex:(NSInteger)index;

@end
