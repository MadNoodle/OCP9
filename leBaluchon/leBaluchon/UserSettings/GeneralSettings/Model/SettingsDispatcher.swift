//
//  SettingsDispatcher.swift
//  leBaluchon
//
//  Created by Mathieu Janneau on 19/04/2018.
//  Copyright © 2018 Mathieu Janneau. All rights reserved.
//

import Foundation

/// Enum to choose which Settings Controllers to show
enum Settings {
  case location
  case currency
  case language
}

extension Settings: RawRepresentable {
  typealias RawValue = (String, String, String, String)
  
  init?(rawValue: RawValue) {
    switch rawValue {
    case (Constants.LanguageStorage.home, Constants.LanguageStorage.away, Constants.LanguageStorage.homeIndex, Constants.LanguageStorage.awayIndex): self = .language
    case (Constants.LocationStorage.home, Constants.LocationStorage.away, Constants.LocationStorage.homeIndex, Constants.LocationStorage.awayIndex): self = .location
    case (Constants.CurrencyStorage.home, Constants.CurrencyStorage.away, Constants.CurrencyStorage.homeIndex, Constants.CurrencyStorage.awayIndex): self = .currency
    default: return nil
    }
  }
  
  var rawValue: RawValue {
    switch self {
    case .location: return (Constants.LocationStorage.home, Constants.LocationStorage.away, Constants.LocationStorage.homeIndex, Constants.LocationStorage.awayIndex)
    case .currency: return (Constants.CurrencyStorage.home, Constants.CurrencyStorage.away, Constants.CurrencyStorage.homeIndex, Constants.CurrencyStorage.awayIndex)
    case .language: return (Constants.LanguageStorage.home, Constants.LanguageStorage.away, Constants.LanguageStorage.homeIndex, Constants.LanguageStorage.awayIndex)
    }
  }
}
