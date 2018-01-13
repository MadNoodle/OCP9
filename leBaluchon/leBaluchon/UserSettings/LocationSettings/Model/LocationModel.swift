//
//  LocationModel.swift
//  leBaluchon
//
//  Created by Mathieu Janneau on 13/01/2018.
//  Copyright © 2018 Mathieu Janneau. All rights reserved.
//

import Foundation

struct LocationModel {
  var city = ""
  var region = ""
  var country = ""
  
  init(city:String, region:String, country: String){
    self.city = city
    self.region = region
    self.country = country
  }
}
