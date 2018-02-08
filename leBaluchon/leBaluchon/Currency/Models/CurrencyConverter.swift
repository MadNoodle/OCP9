//
//  CurrencyConverterr.swift
//  leBaluchon
//
//  Created by Mathieu Janneau on 10/01/2018.
//  Copyright © 2018 Mathieu Janneau. All rights reserved.
//

import Foundation



import Foundation
/**
 Handles all the logic for calculations
 */
struct CurrencyConverter {
  
  // ////////////////// //
  // MARK: - Properties //
  // ////////////////// //
  
  /// Array to store key inputs
  var stringNumbers: [String] = [String()]
  /// initial index
  var index = 0
  /// Home currency value
  var currencyHome: Double?
  /// Away Currency Value
  var currencyAway: Double?
  
  // ///////////////////// //
  // MARK: - Input Methods //
  // ///////////////////// //
  
  /// Computed property that check if there is one number in number stack.
  /// if yes then you can add an operand
  var canAddOperator: Bool {
    if let stringNumber = stringNumbers.last {
      if stringNumber.isEmpty {
        return false
      }
    }
    return true
  }
  

  /// Add new number in the stack and memorize the former last one
  /// allows us to calculate numbers with more than one number long
  ///
  /// - Parameters:
  ///   - newNumber: Int
  ///   - value: Int
  mutating func addNewNumber(_ newNumber: Int,_ value: String) {
    if let stringNumber = stringNumbers.last {
      var stringNumberMutable = stringNumber
      //Convert Int to String and append it to the former number
      stringNumberMutable += "\(value)"
      // Replace formernumber with apended number
      stringNumbers[stringNumbers.count-1] = stringNumberMutable
      
    }
  }
  

  /// Check if the stack already contains a point or is empty and returns false it is
  var canAddDecimal: Bool {
    if let strings = stringNumbers.last {
      if strings.contains(".") || strings.isEmpty {
        return false
      }
    }
    return true
  }
  
  /// Method to add a decimal point
  mutating func addDecimal(){
    if let stringNumber = stringNumbers.last {
      var stringNumberDecimal = stringNumber
      //Convert Int to String and append it to the former number
      stringNumberDecimal += "."
      // Replace formernumber with apended number
      stringNumbers[stringNumbers.count-1] = stringNumberDecimal
    }
  }
  // /////////////////////////////////////// //
  // MARK: - Evaluation & calculation metods //
  // /////////////////////////////////////// //
  
  /// Computed property that check if there is empty or have
  /// only one member in number stack. Then you cannot perform operation
  var isExpressionCorrect: Bool {
    if let stringNumber = stringNumbers.last {
      if stringNumber.isEmpty {
        if stringNumbers.count == 1 {
          return false
        }
        return false
      }
    }
    return true
  }
  
  
  /// Perform the operation between the 2 numbers in the stack.
  /// the operation can be + or - for the moment
  ///
  /// - Parameter rate: Currency exchange rate
  /// - Returns: Double converted result
  mutating func convert(rate:Double) -> Double {
    var total: Double = 0
    // slices the memorized number
    for stringNumber in stringNumbers {
      //Convert string into Int to calculate
      if let number = Double(stringNumber) {
        total = number * rate
      }
    }
    clear()
    return total
  }
  
  /// Check if the result is an Integer
  ///
  /// - Parameter result: Double
  /// - Returns: Bool
  mutating func roundEvaluation(_ result: Double) -> Bool{
    if result.truncatingRemainder(dividingBy: 1) == 0 {
      return true
    }
    return false
  }
  
  // //////////////////// //
  // MARK: - Reset Method //
  // //////////////////// //
 
  /// Clear the model's data
  mutating func clear() {
    stringNumbers = [String()]

    index = 0
  }
  
  /// Clear the model's data and purge former result
  mutating func allClear() {
    clear()
 
  }
}

