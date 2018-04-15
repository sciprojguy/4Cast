//
//  RESTClient.m
//  4Cast
//
//  Created by Chris Woodard on 3/23/18.
//  Copyright © 2018 SampleSoft. All rights reserved.
//

#import "RESTClient.h"

#import "Forecast-Swift.h"

@interface RESTClient () <NSURLSessionDelegate>

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSOperationQueue *sessionQueue;

@end

@implementation RESTClient

+(RESTClient *)shared {
    static RESTClient *client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[RESTClient alloc] init];
        client.sessionQueue = [[NSOperationQueue alloc] init];
        client.sessionQueue.maxConcurrentOperationCount = 4;
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        [config setAllowsCellularAccess:YES];
        config.timeoutIntervalForRequest = 15;
        config.timeoutIntervalForResource = 15;
        config.networkServiceType = NSURLNetworkServiceTypeDefault;
        config.requestCachePolicy = NSURLRequestReloadIgnoringCacheData;
        client.session = [NSURLSession sessionWithConfiguration:config delegate:client delegateQueue:client.sessionQueue];

    });
    return client;
}

//todo: check in here for useMock.  if NO, proceed.  if YES,
//look up JSON for city and country & return the forecast

-(void)forecastForCity:(NSString *)cityAndCountry completion:(void(^)(NSDictionary *forecast, NSError *err))completion {

    NSMutableCharacterSet *allowed = [NSMutableCharacterSet
                                alphanumericCharacterSet];
    NSString *encoded = [cityAndCountry stringByAddingPercentEncodingWithAllowedCharacters:allowed];
    encoded = [encoded stringByReplacingOccurrencesOfString:@" " withString:@"+"];

    if(self.useMock) {
    
        TestingHelper *helper = [TestingHelper shared];
        NSData *data = [helper forecastWithCityandstate:encoded];
        NSDictionary *forecast = nil;
        NSError *err = nil;
        if(data) {
            forecast = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        }
        else {
            forecast = @{@"StatusCode":@404, @"StatusMsg":@"No Such City/Country"};
        }

        if(completion) {
            completion(forecast, err);
        }
        
        return;
    }
    
    NSString *urlString = [[NSString alloc] initWithFormat:@"https://api.openweathermap.org/data/2.5/forecast?q=%@&units=imperial&appid=3a5a5533643dadd75a8c095541dea0ed", encoded];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];

    //here is the stuff particular to this method
    [request setHTTPMethod:@"GET"];
    request.timeoutInterval = 15;

    __block NSError *err = nil;
    __block NSData *responseData = nil;
    __block NSHTTPURLResponse *httpResponse = nil;

    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        err = error;
        responseData = data;
        httpResponse = (NSHTTPURLResponse *)response;
        
        //based on response get body and parse data into FiveDay3HourForecast
        NSDictionary *forecast = nil;
        if(200 == httpResponse.statusCode) {
            forecast = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        }
        else {
            forecast = @{@"StatusCode":@(httpResponse.statusCode)};
        }
        
        if(completion) {
            completion(forecast, err);
        }
    }];

    [task resume];
}

//todo: check in here for useMock.  if NO, proceed.  if YES,
//look up icon & return it

-(void)downloadIcon:(NSString *)iconStem completion:(void(^)(NSDictionary *results))completion {

    if(self.useMock) {
        
        //build path to icon in bundle
        NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:iconStem ofType:@"png"];
        //fetch it as NSData
        NSData *imgData = [NSData dataWithContentsOfFile:path];
        NSHTTPURLResponse *httpResponse = nil;
        if(imgData) {
            httpResponse = [[NSHTTPURLResponse alloc] initWithURL:[NSURL URLWithString:@"mock"] statusCode:200 HTTPVersion:@"1.1" headerFields:@{}];
        
        }
        else {
            httpResponse = [[NSHTTPURLResponse alloc] initWithURL:[NSURL URLWithString:@"mock"] statusCode:404 HTTPVersion:@"1.1" headerFields:@{}];
        }
        
        NSMutableDictionary *responseDict = [[NSMutableDictionary alloc] init];
        responseDict[@"Response"] = httpResponse;
        if(imgData) {
            responseDict[@"Data"] = imgData;
        }
        if(completion) {
            completion(responseDict);
        }
        
        return;
    }
    
    NSString *urlString = [[NSString alloc] initWithFormat:@"https://openweathermap.org/img/w/%@.png", iconStem];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];

    //here is the stuff particular to this method
    [request setHTTPMethod:@"GET"];
    request.timeoutInterval = 15;

    __block NSError *err = nil;
    __block NSData *responseData = nil;
    __block NSHTTPURLResponse *httpResponse = nil;

    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        err = error;
        responseData = data;
        httpResponse = (NSHTTPURLResponse *)response;
        NSMutableDictionary *responseDict = [[NSMutableDictionary alloc] init];
        responseDict[@"Response"] = httpResponse;
        if(data) {
            responseDict[@"Data"] = data;
        }
        if(completion) {
            completion(responseDict);
        }
    }];

    [task resume];
}

@end
