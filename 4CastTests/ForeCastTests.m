//
//  _CastTests.m
//  4CastTests
//
//  Created by Chris Woodard on 3/24/18.
//  Copyright © 2018 SampleSoft. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "Forecast-Swift.h"

#import "IconCache.h"

@interface ForeCastTests : XCTestCase
@property (strong, nonatomic) LiveRestAPI *restAPI;
@end

@implementation ForeCastTests

-(void)setUp {
    [super setUp];
    self.restAPI = [LiveRestAPI shared];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testGetWeatherForTampaFL {

    XCTestExpectation *expectation = [self expectationWithDescription:@"asynchronous request"];
    __block NSDictionary *theForecast = nil;
    __block NSError *anythingHappened = nil;

    [self.restAPI forecastFor:@"Tampa,USA" completion:^(NSDictionary *results, NSError *err) {
        theForecast = results;
        anythingHappened = err;
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
    
    XCTAssertNotNil(theForecast, @"Unable to get the forecast");
    XCTAssertNil(anythingHappened, @"Got error: %@", anythingHappened);
}

-(void)testWeatherForChicagoIL {
    XCTestExpectation *expectation = [self expectationWithDescription:@"asynchronous request"];
    __block NSDictionary *theForecast = nil;
    __block NSError *anythingHappened = nil;
    
    [self.restAPI forecastFor:@"Chicago,USA" completion:^(NSDictionary *results, NSError *err) {
        theForecast = results;
        anythingHappened = err;
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
    
    XCTAssertNotNil(theForecast, @"Unable to get the forecast");
    XCTAssertEqual(200, [theForecast[@"Status"] integerValue], @"Should have been 200, not %ld", [theForecast[@"Status"] integerValue]);
    XCTAssertNil(anythingHappened, @"Got error: %@", anythingHappened);
}

-(void)testIconDownload {
    XCTestExpectation *expectation = [self expectationWithDescription:@"asynchronous request"];
    __block NSDictionary *theResults = nil;
    [self.restAPI downloadIconFor:@"10d" completion:^(NSDictionary *results, NSError *err) {
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


@end
