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
  
  var dummyData : [String : Any] = [
  "newupdateTime": Date(),
  "newHomeLanguage": "fr",
  "newAwayLanguage": "en",
  "newHomeCity": "Paris",
  "newAwayCity": "NewYork"]
  
  func testStoringUserSettings() {
    UserSettings.saveSettings(
      newupdateTime: dummyData["newupdateTime"] as! Date,
      newHomeLanguage: dummyData["newHomeLanguage"] as! String,
      newAwayLanguage: dummyData["newAwayLanguage"] as! String,
      newHomeCity: dummyData["newHomeCity"] as! String,
      newAwayCity: dummyData["newAwayCity"] as! String
    )
    let testValue = UserDefaults.standard.object(forKey:"homeLanguage") as! String
    XCTAssert(testValue == "fr")
    
  }
  
  func testGettingUserSettings() {
    UserSettings.saveSettings(
      newupdateTime: dummyData["newupdateTime"] as! Date,
      newHomeLanguage: dummyData["newHomeLanguage"] as! String,
      newAwayLanguage: dummyData["newAwayLanguage"] as! String,
      newHomeCity: dummyData["newHomeCity"] as! String,
      newAwayCity: dummyData["newAwayCity"] as! String
    )
   let settings = UserSettings.loadUserSettings()
    let language = settings["homeLanguage"] as! String
    XCTAssert( language == "fr")
    
  }
    
}
