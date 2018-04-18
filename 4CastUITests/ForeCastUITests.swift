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
        //todo: set launch argument to send "USE_MOCK"
        let app = XCUIApplication()
        app.launchEnvironment = ["USE_MOCK" : "true"]
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLoadTampaForecast() {
    
        let app = XCUIApplication()

        let label = app.staticTexts["CityAndCountry"]
        XCTAssert(label.exists, "Label CityAndCountry does not exist")

        let searchField = app.otherElements["SearchField"]
        searchField.tap()
        sleep(1)
        searchField.typeText("Tampa,USA\n")
        
        let isTampa = NSPredicate(format: "value CONTAINS 'Tampa'")
        
        let e = expectation(for: isTampa, evaluatedWith: label, handler: nil)
        _ = XCTWaiter.wait(for: [e], timeout: 30)

        XCTAssert("Tampa" == (label.value as? String), "Wrong value: \(label.value as? String ?? "")")
    }
    
    func testLoadNewYorkForecast() {
    
        let app = XCUIApplication()
        
        sleep(5)

        let label = app.staticTexts["CityAndCountry"]
        XCTAssert(label.exists, "Label CityAndCountry does not exist")

        let searchField = app.otherElements["SearchField"]
        searchField.tap()
        sleep(2)
        searchField.typeText("New York,USA\n")
        sleep(1)
        
        let isNewYork = NSPredicate(format: "value CONTAINS 'New York'")
        
        let e = expectation(for: isNewYork, evaluatedWith: label, handler: nil)
        _ = XCTWaiter.wait(for: [e], timeout: 5)

        XCTAssert("New York" == (label.value as? String), "Wrong value: \(label.value as? String ?? "")")
    }
    
    func testTryToLoadChicagoForecast() {
    
        let app = XCUIApplication()
        
        sleep(5)

        let label = app.staticTexts["CityAndCountry"]
        XCTAssert(label.exists, "Label CityAndCountry does not exist")

        let searchField = app.otherElements["SearchField"]
        searchField.tap()
        sleep(2)
        searchField.typeText("Chicago,USA\n")
        sleep(1)
        
        let isChicago = NSPredicate(format: "value CONTAINS 'Chicago'")
        
        let e = expectation(for: isChicago, evaluatedWith: label, handler: nil)
        _ = XCTWaiter.wait(for: [e], timeout: 5)

        XCTAssert("Chicago" != (label.value as? String), "Wrong value: \(label.value as? String ?? "")")
    }

    //"helper" methods to make tests more compact.  better helper
    func tapOnRow(at index:Int, app:XCUIApplication) {
        app.tables.children(matching: .cell).element(boundBy: 0).staticTexts["ForecastDescription"].tap()
    }
        
    func testLoadNYForecastGetFirstDetail() {
        
        let app = XCUIApplication()

        let label = app.staticTexts["CityAndCountry"]
        XCTAssert(label.exists, "Label CityAndCountry does not exist")

        let searchField = app.otherElements["SearchField"]
        searchField.tap()
        sleep(2)
        searchField.typeText("New York,USA\n")
        sleep(1)
        
        let isNewYork = NSPredicate(format: "value CONTAINS 'New York'")
        
        let e = expectation(for: isNewYork, evaluatedWith: label, handler: nil)
        _ = XCTWaiter.wait(for: [e], timeout: 5)

        XCTAssert("New York" == (label.value as? String), "Wrong value: \(label.value as? String ?? "")")

        self.tapOnRow(at:0, app: app)
        sleep(2)
        
        //todo: wait for label to appear
        
    }
    
    func testLoadNYForecastGetSecondDetail() {
        let app = XCUIApplication()
        
    }

    func testLoadTampaForecastGetFirstDetail() {
        let app = XCUIApplication()
        
    }
    
    func testLoadTampaForecastGetSecondDetail() {
        let app = XCUIApplication()
        
    }
}
