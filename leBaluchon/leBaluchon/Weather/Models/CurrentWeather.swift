//
//  CurrentWeather.swift
//  leBaluchon
//
//  Created by Mathieu Janneau on 05/01/2018.
//  Copyright © 2018 Mathieu Janneau. All rights reserved.
//

import Foundation
import UIKit

/**
 Data model for weather info fetched from Yahoo Weather API
 */
class CurrentWeather {
  /// city name
  let city: String?
  /// city temp in celsius
  let temperature: String?
  /// condition details
  let conditions: String?
  /// Weather condition code as String.
  /// Can be converted to icon via WeatherCodeConverter Class
  let iconCode: String?
  
  // Init
  init(dictionnary: [String: Any],for city: String){
    self.city = city
    temperature = dictionnary["temp"] as? String
    conditions = dictionnary["text"] as? String
    iconCode = dictionnary["code"] as? String
  }
}


