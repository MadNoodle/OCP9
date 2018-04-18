//
//  Constants.swift
//  leBaluchon
//
//  Created by Mathieu Janneau on 18/01/2018.
//  Copyright © 2018 Mathieu Janneau. All rights reserved.
//

import Foundation
/**
 This struct contains all the constants keychains called by different API Services in the application
 */
struct Constants {
  
  struct ControlleTitles {
    static let weather = "Weather"
    static let currency = "Currency"
    static let translation = "Translation"
    static let settings = "Settings"
    
    static func getIcon(for title: String) -> String {
      var icon: String = ""
      
      switch title {
      case "Weather":
        icon = "weather"
      case "Currency":
        icon = "currency"
      case "Translation":
        icon = "translation"
      case "Settings":
        icon = "settings"
      default:
        break
      }
      return icon
    }
  }
  struct Url {
  /// Base url for location search API
  static let LOC_BASE_URL = "http://nominatim.openstreetmap.org/search?q="
  /// end point for location search API
  static let LOC_END_POINT = "&format=json"
  /// Weather search Search Base url
  static let WEATHER_BASE_URL = "https://query.yahooapis.com/v1/public/yql?q="
  /// Weather search endPoint
  static let WEATHER_END_POINT = "&format=json"
  /// Formatted YQL request for Yahoo Weather API
  static let WEATHER_YQL_REQUEST = "select item.condition from weather.forecast where woeid in (select woeid from geo.places(1) where text='"
  /// Extended temperature unit parameters for weather API
  static let WEATHER_YQL_REQUEST_END_POINT = "') and u='c'"
  /// Currency API base URL
  static let CURRENCY_API_CALL = "https://api.fixer.io/latest?base="
    
  static let TRANSLATION_BASE_URL = "https://translation.googleapis.com/language/translate/v2/detect?key="
  }
  
  struct Validation {
  static let success = "Validation Successful"
  static let failure = "error fetching Data"
  }
  
  struct CurrencyStorage {
    static let home = "homeCurrency"
    static let homeIndex = "homeCurrencyIndex"
    static let away = "awayCurrency"
     static let awayIndex = "awayCurrencyIndex"
  }
  
  struct LanguageStorage {
    static let home = "homeLanguage"
    static let homeIndex = "homeLanguageIndex"
    static let away = "awayLanguage"
    static let awayIndex = "awayLanguageIndex"
  }
  
  struct LocationStorage {
    static let home = "homeCity"
    static let away = "awayCity"
  }
  struct NotificationIdentifier {
    static let homeCurrency = "homeCurrencyValueChanged"
    static let awayCurrency = "awayCurrencyValueChanged"
  }
  
  struct AlertMessages {
    static let warning = "Attention"
    static let incorrectExpression = "Expression incorrecte !"
    static let connexionProblem = "Problème de connexion au serveur"
  }
  
  struct DateFormat {
    static let fullDate = "EEEE, MMMM d, yyyy"
  }
  
  struct FontFamily {
    static let montserrat = "Montserrrat-Regular.otf"
  }
  
  struct TranslationPrompts {
    static let type = "Type your text here"
    static let result = "Your translation will appear here"
  }
  
  static let cellIdentifier = "myCell"
}
enum Destination {
  case home
  case away
}
