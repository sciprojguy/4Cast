//
//  RestApiProtocol.swift
//  4Cast
//
//  Created by Chris Woodard on 5/13/18.
//  Copyright © 2018 SampleSoft. All rights reserved.
//

import Foundation

@objc protocol WeatherApi {
    func forecast(for cityAndCountry:String, completion:@escaping ([String:Any]?, Error?) -> Void)
    func downloadIcon(for name:String, completion:@escaping ([String:Any], Error?) -> Void)
    @objc optional func loadProfile(_ name:String)
    @objc optional func clearProfile()
}
