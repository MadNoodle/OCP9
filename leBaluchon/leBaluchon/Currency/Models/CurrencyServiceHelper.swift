//
//  CurrencyServiceHelper.swift
//  leBaluchon
//
//  Created by Mathieu Janneau on 04/01/2018.
//  Copyright © 2018 Mathieu Janneau. All rights reserved.
//

import Foundation

/**
 Extension to Date Class that allows to generate the interval between two dates
 */
extension Date {
  /**
  generate the interval between two dates
   * Example
   ```
   date.interval(ofComponent: .day, fromDate: Date())
   ```
   - parameters:
      - comp: Calendar component scale to compare ( .year, .day, .hour, .minute, .second)
   - returns: Int
   */
  func interval(ofComponent comp: Calendar.Component, fromDate date: Date) -> Int {
    
    let currentCalendar = Calendar.current
    
    guard let start = currentCalendar.ordinality(of: comp, in: .era, for: date) else { return 0 }
    guard let end = currentCalendar.ordinality(of: comp, in: .era, for: self) else { return 0 }
    
    return end - start
  }
}

