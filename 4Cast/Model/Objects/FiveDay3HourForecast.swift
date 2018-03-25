//
//  FiveDay3HourForecast.swift
//  4Cast
//
//  Created by Chris Woodard on 3/25/18.
//  Copyright © 2018 SampleSoft. All rights reserved.
//
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try Welcome(json)

import Foundation

@objc class FiveDay3HourForecast: NSObject, Codable {
    let cod: String
    let message: Double
    let cnt: Int
    let list: [ForecastListItem]
    let city: City

    init(cod: String, message: Double, cnt: Int, list: [ForecastListItem], city: City) {
        self.cod = cod
        self.message = message
        self.cnt = cnt
        self.list = list
        self.city = city
    }
}

@objc class City: NSObject, Codable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String

    init(id: Int, name: String, coord: Coord, country: String) {
        self.id = id
        self.name = name
        self.coord = coord
        self.country = country
    }
}

@objc class Coord: NSObject, Codable {
    let lat, lon: Double

    init(lat: Double, lon: Double) {
        self.lat = lat
        self.lon = lon
    }
}

@objc class ForecastListItem: NSObject, Codable {
    let dt: Int
    let main: ListMain
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let sys: Sys
    let dtTxt: String
    let rain, snow: Rain?

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, sys
        case dtTxt = "dt_txt"
        case rain, snow
    }

    init(dt: Int, main: ListMain, weather: [Weather], clouds: Clouds, wind: Wind, sys: Sys, dtTxt: String, rain: Rain?, snow: Rain?) {
        self.dt = dt
        self.main = main
        self.weather = weather
        self.clouds = clouds
        self.wind = wind
        self.sys = sys
        self.dtTxt = dtTxt
        self.rain = rain
        self.snow = snow
    }
}

@objc class Clouds: NSObject, Codable {
    let all: Int

    init(all: Int) {
        self.all = all
    }
}

@objc class ListMain: NSObject, Codable {
    let temp, tempMin, tempMax, pressure: Double
    let seaLevel, grndLevel: Double
    let humidity: Int
    let tempKf: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }

    init(temp: Double, tempMin: Double, tempMax: Double, pressure: Double, seaLevel: Double, grndLevel: Double, humidity: Int, tempKf: Double) {
        self.temp = temp
        self.tempMin = tempMin
        self.tempMax = tempMax
        self.pressure = pressure
        self.seaLevel = seaLevel
        self.grndLevel = grndLevel
        self.humidity = humidity
        self.tempKf = tempKf
    }
}

@objc class Rain: NSObject, Codable {
    let the3H: Double?

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }

    init(the3H: Double?) {
        self.the3H = the3H
    }
}

@objc class Sys: NSObject, Codable {
    let pod: Pod

    init(pod: Pod) {
        self.pod = pod
    }
}

enum Pod: String, Codable {
    case d = "d"
    case n = "n"
}

@objc class Weather: NSObject, Codable {
    let id: Int
    let main: WeatherMain
    let weatherDescription: Description
    let icon: String

    init(id: Int, main: WeatherMain, description: Description, icon: String) {
        self.id = id
        self.main = main
        self.description = description
        self.icon = icon
    }
}

enum Description: String, Codable {
    case brokenClouds = "broken clouds"
    case clearSky = "clear sky"
    case fewClouds = "few clouds"
    case lightRain = "light rain"
    case moderateRain = "moderate rain"
}

enum WeatherMain: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
}

class Wind: Codable {
    let speed, deg: Double

    init(speed: Double, deg: Double) {
        self.speed = speed
        self.deg = deg
    }
}

// MARK: Convenience initializers

extension FiveDay3HourForecast {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(FiveDay3HourForecast.self, from: data)
        self.init(cod: me.cod, message: me.message, cnt: me.cnt, list: me.list, city: me.city)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension City {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(City.self, from: data)
        self.init(id: me.id, name: me.name, coord: me.coord, country: me.country)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Coord {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(Coord.self, from: data)
        self.init(lat: me.lat, lon: me.lon)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension ForecastListItem {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(ForecastListItem.self, from: data)
        self.init(dt: me.dt, main: me.main, weather: me.weather, clouds: me.clouds, wind: me.wind, sys: me.sys, dtTxt: me.dtTxt, rain: me.rain, snow: me.snow)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Clouds {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(Clouds.self, from: data)
        self.init(all: me.all)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension ListMain {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(ListMain.self, from: data)
        self.init(temp: me.temp, tempMin: me.tempMin, tempMax: me.tempMax, pressure: me.pressure, seaLevel: me.seaLevel, grndLevel: me.grndLevel, humidity: me.humidity, tempKf: me.tempKf)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Rain {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(Rain.self, from: data)
        self.init(the3H: me.the3H)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Sys {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(Sys.self, from: data)
        self.init(pod: me.pod)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Weather {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(Weather.self, from: data)
        self.init(id: me.id, main: me.main, description: me.description, icon: me.icon)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Wind {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(Wind.self, from: data)
        self.init(speed: me.speed, deg: me.deg)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
