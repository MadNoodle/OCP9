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
  var city = ""
  var region = ""
  var country = ""
  
  // MARK: - Init
  init(city:String, region:String, country: String){
    self.city = city
    self.region = region
    self.country = country
  }
}
