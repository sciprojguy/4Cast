//
//  _CastUITests.swift
//  4CastUITests
//
//  Created by Chris Woodard on 4/14/18.
//  Copyright © 2018 SampleSoft. All rights reserved.
//

import XCTest

class ForeCastUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        
        let app = XCUIApplication()
        
        //set an environment variable to get the UI test version
        //to use mock JSON instead of a network call.
        app.launchEnvironment = ["USE_MOCK" : "true"]
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
  
    //helper method to shorten tests
    func loadForecast(city:String, country:String, app:XCUIApplication) {
        let cityAndCountry = "\(city),\(country)"
        let label = app.staticTexts["CityAndCountry"]
        XCTAssert(label.exists, "Label CityAndCountry does not exist")

        let searchField = app.otherElements["SearchField"]
        searchField.tap()
        sleep(1)
        searchField.typeText("\(cityAndCountry)\n")
        
        let isCity = NSPredicate(format: "value CONTAINS '\(city)'")
        
        let e = expectation(for: isCity, evaluatedWith: label, handler: nil)
        _ = XCTWaiter.wait(for: [e], timeout: 5)

        XCTAssert(city == (label.value as? String), "Wrong city: \(label.value as? String ?? "")")
    }
    
    func tapOnForecastCell(at index:Int, app:XCUIApplication) {
        app.tables.children(matching: .cell).element(boundBy: index).staticTexts["ForecastDescription"].tap()
    }

    func testLoadTampaForecast() {
    
        let app = XCUIApplication()

        //load the mock forecast data
        loadForecast(city:"Tampa", country:"USA", app: app)
    }
    
    func testLoadNewYorkForecast() {
    
        let app = XCUIApplication()
        
        //load the mock forecast data
        loadForecast(city:"New York", country:"USA", app: app)
    }
    
    func testLoadNYForecastGetFirstDetail() {
        
        let app = XCUIApplication()
        
        //load the mock forecast data
        loadForecast(city:"New York", country:"USA", app: app)
        
        //tap on first cell
        tapOnForecastCell(at:0, app: app)
        
        //todo: wait for label to appear
        //todo: check for proper date and time
        //todo: check for proper temperature
    }
    
    func testLoadNYForecastGetSecondDetail() {
        let app = XCUIApplication()
        
        //load the mock forecast data
        loadForecast(city:"New York", country:"USA", app: app)
        
        //tap on second cell
        tapOnForecastCell(at:1, app: app)
        
        //todo: wait for label to appear
        //todo: check for proper date and time
        //todo: check for proper temperature
    }
    
    func testLoadNYForecastGetThirdDetail() {
        let app = XCUIApplication()
        
        //load the mock forecast data
        loadForecast(city:"New York", country:"USA", app: app)
        
        //tap on third cell
        tapOnForecastCell(at:2, app: app)
        
        //todo: wait for label to appear
        //todo: check for proper date and time
        //todo: check for proper temperature
    }

    func testLoadTampaForecastGetFirstDetail() {
        let app = XCUIApplication()
        
        //load the mock forecast data
        loadForecast(city:"Tampa", country:"USA", app: app)

        //tap on third cell
        tapOnForecastCell(at:2, app: app)
        
        //todo: wait for label to appear
        //todo: check for proper date and time
        //todo: check for proper temperature
    }
    
    func testLoadTampaForecastGetSecondDetail() {
        let app = XCUIApplication()
        
        //load the mock forecast data
        loadForecast(city:"Tampa", country:"USA", app: app)

        //tap on third cell
        tapOnForecastCell(at:2, app: app)
        
        //todo: wait for label to appear
        //todo: check for proper date and time
        //todo: check for proper temperature
    }
    
    func testLoadTampaForecastGetThirdDetail() {
        let app = XCUIApplication()
        
        //load the mock forecast data
        loadForecast(city:"Tampa", country:"USA", app: app)
        
        //tap on third cell
        tapOnForecastCell(at:2, app: app)
        
        //todo: wait for label to appear
        //todo: check for proper date and time
        //todo: check for proper temperature
    }
}
