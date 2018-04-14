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
    
    func testExample() {
        // Use recording to get started writing UI tests.
        
        let app = XCUIApplication()
        app.sheets["Error"].buttons["Okay"].tap()
        app.navigationBars["Forecast"].buttons["Search"].tap()
        app.textFields["Enter city,country here"].tap()
        app.buttons["Go"].tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Apr 14 18 02:00 PM")/*[[".cells.containing(.staticText, identifier:\"High: 89.0 ºF\")",".cells.containing(.staticText, identifier:\"Low: 87.7 ºF\")",".cells.containing(.staticText, identifier:\"Apr 14 18 02:00 PM\")"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["clear sky"].tap()
        
        let tampaButton = app.navigationBars["Details"].buttons["Tampa"]
        tampaButton.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Apr 14 18 08:00 PM")/*[[".cells.containing(.staticText, identifier:\"High: 84.4 ºF\")",".cells.containing(.staticText, identifier:\"Low: 83.8 ºF\")",".cells.containing(.staticText, identifier:\"Apr 14 18 08:00 PM\")"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["clear sky"].tap()
        tampaButton.tap()
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
