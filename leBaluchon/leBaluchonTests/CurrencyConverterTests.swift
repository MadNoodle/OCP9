//
//  CurrencyConverterTests.swift
//  leBaluchonTests
//
//  Created by Mathieu Janneau on 11/01/2018.
//  Copyright © 2018 Mathieu Janneau. All rights reserved.
//

import XCTest
@testable import leBaluchon

class CurrencyConverterTests: XCTestCase {
  // MARK: properties
  var brain = CurrencyConverter()
  // MARK: setup
  override func setUp() {
    super.setUp()
    brain.clear()
  }
  
  // MARK: - Testing CalculatorBrain canAddNumber Computed Var
  func testGivenStringNumbersIsEmpty_whenAddNumberTriggered_thenSendsFalse(){
    //Set stringNumbers to Empty
    brain.stringNumbers = [String()]
    XCTAssertFalse(brain.canAddOperator)
  }
  
  func testGivenStringNumbersCountHasEmptyString_whenAddNumberIsTriggered_thenSendsFalse(){
    brain.stringNumbers = [""]
    XCTAssertFalse(brain.canAddOperator)
  }
  
  func testGivenStringNumbersContainsOneChar_whenAddNumberIsTriggered_thenSendsTrue(){
    brain.stringNumbers = ["1"]
    XCTAssert(brain.canAddOperator)
  }
  
  func testGivenStringNumbersContainsManyChars_whenAddNumberIsTriggered_thenSendsTrue(){
    //Set stringNumbers to Empty
    brain.stringNumbers = ["10000000"]
    XCTAssert(brain.canAddOperator)
  }
  
  // MARK: Testing add Decimal
  func testGivenNumberInStack_whenDecimalPointIsTapped_thenDecimalNumberIsreturned(){
    brain.stringNumbers = ["0"]
    brain.addDecimal()
    XCTAssertEqual(brain.stringNumbers, ["0."])
  }
  
  func testGivenNumberInStackIsDecimal_whenDecimalIsTapped_thenPointCannotBeAdded(){
    brain.stringNumbers = ["0.0"]
    XCTAssertFalse(brain.canAddDecimal)
  }
  
  func testGivenNumberStackIsEmpty_whenDecimalIsTapped_thenPointCannotBeAdded(){
    brain.stringNumbers = [String()]
    XCTAssertFalse(brain.canAddDecimal)
  }
  
  // MARK: - Testing CalculatorBrain number storing
  func testGivenStackIsEmpty_WhenPressNumber_thenStackIsPopulated() {
    brain.addNewNumber(1,"1")
    XCTAssert(brain.stringNumbers == ["1"])
  }
  
  func testGivenStackIsPopulated_WhenPressNumber_thenStackNumberAppendNewNumber() {
    brain.stringNumbers = ["10"]
    brain.addNewNumber(1,"1")
    XCTAssert(brain.stringNumbers == ["101"])
  }
  

  
  // MARK: - Testing if concatenation of numbers and operands are a valid operation
  
  func testGivenStringNumbersIsEmpty_whenisExpressionCorrectTriggered_thenSendsFalse(){
    //Set stringNumbers to Empty
    brain.stringNumbers = [String()]
    XCTAssertFalse(brain.isExpressionCorrect)
  }
  
  func testGivenStringNumbersHasEmptyString_whenisExpressionCorrectTriggered_thenSendsFalse(){
    brain.stringNumbers = [""]
    XCTAssertFalse(brain.isExpressionCorrect)
  }
  
  func testGivenStringNumbersHasOneMember_whenisExpressionCorrectTriggered_thenSendsFalse(){
    brain.stringNumbers = ["1"]
    XCTAssert(brain.isExpressionCorrect)
  }
  func testGivenStringNumbersHasManyMembers_whenisExpressionCorrectTriggered_thenSendsFalse(){
    brain.stringNumbers = ["10","11"]
    XCTAssert(brain.isExpressionCorrect)
  }
  
  // MARK: - Testing CalculatorBrain calculation
  
  func testGivenTwoNumbers_whenEqualButtonIsTappedAndResultIsInteger_ThenResultIsRounded(){
    XCTAssertFalse(brain.roundEvaluation(2.5))
    XCTAssert(brain.roundEvaluation(14.0))
    
  }

  
  // MARK: - Testing AC function
  
  func testGivenResultIsStored_WhenACIsPressed_thenAllValuesAreReset() {
    brain.stringNumbers = ["10", "2"]
    brain.allClear()
    XCTAssert(brain.stringNumbers == [String()])
  }
  
  func testCOnversion(){
    brain.stringNumbers = ["10"]
    let rate = 2.0
    let result = brain.convert(rate:rate)
    XCTAssert(result == 20.0)
  }

}
