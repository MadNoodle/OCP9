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
  static func saveSettings(newupdateTime: Date,newHomeLanguage: Int,newAwayLanguage: String,newHomeCity: Int, newAwayCity: String){
    defaults.set(newupdateTime,forKey:"lastUpdate")
    defaults.set(newHomeLanguage,forKey:"homeLanguage")
    defaults.set(newAwayLanguage,forKey:"AwayLanguage")
    defaults.set(newHomeCity,forKey:"homeCity")
    defaults.set(newAwayCity,forKey:"AwayCity")
  }
  
  // Loads settings from UserDefaults to a dictionnary
  static func loadUserSettings() -> [String : Any]{
    let settings : [String:Any] = [
      "homeLanguage":  defaults.object(forKey:"homeLanguage") as! Int,
      "AwayLanguage":  defaults.object(forKey:"AwayLanguage") as! Int,
      "homeCity":     defaults.object(forKey:"homeCity") as! String,
      "AwayCity":     defaults.object(forKey:"AwayCity") as! String,
      "lastUpdate": defaults.object(forKey:"lastUpdate") as! Date
    ]
    return settings
  }
  
  static func saveDate(newupdateTime: Date){
    defaults.set(newupdateTime,forKey:"lastUpdate")
  }
  
  static func loadDate() -> Date {
    return  defaults.object(forKey:"lastUpdate") as! Date
  }
// a tester
  static func  saveData(displayKey:String, value:String, indexKey:String, index:Int) {
    defaults.set(value,forKey: displayKey)
    defaults.set(index,forKey: indexKey)
  }
  
  // a tester
  static func  loadData(displayKey:String, indexKey:String) -> (Int,Int) {
    let strValue = defaults.integer(forKey:displayKey)
    let indxValue = defaults.integer(forKey:indexKey)
    return (strValue,indxValue)
  }
}
