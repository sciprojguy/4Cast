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
  
    //MARK: - helper methods -

    func loadForecast(city:String, country:String, app:XCUIApplication) {
        let cityAndCountry = "\(city),\(country)"
        let label = app.staticTexts["ForecastCity"]
        XCTAssert(label.exists, "Label with AID ForecastCity does not exist")

        let searchField = app.otherElements["SearchField"]
        searchField.tap()
        sleep(1)
        searchField.typeText("\(cityAndCountry)\n")
        
        waitForLabel(with: "ForecastCity", value: city, app: app)
    }
    
    func waitForLabel(with labelId:String, value:String, app:XCUIApplication) {
    
        let label = app.staticTexts[labelId]
        
        let isFound = NSPredicate(format: "value CONTAINS '\(value)'")
        
        let e = expectation(for: isFound, evaluatedWith: label, handler: nil)
        _ = XCTWaiter.wait(for: [e], timeout: 5)

        XCTAssert(value == (label.value as? String), "Wrong value: \(label.value as? String ?? "")")
    }
    
    func tapOnForecastCell(at index:Int, app:XCUIApplication) {
        let cell = app.tables.children(matching: .cell).element(boundBy: index).staticTexts["ForecastDescription"]
        cell.tap()
    }

    func valueFromForecastCell(at index:Int, label:String, app:XCUIApplication) -> String? {
        let labelValue = app.tables.children(matching: .cell).element(boundBy: index).staticTexts["ForecastDescription"]
        return (labelValue.value as! String?)
    }
    
    func checkLabel(with labelId:String, value:String) {
    
    }
    
    //MARK: - tests begin -
    
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
        
        //get description from cell
        if let description = valueFromForecastCell(at: 0, label: "ForecastDescription", app: app) {
            
            //tap on first cell
            tapOnForecastCell(at:0, app: app)
            
            //wait for label to appear containing value
            waitForLabel(with: "DetailDescription", value: description, app: app)
        }
    }
    
    func testLoadNYForecastGetSecondDetail() {
        let app = XCUIApplication()
        
        //load the mock forecast data
        loadForecast(city:"New York", country:"USA", app: app)
        
        if let description = valueFromForecastCell(at: 1, label: "ForecastDescription", app: app) {
            
            //tap on second cell
            tapOnForecastCell(at:1, app: app)
        
            //wait for label to appear containing value
            waitForLabel(with: "DetailDescription", value: description, app: app)
        }
    }
    
    func testLoadNYForecastGetThirdDetail() {
        let app = XCUIApplication()
        
        //load the mock forecast data
        loadForecast(city:"New York", country:"USA", app: app)
        
        if let description = valueFromForecastCell(at: 2, label: "ForecastDescription", app: app) {
            
            //tap on third cell
            tapOnForecastCell(at:2, app: app)
        
            //wait for label to appear containing value
            waitForLabel(with: "DetailDescription", value: description, app: app)
        }
    }

    func testLoadTampaForecastGetFirstDetail() {
        let app = XCUIApplication()
        
        //load the mock forecast data
        loadForecast(city:"Tampa", country:"USA", app: app)

        //get description from cell
        if let description = valueFromForecastCell(at: 0, label: "ForecastDescription", app: app) {
            
            //tap on first cell
            tapOnForecastCell(at:0, app: app)
            
            //wait for label to appear containing value
            waitForLabel(with: "DetailDescription", value: description, app: app)
        }
    }
    
    func testLoadTampaForecastGetSecondDetail() {
        let app = XCUIApplication()
        
        //load the mock forecast data
        loadForecast(city:"Tampa", country:"USA", app: app)

        //get description from cell
        if let description = valueFromForecastCell(at: 0, label: "ForecastDescription", app: app) {
            
            //tap on second cell
            tapOnForecastCell(at:1, app: app)
            
            //wait for label to appear containing value
            waitForLabel(with: "DetailDescription", value: description, app: app)
        }
    }
    
    func testLoadTampaForecastGetThirdDetail() {
        let app = XCUIApplication()
        
        //load the mock forecast data
        loadForecast(city:"Tampa", country:"USA", app: app)
        
        //get description from cell
        if let description = valueFromForecastCell(at: 0, label: "ForecastDescription", app: app) {
            
            //tap on third cell
            tapOnForecastCell(at:2, app: app)
            
            //wait for label to appear containing value
            waitForLabel(with: "DetailDescription", value: description, app: app)
        }
    }
}
