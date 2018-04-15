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
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLoadTampaForecast() {
    
        let app = XCUIApplication()
        
        sleep(5)

        let label = app.staticTexts["CityAndCountry"]
        XCTAssert(label.exists, "Label CityAndCountry does not exist")
        XCTAssert( "New York" == (label.value as? String), "Wrong value")

        //find our way to the search box & "Go" button
        app.navigationBars["Forecast"].buttons["Search"].tap()
        let searchBar = app.searchFields.element
        
        searchBar.tap()
        sleep(2)
        searchBar.typeText("Tampa,USA\n")
        sleep(1)
        
        let isTampa = NSPredicate(format: "value CONTAINS 'Tampa'")
        
        let e = expectation(for: isTampa, evaluatedWith: label, handler: nil)
        XCTWaiter.wait(for: [e], timeout: 5)

        XCTAssert("Tampa" == (label.value as? String), "Wrong value: \(label.value as? String)")
    }
    
    func testLoadNewYorkForecast() {
    
        let app = XCUIApplication()
        
        sleep(5)

        let label = app.staticTexts["CityAndCountry"]
        XCTAssert(label.exists, "Label CityAndCountry does not exist")
        XCTAssert( "New York" == (label.value as? String), "Wrong value")

        //find our way to the search box & "Go" button
        app.navigationBars["Forecast"].buttons["Search"].tap()
        let searchBar = app.searchFields.element
        
        searchBar.tap()
        sleep(2)
        searchBar.typeText("New York,USA\n")
        sleep(1)
        
        let isTampa = NSPredicate(format: "value CONTAINS 'New York'")
        
        let e = expectation(for: isTampa, evaluatedWith: label, handler: nil)
        XCTWaiter.wait(for: [e], timeout: 5)

        XCTAssert("New York" == (label.value as? String), "Wrong value: \(label.value as? String)")
    }
    
    func testTryToLoadChicagoForecast() {
    
    }
    
    func testLoadTampaForecastGetFirstDetail() {
    
    }
    
    func testLoadTampaForecastGetSecondDetail() {
    
    }
}
