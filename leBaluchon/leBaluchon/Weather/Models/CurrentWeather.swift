//
//  CurrentWeather.swift
//  leBaluchon
//
//  Created by Mathieu Janneau on 05/01/2018.
//  Copyright © 2018 Mathieu Janneau. All rights reserved.
//

import Foundation

/**
 Data model for weather info fetched from Yahoo Weather API
 */
class CurrentWeather {
  let city: String?
  let temperature: String?
  let conditions: String?
  let specials: Int?
  
  init(dictionnary: [String: Any],for city: String){
    self.city = city
    temperature = dictionnary["temp"] as? String
    conditions = dictionnary["text"] as? String
    specials = dictionnary["code"] as? Int
  }
}


