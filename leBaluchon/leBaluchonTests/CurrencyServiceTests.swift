//
//  CurrencyServiceTests.swift
//  leBaluchonTests
//
//  Created by Mathieu Janneau on 03/01/2018.
//  Copyright © 2018 Mathieu Janneau. All rights reserved.
//

import XCTest
import Alamofire
@testable import leBaluchon

class CurrencyServiceTests: XCTestCase {
    let baseUrl = "https://api.fixer.io/latest?base="
    let defaults: UserDefaults = UserDefaults.standard
    var calendar = Calendar.current
  
  func testCreateCurrencyRate(){
    let testDictionnary = ["USD" : 1.2]
    let rate = CurrencyRate(currencyDictionnary: testDictionnary, to : "USD")
    XCTAssertEqual(rate.currency, "USD")
    XCTAssertEqual(rate.rate, 1.2)
  }
  func testSuccesfullConnexionToCurrencyRemoteService() {
    let ex = expectation(description: "currency name should be BGP & rate different from 0.0")
    
    CurrencyService.fetchExchangeRate(apiUrl: baseUrl, from: "USD", to: "GBP", completion: {(rate)  in
      XCTAssert(rate.currency == "GBP")
      XCTAssert(rate.rate != 0.0)
      ex.fulfill()
    })
    
    waitForExpectations(timeout: 10) { (error) in
      if let error = error {
        XCTFail("error: \(error)")
      }
    }
  }
  
  
  func testFailConnexionToCurrencyRemoteService() {
   
    CurrencyService.fetchExchangeRate(apiUrl: "", from: "USD", to: "GBP", completion: {(rate)  in
      XCTAssert(rate.currency == "GBP")
      XCTAssertFalse(type(of: rate) == [String: Any ].self)
    })
  }
  
  func testUserDefaultStorage() {
    CurrencyService.storeLastUpdateDate()
    XCTAssert( defaults.object(forKey:"lastUpdate") as? Date != nil)
  }
  
  func testIfneedToUpdate() {
    calendar.timeZone = .current
    let update = Date() + 86400
    let result = CurrencyService.verifyIfUpdateNeeded(lastUpdate : update, home: "fr", away: "en")
    XCTAssert(result)
  }
  func testIfServerHasBeenUpdatedToday() {
    calendar.timeZone = .current
    let date = Date()
    if calendar.component(.hour, from: date) >= 16 {
      XCTAssert(CurrencyService.verifyIfBankRatesUpdated())

    } else{
      XCTAssertFalse(CurrencyService.verifyIfBankRatesUpdated())
    }
  }
  
  }

