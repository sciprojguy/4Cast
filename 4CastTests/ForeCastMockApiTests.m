//
//  ForeCastMockApiTests.m
//  4CastTests
//
//  Created by Chris Woodard on 5/14/18.
//  Copyright © 2018 SampleSoft. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "Forecast-Swift.h"

@interface ForeCastMockApiTests : XCTestCase
@property (strong, nonatomic) MockRestAPI *restAPI;
@end

@implementation ForeCastMockApiTests

- (void)setUp {
    [super setUp];
    self.restAPI = [MockRestAPI shared];
    [self.restAPI clearProfile];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testGetMockForecastForTampa {

    XCTestExpectation *expectation = [self expectationWithDescription:@"asynchronous request"];
    __block NSDictionary *theForecast = nil;
    __block NSError *anythingHappened = nil;

    [self.restAPI forecastFor:@"Tampa,USA" completion:^(NSDictionary *results, NSError *err){
        theForecast = results;
        anythingHappened = err;
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:20.0 handler:nil];
    
    XCTAssertNotNil(theForecast, @"Unable to get the forecast");
    XCTAssertNil(anythingHappened, @"Got error: %@", anythingHappened);
    XCTAssertTrue([@200 isEqualToNumber:theForecast[@"Status"]], @"Should be 200, not %@", theForecast[@"Status"]);
}

- (void)testGetMockForecastForNewYork {

    XCTestExpectation *expectation = [self expectationWithDescription:@"asynchronous request"];
    __block NSDictionary *theForecast = nil;
    __block NSError *anythingHappened = nil;

    [self.restAPI forecastFor:@"New York,USA" completion:^(NSDictionary *results, NSError *err){
        theForecast = results;
        anythingHappened = err;
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
    
    XCTAssertNotNil(theForecast, @"Unable to get the forecast");
    XCTAssertNil(anythingHappened, @"Got error: %@", anythingHappened);
    XCTAssertTrue([@200 isEqualToNumber:theForecast[@"Status"]], @"Should be 200, not %@", theForecast[@"Status"]);
}

- (void)testGetMockForecastForChicago {

    XCTestExpectation *expectation = [self expectationWithDescription:@"asynchronous request"];
    __block NSDictionary *theForecast = nil;
    __block NSError *anythingHappened = nil;

    [self.restAPI forecastFor:@"Chicago,USA" completion:^(NSDictionary *results, NSError *err){
        theForecast = results;
        anythingHappened = err;
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
    
    XCTAssertNotNil(theForecast, @"Unable to get the forecast");
    XCTAssertNil(anythingHappened, @"Got error: %@", anythingHappened);
    XCTAssertTrue([@404 isEqualToNumber:theForecast[@"Status"]], @"Should be 404, not %@", theForecast[@"Status"]);
}

-(void)testGetMockForecastForNewYorkGetNoNetworkError {

    XCTestExpectation *expectation = [self expectationWithDescription:@"asynchronous request"];
    __block NSDictionary *theForecast = nil;
    __block NSError *anythingHappened = nil;
    
    [self.restAPI loadProfile:@"no_network"];
    [self.restAPI forecastFor:@"New York,USA" completion:^(NSDictionary *results, NSError *err){
        theForecast = results;
        anythingHappened = err;
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
    
    XCTAssertNotNil(theForecast, @"Unable to get the forecast");
    XCTAssertNotNil(anythingHappened, @"No error returned");
}

-(void)testGetMockForecastForNewYorkGet500Error {

    XCTestExpectation *expectation = [self expectationWithDescription:@"asynchronous request"];
    __block NSDictionary *theForecast = nil;
    __block NSError *anythingHappened = nil;
    
    [self.restAPI loadProfile:@"500_statuses"];
    [self.restAPI forecastFor:@"New York,USA" completion:^(NSDictionary *results, NSError *err){
        theForecast = results;
        anythingHappened = err;
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
    
    XCTAssertNotNil(theForecast, @"Unable to get the forecast");
    XCTAssertNil(anythingHappened, @"Got error: %@", anythingHappened);
    XCTAssertTrue([@500 isEqualToNumber:theForecast[@"Status"]], @"Should be 200, not %@", theForecast[@"Status"]);
}

@end
