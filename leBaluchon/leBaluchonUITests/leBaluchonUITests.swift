//
//  leBaluchonUITests.swift
//  leBaluchonUITests
//
//  Created by Mathieu Janneau on 03/01/2018.
//  Copyright © 2018 Mathieu Janneau. All rights reserved.
//

import XCTest

class leBaluchonUITests: XCTestCase {
        
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
    
    func testTabBarNavigationByTapping() {
      let app = XCUIApplication()
      let tabBarsQuery = XCUIApplication().tabBars
      let currencyButton = tabBarsQuery.buttons["Currency"]
      currencyButton.tap()
      XCTAssert(app.navigationBars["Currency"].exists)
      tabBarsQuery.buttons["Translation"].tap()
      XCTAssert(app.navigationBars["Translation"].exists)
      tabBarsQuery.buttons["Settings"].tap()
      XCTAssert(app.navigationBars["Settings"].exists)
      tabBarsQuery.buttons["Weather"].tap()
      XCTAssert(app.navigationBars["Weather"].exists)
    }
  
  func testTabBarNavigationBySwiping() {
    let app = XCUIApplication()
          XCTAssert(app.navigationBars["Weather"].exists)
    app.staticTexts["Asnières-sur-Seine"].swipeLeft()
          XCTAssert(app.navigationBars["Currency"].exists)
    app.staticTexts["0 EUR"].swipeLeft()
          XCTAssert(app.navigationBars["Translation"].exists)
    let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
    element.children(matching: .other).element(boundBy: 0).swipeLeft()
      XCTAssert(app.navigationBars["Settings"].exists)
  }
  
    
}
