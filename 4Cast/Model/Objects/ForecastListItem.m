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
        
        if(jsonData[@"dt_txt"]) {
            //add this?
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
            self.rain_3hr = [jsonData[@"snow"][@"3h"] copy];
        }
        
        if(jsonData[@"clouds"]) {
            self.rain_3hr = [jsonData[@"clouds"][@"all"] copy];
        }
        
        if(jsonData[@"sys"]) {
            self.systemPod = [jsonData[@"sys"][@"pod"] copy];
        }
    }
    return self;
}

-(void)dealloc {

}

@end
