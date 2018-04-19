//
//  ForecastListItem.swift
//  4Cast
//
//  Created by Chris Woodard on 3/25/18.
//  Copyright © 2018 SampleSoft. All rights reserved.
//

import Foundation

@objc public class ForecastListItem: NSObject, NSCopying {
    
    var dateTime: Date?

    var temp: Double = 0
    var tempMin: Double = 0
    var tempMax: Double = 0
    var pressure: Double = 0
    var seaLevel: Double = 0
    var grndLevel: Double = 0
    var humidity: Int = 0
    var tempK: Double = 0

    var idVal: Int? = nil
    var main:String = ""
    var weatherDescription:String = ""
    var descriptions:[String] = []
    var icon:String = ""

    var cloudsAll: Int? = nil

    var windSpeed: Double? = nil
    var windDirection: Double? = nil
    
    var rain_3hr:Double? = nil
    var snow_3hr:Double? = nil

    var pod:Int64? = nil

    override init() {}
    
    convenience init(from dict:[String:Any]) {
        self.init()
        
        if let dt = dict["dt"] as? TimeInterval {
            self.dateTime = Date(timeIntervalSince1970: dt)
        }

        if let main = dict["main"] as? [String:Any] {
            if let grndLevel = main["grnd_level"] as? Double {
                self.grndLevel = grndLevel
            }
            if let seaLevel = main["sea_level"] as? Double {
                self.seaLevel = seaLevel
            }
            if let pressure = main["pressure"] as? Double {
                self.pressure = pressure
            }
            if let humidity = main["humidity"] as? Int {
                self.humidity = humidity
            }
            if let temp = main["temp"] as? Double {
                self.temp = temp
            }
            if let tempK = main["temp_kf"] as? Double {
                self.tempK = tempK
            }
            if let tempMin = main["temp_min"] as? Double {
                self.tempMin = tempMin
            }
            if let tempMax = main["temp_max"] as? Double {
                self.tempMax = tempMax
            }
        }
        
        if let weather_conditions = dict["weather"] as? [[String:Any]] {
            if let first_condition = weather_conditions.first {
                if let icon_name = first_condition["icon"] {
                    self.icon = icon_name as! String
                }
            }
            var condition_descriptions:[String] = []
            for wc in weather_conditions {
                condition_descriptions.append(wc["description"] as! String)
            }
            self.weatherDescription = condition_descriptions.joined(separator: " / ")
            self.descriptions = condition_descriptions
        }
        
        if let wind = dict["wind"] as? [String:Any] {
            self.windSpeed = wind["speed"] as? Double ?? 0
            self.windDirection = wind["deg"] as? Double ?? 0
        }
        
        if let rain = dict["rain"] as? [String:Any] {
            self.rain_3hr = rain["3h"] as? Double ?? 0
        }

        if let snow = dict["snow"] as? [String:Any] {
            self.rain_3hr = snow["3h"] as? Double ?? 0
        }

        if let sys = dict["sys"] as? [String:Any] {
            self.pod = sys["pod"] as? Int64 ?? 0
        }
    }
    
    public func minTempF() -> Double {
        let tempC = self.tempMin - 273
        return 32.0 + tempC * 9.0/5.0
    }
    
    public func maxTempF() -> Double {
        let tempC = self.tempMax - 273
        return 32.0 + tempC * 9.0/5.0
    }
    
    @objc public func copy(with zone: NSZone? = nil) -> Any {
        return self.copy()
    }
}
