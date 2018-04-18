//
//  UserSettingsTests.swift
//  leBaluchonTests
//
//  Created by Mathieu Janneau on 06/01/2018.
//  Copyright © 2018 Mathieu Janneau. All rights reserved.
//

import XCTest
@testable import leBaluchon

class UserSettingsTests: XCTestCase {
  
  var dummyData: [String: Any] = [
  "newupdateTime": Date(),
  "newHomeLanguage": "fr",
  "newAwayLanguage": "en",
  "newHomeCity": "Paris",
  "newAwayCity": "NewYork"]
  
  func testsaveData() {
    UserSettings.saveData(displayKey: "test", value: "testValue", indexKey: "testKey", index: 1)
    let testvalue1 = UserDefaults.standard.object(forKey: "test") as? String
    let testvalue2 = UserDefaults.standard.integer(forKey: "testKey")
    XCTAssertEqual(testvalue1, "testValue")
    XCTAssertEqual(testvalue2, 1)
  }
  func testLoadData() {
    UserSettings.saveData(displayKey: "test", value: "testValue", indexKey: "testKey", index: 1)
    let testvalue1 = UserSettings.loadData(displayKey: "test", indexKey: "testKey")
    XCTAssertEqual(testvalue1.0, 0)
    XCTAssertEqual(testvalue1.1, 1)
  }
    
}
