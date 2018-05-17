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
    override init() {
        super.init()
    }
    
    var errorProfile:[String:[String:Any]] = [:]
    
    func loadProfile(_ name:String) {
        let bundle = Bundle(for: MockRestAPI.self)
        if let profilePath = bundle.path(forResource: name, ofType: "json") {
            if let profileData = try? Data(contentsOf: URL(fileURLWithPath: profilePath)) {
                if let profileDict = try? JSONSerialization.jsonObject(with: profileData, options: .mutableContainers) as! [String:[String:Any]] {
                    self.errorProfile = profileDict
                }
            }
        }
    }
    
    func clearProfile() {
        self.errorProfile = [:]
    }
    
    func resultsFromProfileEntry(request:String) -> [String:Any]? {
    
        guard let entry = self.errorProfile[request]
        else {
            return nil
        }
        
        //check for error
        if let error = entry["error"] as? String {
            if "no_network" == error {
                return ["Status" : 0, "Error" : NSError(domain: NSURLErrorDomain, code: NSURLErrorNotConnectedToInternet, userInfo: nil)]
            }
            else
            if "lost_network" == error {
                return ["Status" : 0, "Error" : NSError(domain: NSURLErrorDomain, code: NSURLErrorNetworkConnectionLost, userInfo: nil)]
            }
        }
        
        //if no error, generate from status
        if let status = entry["status"] as? Int {
            return ["Status" : status]
        }
        
        return [:]
    }
    
    func forecast(for cityAndCountry: String, completion: @escaping ([String:Any]?, Error?) -> Void) {
    
        var resultsDict:[String:Any] = [:]
        
        //check to see if we have an error profile for this request
        //if we do, generate & return resultsDict[:] for it
        if let errorDict = self.resultsFromProfileEntry(request: "forecast") {
            completion(errorDict, errorDict["Error"] as? Error)
            return
        }
        
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

        //check to see if we have an error profile for this request
        //if we do, generate & return resultsDict[:] for it
        if let errorDict = self.resultsFromProfileEntry(request: "downloadIcon") {
            completion(errorDict, errorDict["Error"] as? Error)
            return
        }

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
