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
  
  // /////////////////// //
  // MARK: - Properties //
  // ////////////////// //
  
  /// Invoke UserDefaults
  static let defaults = UserDefaults.standard
 
  // /////////////// //
  // MARK: - Methods //
  // /////////////// //

  /// Save data date from persistent memory
  ///
  /// - Parameters:
  ///   - displayKey: String. Name of the key for persistent container
  ///   - value: String
  ///   - indexKey: String. Name for of the key for persistent container
  ///   - index: Int
  static func saveData(displayKey:String, value:String, indexKey:String, index:Int) {
    defaults.set(value,forKey: displayKey)
    defaults.set(index,forKey: indexKey)
  }

  
  /// Save data date from persistent memory
  ///
  /// - Parameters:
  ///   - displayKey: String. Name of the key to retrieve for persistent container
  ///   - indexKey: Name for of the key to retrieve for persistent container
  /// - Returns: (Int,Int)
  static func loadData(displayKey:String, indexKey:String) -> (Int,Int) {
    let strValue = defaults.integer(forKey:displayKey)
    let indxValue = defaults.integer(forKey:indexKey)
    return (strValue,indxValue)
  }
  
  /// Reset all settings to initial state
  static func resetToFactory(){
    UserSettings.saveData(displayKey: "awayCurrency", value: "USD", indexKey: "awayCurrencyKey", index: 1)
    UserSettings.saveData(displayKey: "homeCurrency", value: "EUR", indexKey: "homeCurrencyKey", index: 0)
    UserSettings.saveData(displayKey: "awayCity", value: "New York", indexKey: "awayCityKey", index: 1)
    UserSettings.saveData(displayKey: "homeCity", value: "Paris", indexKey: "homeCityKey", index: 0)
    UserSettings.saveData(displayKey: "awayLanguage", value: "en", indexKey: "awayLanguageKey", index: 24)
    UserSettings.saveData(displayKey: "homeLanguage", value: "fr", indexKey: "homeLanguageKey", index: 22)
    
  }
}
