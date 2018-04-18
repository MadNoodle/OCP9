//
//  SettingsControllerDelegate.swift
//  leBaluchon
//
//  Created by Mathieu Janneau on 18/04/2018.
//  Copyright © 2018 Mathieu Janneau. All rights reserved.
//

import Foundation

enum Settings {
  case location
  case currency
  case language
}

extension Settings: RawRepresentable {
  typealias RawValue = (String, String, String, String)
  
  init?(rawValue: RawValue) {
    switch rawValue {
    case ("homeLanguage", "awayLanguage", "homeLanguageIndex", "awayLanguageIndex"): self = .language
    case ("homeCity", "awayCity", "homeCityIndex", "awayCityIndex"): self = .location
    case ("homeCurrency", "awayCurrency", "homeCurrencyIndex", "awayCurrencyIndex"): self = .currency
    default: return nil
    }
  }
  
  var rawValue: RawValue {
    switch self {
    case .location: return ("homeCity", "awayCity", "homeCityIndex", "awayCityIndex")
    case .currency: return ("homeCurrency", "awayCurrency", "homeCurrencyIndex", "awayCurrencyIndex")
    case .language: return ("homeLanguage", "awayLanguage", "homeLanguageIndex", "awayLanguageIndex")
    }
  }
}
