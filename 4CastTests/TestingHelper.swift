//
//  TestingHelper.swift
//  4CastTests
//
//  Created by Chris Woodard on 4/13/18.
//  Copyright © 2018 SampleSoft. All rights reserved.
//

import UIKit

@objc class TestingHelper: NSObject {
    public static var shared:TestingHelper? = TestingHelper()
    override private init() {}
    public func forecast(cityandstate:String) -> FiveDay3HourForecast? {
        var theForecast:FiveDay3HourForecast? = nil
        //look up JSON for cityandstate and return
/*
    NSString *jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"testForecast_NewYork" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
 */
        return theForecast
    }
}
