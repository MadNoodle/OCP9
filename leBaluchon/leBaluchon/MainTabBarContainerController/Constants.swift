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
}
