//
//  ForecastListItem.h
//  4Cast
//
//  Created by Chris Woodard on 3/24/18.
//  Copyright © 2018 SampleSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ForecastListItem : NSObject

@property (nonatomic, strong) NSDate *dateTime;

//main
@property (nonatomic, strong) NSNumber *temp;
@property (nonatomic, strong) NSNumber *tempMin;
@property (nonatomic, strong) NSNumber *tempMax;
@property (nonatomic, strong) NSNumber *pressure;
@property (nonatomic, strong) NSNumber *seaLevel;
@property (nonatomic, strong) NSNumber *grndLevel;
@property (nonatomic, strong) NSNumber *humidity;
@property (nonatomic, strong) NSNumber *tempK;

//weather
@property (nonatomic, strong) NSNumber *idVal;
@property (nonatomic, strong) NSString *main;
@property (nonatomic, strong) NSString *weatherDescription;
@property (nonatomic, strong) NSArray *weathers;
@property (nonatomic, strong) NSString *icon;

//clouds
@property (nonatomic, strong) NSNumber *cloudsAll;

//wind
@property (nonatomic, strong) NSNumber *windSpeed;
@property (nonatomic, strong) NSNumber *windDirection;

//rain
@property (nonatomic, strong) NSNumber *rain_3hr;

//snow
@property (nonatomic, strong) NSNumber *snow_3hr;

//sys
@property (nonatomic, strong) NSNumber *systemPod;

-(instancetype)initFromDictionary:(NSDictionary *)jsonData;

@end
