//
//  CurrencyRate.swift
//  leBaluchon
//
//  Created by Mathieu Janneau on 03/01/2018.
//  Copyright © 2018 Mathieu Janneau. All rights reserved.
//

import Foundation

/**
 Data for Model for currency controller
 */
class CurrencyRate {
  /// Currency name
  let currency: String?
  /// Currency actual rate
  let rate: Double?
  
  init(currencyDictionnary: [String: Any], to currency: String) {
    self.currency = currency
    rate = currencyDictionnary[currency] as? Double
  }
}
