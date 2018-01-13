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
 
  static func loadUpdateDate() -> Date {
    return defaults.object(forKey:"lastUpdate") as! Date
  }
  
  static func saveDate(newupdateTime: Date){
    defaults.set(newupdateTime,forKey:"lastUpdate")
  }
  
  static func loadDate() -> Date {
    return  defaults.object(forKey:"lastUpdate") as! Date
  }
  // a tester
  static func saveData(displayKey:String, value:String, indexKey:String, index:Int) {
    defaults.set(value,forKey: displayKey)
    defaults.set(index,forKey: indexKey)
  }
  // a tester
  static func saveLocation(locationCityKey:String, locationCityValue:String, locationCountryKey:String, locationCountryValue:String) {
    defaults.set(locationCountryValue,forKey: locationCityKey)
    defaults.set(locationCountryValue,forKey: locationCountryKey)
  }
  // a tester
  static func loadLocation(locationCityKey:String, locationCountryKey: String) -> (String?,String?) {
    let city = defaults.object(forKey:locationCityKey) as? String
    let country = defaults.object(forKey:locationCountryKey) as? String
    return (city,country)
  }
  // a tester
  static func loadData(displayKey:String, indexKey:String) -> (Int,Int) {
    let strValue = defaults.integer(forKey:displayKey)
    let indxValue = defaults.integer(forKey:indexKey)
    return (strValue,indxValue)
  }
}
