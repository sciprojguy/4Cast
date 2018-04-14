//
//  RESTClient.h
//  4Cast
//
//  Created by Chris Woodard on 3/23/18.
//  Copyright © 2018 SampleSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RESTClient : NSObject

@property (nonatomic, assign) BOOL useMock;

+(RESTClient *)shared;

-(void)forecastForCity:(NSString *)cityAndCountry completion:(void(^)(NSDictionary *forecast, NSError *err))completion;
-(void)downloadIcon:(NSString *)iconStem completion:(void(^)(NSDictionary *results))completion;

@end
