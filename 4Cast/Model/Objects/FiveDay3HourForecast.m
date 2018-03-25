//
//  FiveDay3HourForecast.m
//  4Cast
//
//  Created by Chris Woodard on 3/24/18.
//  Copyright © 2018 SampleSoft. All rights reserved.
//

#import "FiveDay3HourForecast.h"

@implementation FiveDay3HourForecast

-(id)initFromJson:(NSData *)jsonData {
    self = [super init];
    if(self) {
    
        //deserialize jsonData
        NSError *dataError = nil;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&dataError];
        if(nil != dataError) {
            
        }
        
        self.statusCode = [dict[@"cod"] integerValue];
        self.statusMsg = dict[@"msg"] ? [dict[@"msg"] copy] : @"";
        self.listCount = [dict[@"cnt"] integerValue];
        
        if(dict[@"city"]) {
            self.cityName = dict[@"city"][@"name"] ? [dict[@"city"][@"name"] copy] : @"";
            self.cityCountry = dict[@"city"][@"country"] ? [dict[@"city"][@"country"] copy] : @"";
            self.cityId = [dict[@"city"][@"id"] copy];
        }
        
        if(dict[@"city"][@"coord"]) {
            self.latitude = [dict[@"city"][@"coord"][@"lat"] copy];
            self.longitude = [dict[@"city"][@"coord"][@"lon"] copy];
        }
        
        self.list = [[NSMutableArray alloc] init];        
        NSArray *list = dict[@"list"];
        for( int i=0; i<self.listCount; i++ ) {
            NSDictionary *entry = list[i];
            ForecastListItem *item = [[ForecastListItem alloc] initFromDictionary:entry];
            if(item) {
                [self.list addObject:item];
            }
        }
        
    }
    return self;
}

-(ForecastListItem *)itemAtIndex:(NSInteger)index {
    return self.list[index];
}

-(void)dealloc {
    self.cityId = nil;
    self.cityCountry = nil;
    self.cityName = nil;
    self.latitude = nil;
    self.longitude = nil;
    self.statusMsg = nil;
    self.list = nil;
}

@end
