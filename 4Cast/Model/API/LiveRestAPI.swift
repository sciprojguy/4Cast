//
//  LiveRestAPI.swift
//  4Cast
//
//  Created by Chris Woodard on 5/13/18.
//  Copyright © 2018 SampleSoft. All rights reserved.
//

import Foundation

@objc class LiveRestAPI: NSObject, WeatherApi, URLSessionDelegate {

    var session:URLSession? = nil
    var queue:OperationQueue? = nil
    static let shared:LiveRestAPI = LiveRestAPI()
    
    private override init() {
        //set up url session in here
        super.init()

        self.queue = OperationQueue()
        self.queue?.maxConcurrentOperationCount = 4

        let config = URLSessionConfiguration.default
        config.allowsCellularAccess = true
        config.timeoutIntervalForRequest = 15
        config.timeoutIntervalForResource = 15
        config.networkServiceType = .default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        
        self.session = URLSession(configuration: config, delegate: self, delegateQueue: self.queue)
    }

    func encodedUrlString(str:String) -> String {
        let allowedChars = CharacterSet.alphanumerics
        return str.addingPercentEncoding(withAllowedCharacters: allowedChars)!
    }
    
    func forecast(for cityAndCountry: String, completion: @escaping ([String:Any]?, Error?) -> Void) {

        let encoded = self.encodedUrlString(str: cityAndCountry)
        if let urlString = URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=\(encoded)&units=imperial&appid=3a5a5533643dadd75a8c095541dea0ed") {
            var request = URLRequest(url: urlString)
            request.httpMethod = "GET"
            var resultsDict:[String:Any] = [:]
            let task = self.session?.dataTask(with: request, completionHandler: {data, response, error in
                if let rsp = response as? HTTPURLResponse {
                    resultsDict["Status"] = rsp.statusCode
                    if 200 == rsp.statusCode {
                        if let forecastData = data {
                            if let forecastDict = try? JSONSerialization.jsonObject(with: forecastData, options: .mutableContainers) as! [String : Any] {
                                resultsDict["Data"] = forecastDict
                            }
                        }
                        else {
                            resultsDict["Status"] = 500
                        }
                    }
                    else {
                    
                    }
                }
                completion(resultsDict, error)
            })
            task?.resume()
        }
    }
    
    func downloadIcon(for name: String, completion: @escaping ([String:Any], Error?) -> Void) {

       if let urlString = URL(string: "https://openweathermap.org/img/w/\(name).png") {
            var request = URLRequest(url: urlString)
            request.httpMethod = "GET"
            let task = self.session?.dataTask(with: request, completionHandler: {data, response, error in
                var responseDict:[String:Any] = [:]
                if let rsp = response as? HTTPURLResponse {
                    responseDict["Response"] = rsp
                    if 200 == rsp.statusCode {
                        if let imgData = data {
                            responseDict["Data"] = imgData
                        }
                    }
                }
                completion(responseDict, error)
            })
            task?.resume()
        }
    }
    

}
