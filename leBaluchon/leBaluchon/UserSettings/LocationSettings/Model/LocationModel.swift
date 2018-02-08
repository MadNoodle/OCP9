//
//  LocationModel.swift
//  leBaluchon
//
//  Created by Mathieu Janneau on 13/01/2018.
//  Copyright © 2018 Mathieu Janneau. All rights reserved.
//

import Foundation

/**
 Data Model used to store location retrieved from REST API
 */
struct LocationModel {
  // MARK: - properties
  /// city name
  var city = ""
  /// region name
  var region = ""
  /// country name
  var country = ""
  
  // MARK: - Init
  /// Initializer to instantiate a location
  init(city:String, region:String, country: String){
    self.city = city
    self.region = region
    self.country = country
  }
}
