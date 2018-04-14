//
//  FiveDay3HourForecast.swift
//  4Cast
//
//  Created by Chris Woodard on 4/13/18.
//  Copyright © 2018 SampleSoft. All rights reserved.
//

import Foundation

@objc public class FiveDay3HourForecast: NSObject {

    var statusCode:Int = -1
    var statusMsg:String = ""
    var listCount:Int = 0
    var cityId:Int64? = nil
    var cityName:String? = nil
    var cityCountry:String? = nil
    var latitude:Double? = nil
    var longitude:Double? = nil
    var list:[[String:Any]] = []
    
    @objc func initFromDict(_ dict:[String:Any]) -> FiveDay3HourForecast? {
        if let code = dict["cod"] as? String {
            self.statusCode = Int(code)!
        }

        if let msg = dict["msg"] as? String {
            self.statusMsg = msg
        }

        if let cnt = dict["cnt"] as? Int {
            self.listCount = cnt
        }

        if let cityInfo = dict["city"] as? [String:Any] {
            self.cityId = cityInfo["id"] as? Int64 ?? 0
            self.cityName = cityInfo["name"] as? String ?? ""
            self.cityCountry = cityInfo["country"] as? String ?? ""
            if let coord = cityInfo["coord"] as? [String:Double] {
                self.latitude = coord["lat"]
                self.longitude = coord["lon"]
            }
        }

        if let forecastList = dict["list"] as? [[String:Any]] {
            self.list = forecastList
        }
        
        return self
    }
    
    @objc func initFromJson(_ json:Data) -> FiveDay3HourForecast? {
    
        do {
        
            if let dict = try JSONSerialization.jsonObject(with: json, options: .mutableContainers) as? [String : Any] {
            
                if let code = dict["cod"] as? String {
                    self.statusCode = Int(code)!
                }
                
                if let msg = dict["msg"] as? String {
                    self.statusMsg = msg
                }
                
                if let cnt = dict["cnt"] as? Int {
                    self.listCount = cnt
                }
                
                if let cityInfo = dict["city"] as? [String:Any] {
                    self.cityId = cityInfo["id"] as? Int64 ?? 0
                    self.cityName = cityInfo["name"] as? String ?? ""
                    self.cityCountry = cityInfo["country"] as? String ?? ""
                    if let coord = cityInfo["coord"] as? [String:Double] {
                        self.latitude = coord["lat"]
                        self.longitude = coord["lon"]
                    }
                }
                
                if let forecastList = dict["list"] as? [[String:Any]] {
                    self.list = forecastList
                }
            }
        }
        catch {
            
        }
        
        return self
    }
    
    @objc func itemAtIndex(_ index:Int) -> ForecastListItem? {
        if index >= 0 && index < self.listCount {
            let entry = self.list[index]
            return ForecastListItem(from: entry)
        }
        return nil
    }
}
