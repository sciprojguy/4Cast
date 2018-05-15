//
//  MockRestAPI.swift
//  4Cast
//
//  Created by Chris Woodard on 5/13/18.
//  Copyright © 2018 SampleSoft. All rights reserved.
//

import Foundation

@objc class MockRestAPI: NSObject, WeatherApi {

    static let shared = MockRestAPI()
    
    func forecast(for cityAndCountry: String, completion: @escaping ([String:Any]?, Error?) -> Void) {
    
        var resultsDict:[String:Any] = [:]
        
        //todo: add
        
        //construct path to JSON for cityAndCountry
        let bundle = Bundle.init(for: MockRestAPI.self)
        if let jsonPath = bundle.path(forResource: cityAndCountry, ofType: "json") {
            //look it up and return dictionary wtih response
            guard let data:NSData = try? NSData(contentsOfFile: jsonPath),
                let dict:[String:Any] = try! JSONSerialization.jsonObject(with: data as Data, options: .mutableContainers) as? [String:Any]
            else {
                resultsDict["Status"] = 404
                completion(resultsDict, nil)
                return
            }
            resultsDict["Status"] = 200
            resultsDict["Data"] = dict
        }
        else {
            resultsDict["Status"] = 404
        }
        
        completion(resultsDict, nil)
    }
    
    func downloadIcon(for name: String, completion: @escaping ([String:Any], Error?) -> Void) {
    
        var resultsDict:[String:Any] = [:]

        //construct path to icon for name
        let bundle = Bundle.init(for: MockRestAPI.self)
        //look it up and return dictionary wtih response
        if let iconPath = bundle.path(forResource: name, ofType: "png") {
            //look it up and return dictionary wtih response
            guard let data:NSData = try? NSData(contentsOfFile: iconPath)
            else {
                resultsDict["Status"] = 404
                completion(resultsDict, nil)
                return
            }
            
            resultsDict["Status"] = 200
            resultsDict["Data"] = data
        }
        else {
            resultsDict["Status"] = 404
        }
        
        completion(resultsDict, nil)
    }

}
