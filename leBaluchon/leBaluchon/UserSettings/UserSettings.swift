//
//  UserSettings.swift
//  leBaluchon
//
//  Created by Mathieu Janneau on 06/01/2018.
//  Copyright © 2018 Mathieu Janneau. All rights reserved.
//

import Foundation

/**
 Handles storing and retrieving for user preferences
 */
class UserSettings {
  static let defaults = UserDefaults.standard
  static var lastUpdate:Date? 
  static var homeLanguage = ""
  static var awayLanguage = ""
  static var homeCity = ""
  static var awayCity = ""
  
  // stores data in user defaults
  static func saveSettings(newupdateTime: Date,newHomeLanguage: String,newAwayLanguage: String,newHomeCity: String, newAwayCity: String){
    defaults.set(newupdateTime,forKey:"lastUpdate")
    defaults.set(newHomeLanguage,forKey:"homeLanguage")
    defaults.set(newAwayLanguage,forKey:"AwayLanguage")
    defaults.set(newHomeCity,forKey:"homeCity")
    defaults.set(newAwayCity,forKey:"AwayCity")
  }
  
  // Loads settings from UserDefaults to a dictionnary
  static func loadUserSettings() -> [String : Any]{
    let settings : [String:Any] = [
      "homeLanguage":  defaults.object(forKey:"homeLanguage") as! String,
      "AwayLanguage":  defaults.object(forKey:"AwayLanguage") as! String,
      "homeCity":     defaults.object(forKey:"homeCity") as! String,
      "AwayCity":     defaults.object(forKey:"AwayCity") as! String,
      "lastUpdate": defaults.object(forKey:"lastUpdate") as! Date
    ]
    return settings
  }
}
