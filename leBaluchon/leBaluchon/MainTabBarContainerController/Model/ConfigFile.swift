//
//  Constants.swift
//  leBaluchon
//
//  Created by Mathieu Janneau on 18/01/2018.
//  Copyright © 2018 Mathieu Janneau. All rights reserved.
//

import Foundation
import UIKit

/**
 This enum allows the user to modify the color scheme of the app
 */
enum ColorTemplate {
  case green
  case red
}

/// Raw representable to assign, add or delete a color to the template
extension ColorTemplate: RawRepresentable {
  typealias RawValue = UIColor
  
  init?(rawValue: RawValue) {
    switch rawValue {
    case #colorLiteral(red: 0.2588235294, green: 0.8039215686, blue: 0.768627451, alpha: 1): self = .green
    case #colorLiteral(red: 1, green: 0.4196078431, blue: 0.4078431373, alpha: 1): self = .red
    default: return nil
    }
  }
  
  var rawValue: RawValue {
    switch self {
    case .red: return #colorLiteral(red: 1, green: 0.4196078431, blue: 0.4078431373, alpha: 1)
    case .green: return #colorLiteral(red: 0.2588235294, green: 0.8039215686, blue: 0.768627451, alpha: 1)
      
    }
  }
}

/**
 This struct contains all the constants keychains called by different API Services in the application
 */
struct Constants {
  
  // MARK: - UI PROPERTIES
  
  /// Contains all Controllers titles
  struct ControlleTitles {
    
    /// Weather Controller title
    static let weather = "Weather"
    
    /// Currency Controller title
    static let currency = "Currency"
    
    /// Translation Controller title
    static let translation = "Translation"
    
    /// Settings controller title
    static let settings = "Settings"
    
    /// Returns the associated tab bar icon for a controller title
    ///
    /// - Parameter title: String
    /// - Returns: String icon's name
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
  
  /// Date format display options. User can add new date format
  struct DateFormat {
    
    /// Displays a full date date in String
    static let fullDate = "EEEE, MMMM d, yyyy"
  }
  
  /// Font family that user can use. USer can add new font family here
  struct FontFamily {
    static let montserrat = "Montserrrat-Regular.otf"
  }
  
  // MARK: - EXTERNAL API CONSTANTS
  
  /// Contains all API url constants
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
  /// Google translatin base url
  static let TRANSLATION_BASE_URL = "https://translation.googleapis.com/language/translate/v2/detect?key="
  }

  // MARK: - MESSAGES
  
  /// Alert messages to be displayed
  struct AlertMessages {
    /// Displays a warning
    static let warning = "Attention"
    /// Displayed when an expression doesn t fit the expected requirements
    static let incorrectExpression = "Expression incorrecte !"
    /// Displayed when server is not accessible
    static let connexionProblem = "Problème de connexion au serveur"
  }
  
  /// Logging messages for external servers connexions
  struct ValidationMessages {
    /// Displayed when connexion is successful
    static let success = "Validation Successful"
    /// Displayed when app cannot reach data
    static let failure = "error fetching Data"
  }
  
  /// Translation Controller placeholder texts
  struct TranslationPrompts {
    static let type = "Type your text here"
    static let result = "Your translation will appear here"
  }
  
  // MARK: - PROPERTY PERSISTENCE IDENTIFIERS
  
  /// Currencies persistence Strings identifier
  struct CurrencyStorage {
    /// User default key to store home currency
    static let home = "homeCurrency"
    /// Key to stored to reload the good home currency in detail settings
    static let homeIndex = "homeCurrencyIndex"
    /// User default key to store away currency
    static let away = "awayCurrency"
    /// Key to stored to reload the good away currency in detail settings
    static let awayIndex = "awayCurrencyIndex"
  }
  
  /// Language persistence Strings identifier
  struct LanguageStorage {
    /// User default key to store home language
    static let home = "homeLanguage"
    /// Key to stored to reload the good home language in detail settings
    static let homeIndex = "homeLanguageIndex"
    /// User default key to store away language
    static let away = "awayLanguage"
    /// Key to stored to reload the good away language in detail settings
    static let awayIndex = "awayLanguageIndex"
  }
  
  /// Location persistence Strings identifier
  struct LocationStorage {
    /// User default key to store home City
    static let home = "homeCity"
    /// Key to stored to reload the good home City in detail settings
    static let homeIndex = "homeCityIndex"
    /// User default key to store away City
    static let away = "awayCity"
    /// Key to stored to reload the good away language in detail settings
    static let awayIndex = "awayCityIndex"
  }
  
  /// Notifications identifiers
  struct NotificationIdentifier {
    /// When user choose a home currency in settings it notifies Currrency controller
    static let homeCurrency = "homeCurrencyValueChanged"
    /// When user choose a away currency in settings it notifies Currrency controller
    static let awayCurrency = "awayCurrencyValueChanged"
  }
  
  /// Table view cell identifier
  static let cellIdentifier = "myCell"
}

/// Enum that stores the two location options
enum Destination {
  case home
  case away
}
