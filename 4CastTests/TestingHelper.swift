//
//  TestingHelper.swift
//  4CastTests
//
//  Created by Chris Woodard on 4/13/18.
//  Copyright © 2018 SampleSoft. All rights reserved.
//

import Foundation

@objc public class TestingHelper: NSObject {
    static var shared:TestingHelper? = TestingHelper()
    override private init() {}
    @objc func forecast(cityandstate:String) -> Data? {
        var theForecast:Data? = nil
        if let path = Bundle.main.path(forResource: cityandstate, ofType: "json") {
            theForecast = try? Data(contentsOf: URL(fileURLWithPath: path))
        }
        return theForecast
    }
}
