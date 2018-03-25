//
//  ForecastListItem.m
//  4Cast
//
//  Created by Chris Woodard on 3/24/18.
//  Copyright © 2018 SampleSoft. All rights reserved.
//

#import "ForecastListItem.h"

@implementation ForecastListItem

-(instancetype)initFromDictionary:(NSDictionary *)jsonData {
    self = [super init];
    if(self) {
        if(jsonData[@"dt"]) {
            NSTimeInterval interval = [jsonData[@"dt"] doubleValue];
            self.dateTime = [[NSDate alloc] initWithTimeIntervalSince1970:interval];
        }
        
        if(jsonData[@"main"]) {
            //air pressure
            self.grndLevel = [jsonData[@"main"][@"grnd_level"] copy];
            self.seaLevel = [jsonData[@"main"][@"sea_level"] copy];
            self.pressure = [jsonData[@"main"][@"pressure"] copy];

            //rel humidity
            self.humidity = [jsonData[@"main"][@"humidity"] copy];
            
            //temp
            self.temp = [jsonData[@"main"][@"temp"] copy];
            self.tempK = [jsonData[@"main"][@"temp_kf"] copy];
            self.tempMin = [jsonData[@"main"][@"temp_min"] copy];
            self.tempMax = [jsonData[@"main"][@"temp_max"] copy];
        }
        
        if(jsonData[@"weather"]) {
            NSArray *weatherConditionArray = jsonData[@"weather"];
            self.icon = weatherConditionArray[0][@"icon"];
            NSMutableArray *descriptions = [[NSMutableArray alloc] init];
            for( NSDictionary *condition in weatherConditionArray ) {
                [descriptions addObject:[condition[@"description"] copy]];
            }
            self.weathers = weatherConditionArray;
            self.weatherDescription = [descriptions componentsJoinedByString:@"/"];
        }
        
        if(jsonData[@"wind"]) {
            self.windSpeed = [jsonData[@"wind"][@"speed"] copy];
            self.windDirection = [jsonData[@"wind"][@"deg"] copy];
        }
        
        if(jsonData[@"rain"]) {
            self.rain_3hr = [jsonData[@"rain"][@"3h"] copy];
        }
        
        if(jsonData[@"snow"]) {
            self.snow_3hr = [jsonData[@"snow"][@"3h"] copy];
        }
        
        if(jsonData[@"clouds"]) {
            self.cloudsAll = [jsonData[@"clouds"][@"all"] copy];
        }
        
        if(jsonData[@"sys"]) {
            self.systemPod = [jsonData[@"sys"][@"pod"] copy];
        }
    }
    return self;
}

-(void)dealloc {
    self.systemPod = nil;
    self.rain_3hr = nil;
    self.cloudsAll = nil;
    self.snow_3hr = nil;
    self.icon = nil;
    self.main = nil;
    self.grndLevel = nil;
    self.seaLevel = nil;
    self.tempMin = nil;
    self.tempMax = nil;
    self.temp = nil;
    self.tempK = nil;
    self.weathers = nil;
    self.weatherDescription = nil;
    self.windSpeed = nil;
    self.windDirection = nil;
    self.pressure = nil;
    self.humidity = nil;
}

@end
