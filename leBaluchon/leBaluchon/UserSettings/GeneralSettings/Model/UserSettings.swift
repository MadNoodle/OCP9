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
  // MARK: - Properties
  
   /// Invoke UserDefaults
  static let defaults = UserDefaults.standard
 
  
  // MARK: - Methods
  
//  /**
// Retrieve lastupdate date from persistent memory
//   - returns: Date
//   */
//  static func loadUpdateDate() -> Date {
//    return defaults.object(forKey:"lastUpdate") as! Date
//  }
//  
//  
//  /**
//   Save lastupdate date from persistent memory
//   - parameters:
//      - newUpdateTime: Date.
//   Actual date when fetching currency from server
//   - returns: Date
//   */
//  static func saveDate(newupdateTime: Date){
//  defaults.set(newupdateTime,forKey:"lastUpdate")
//  }
//  

  /**
   Save data date from persistent memory
   - parameters:
       - displayKey: String. Name of the key for persistent container
       - value: String
       - indexKey: String. Name for of the key for persistent container
       - index: Int
   */
  static func saveData(displayKey:String, value:String, indexKey:String, index:Int) {
    defaults.set(value,forKey: displayKey)
    defaults.set(index,forKey: indexKey)
  }

  
  /**
   Save data date from persistent memory
   - parameters:
     - displayKey: String. Name of the key to retrieve for persistent container
     - indexKey: String. Name for of the key to retrieve for persistent container
   - returns:(Int,Int)
   */
  static func loadData(displayKey:String, indexKey:String) -> (Int,Int) {
    let strValue = defaults.integer(forKey:displayKey)
    let indxValue = defaults.integer(forKey:indexKey)
    return (strValue,indxValue)
  }
}
