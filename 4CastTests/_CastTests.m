//
//  _CastTests.m
//  4CastTests
//
//  Created by Chris Woodard on 3/24/18.
//  Copyright © 2018 SampleSoft. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "RESTClient.h"
#import "ForecastListItem.h"
#import "FiveDay3HourForecast.h"
#import "IconCache.h"

@interface _CastTests : XCTestCase
@property (strong, nonatomic) RESTClient *restClient;
@end

@implementation _CastTests

-(void)setUp {
    [super setUp];
    self.restClient = [RESTClient shared];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testWeatherForTampaFL {
    XCTestExpectation *expectation = [self expectationWithDescription:@"asynchronous request"];
    __block FiveDay3HourForecast *theForecast = nil;
    __block NSError *anythingHappened = nil;
    
    [self.restClient forecastForCity:@"Tampa,FL,USA" completion:^(FiveDay3HourForecast *results, NSError *err) {
        theForecast = results;
        anythingHappened = err;
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
    
    XCTAssertNotNil(theForecast, @"Unable to get the forecast");
    XCTAssertNil(anythingHappened, @"Got error: %@", anythingHappened);
}

-(void)testWeatherForStPetersburgFL {
    XCTestExpectation *expectation = [self expectationWithDescription:@"asynchronous request"];
    __block FiveDay3HourForecast *theForecast = nil;
    __block NSError *anythingHappened = nil;
    
    [self.restClient forecastForCity:@"St Petersburg,USA" completion:^(FiveDay3HourForecast *results, NSError *err) {
        theForecast = results;
        anythingHappened = err;
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
    
    XCTAssertNotNil(theForecast, @"Unable to get the forecast");
    XCTAssertNil(anythingHappened, @"Got error: %@", anythingHappened);
}

-(void)testWeatherForMiamiFL {
    XCTestExpectation *expectation = [self expectationWithDescription:@"asynchronous request"];
    __block FiveDay3HourForecast *theForecast = nil;
    __block NSError *anythingHappened = nil;
    
    [self.restClient forecastForCity:@"Miami,USA" completion:^(FiveDay3HourForecast *results, NSError *err) {
        theForecast = results;
        anythingHappened = err;
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
    
    XCTAssertNotNil(theForecast, @"Unable to get the forecast");
    XCTAssertNil(anythingHappened, @"Got error: %@", anythingHappened);
}

-(void)testWeatherForNYNY {
    XCTestExpectation *expectation = [self expectationWithDescription:@"asynchronous request"];
    __block FiveDay3HourForecast *theForecast = nil;
    __block NSError *anythingHappened = nil;
    
    [self.restClient forecastForCity:@"New+York,USA" completion:^(FiveDay3HourForecast *results, NSError *err) {
        theForecast = results;
        anythingHappened = err;
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
    
    XCTAssertNotNil(theForecast, @"Unable to get the forecast");
    XCTAssertNil(anythingHappened, @"Got error: %@", anythingHappened);
}

-(void)testWeatherForMangledNY {
    XCTestExpectation *expectation = [self expectationWithDescription:@"asynchronous request"];
    __block FiveDay3HourForecast *theForecast = nil;
    __block NSError *anythingHappened = nil;
    
    [self.restClient forecastForCity:@"New+York,USA" completion:^(FiveDay3HourForecast *results, NSError *err) {
        theForecast = results;
        anythingHappened = err;
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
    
    XCTAssertNotNil(theForecast, @"Unable to get the forecast");
    XCTAssertEqual(404, theForecast.statusCode, @"Should have been 404, not %ld", theForecast.statusCode);
    XCTAssertNil(anythingHappened, @"Got error: %@", anythingHappened);
}

-(void)testWeatherForChicagoIL {
    XCTestExpectation *expectation = [self expectationWithDescription:@"asynchronous request"];
    __block FiveDay3HourForecast *theForecast = nil;
    __block NSError *anythingHappened = nil;
    
    [self.restClient forecastForCity:@"Chicago,USA" completion:^(FiveDay3HourForecast *results, NSError *err) {
        theForecast = results;
        anythingHappened = err;
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
    
    XCTAssertNotNil(theForecast, @"Unable to get the forecast");
    XCTAssertEqual(404, theForecast.statusCode, @"Should have been 404, not %ld", theForecast.statusCode);
    XCTAssertNil(anythingHappened, @"Got error: %@", anythingHappened);
}

-(void)testIconDownload {
    XCTestExpectation *expectation = [self expectationWithDescription:@"asynchronous request"];
    __block NSDictionary *theResults = nil;
    [self.restClient downloadIcon:@"10d" completion:^(NSDictionary *results) {
        theResults = results;
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
    XCTAssertNotNil(theResults[@"Response"], @"No response provided");
    XCTAssertNotNil(theResults[@"Data"], @"No icon data provided");
    
    IconCache *cache = [IconCache sharedCache];
    [cache storeIcon:theResults[@"Data"] withName:@"10d"];
    
    UIImage *retrievedIcon = [cache iconNamed:@"10d"];
    XCTAssertNotNil(retrievedIcon, @"No icon retrieved");
}
//tests for parsing forecast response
-(void)testJsonResponse {

    NSString *jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"testForecast" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    FiveDay3HourForecast *forecast = [[FiveDay3HourForecast alloc] initFromJson:jsonData];

    XCTAssertNotNil(forecast, @"Unable to allocate forecase");
    XCTAssertEqual(36, [forecast listCount], @"Should be 36 items in forecast");
    XCTAssertTrue( [@"Altstadt" isEqualToString:forecast.cityName], @"Wrong city");
    XCTAssertTrue( [@"none" isEqualToString:forecast.cityCountry], @"Wrong country");
}

-(void)testJsonResponseForTampa {

    NSString *jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"testForecast_Tampa" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    FiveDay3HourForecast *forecast = [[FiveDay3HourForecast alloc] initFromJson:jsonData];

    XCTAssertNotNil(forecast, @"Unable to allocate forecase");
    XCTAssertEqual(40, [forecast listCount], @"Should be 40 items in forecast");
    XCTAssertTrue( [@"Tampa" isEqualToString:forecast.cityName], @"Wrong city");
    XCTAssertTrue( [@"US" isEqualToString:forecast.cityCountry], @"Wrong country");
}

-(void)testJsonResponseForNewYork {

    NSString *jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"testForecast_NewYork" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    FiveDay3HourForecast *forecast = [[FiveDay3HourForecast alloc] initFromJson:jsonData];

    XCTAssertNotNil(forecast, @"Unable to allocate forecase");
    XCTAssertEqual(40, [forecast listCount], @"Should be 40 items in forecast");
    XCTAssertTrue( [@"New York" isEqualToString:forecast.cityName], @"Wrong city");
    XCTAssertTrue( [@"US" isEqualToString:forecast.cityCountry], @"Wrong country");
}

@end
