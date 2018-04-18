//
//  LocationServiceTests.swift
//  leBaluchonTests
//
//  Created by Mathieu Janneau on 14/01/2018.
//  Copyright © 2018 Mathieu Janneau. All rights reserved.
//

import XCTest
@testable import leBaluchon

class LocationServiceTests: XCTestCase {

  func testFetchingDataFromRemoteServer() {
    let location = "paris"
    var locations: [LocationModel] = []
      let exp = expectation(description: "currency name should be BGP & rate different from 0.0")
      
       LocationService.fetchData(for: location, completion: {(result) in
        for data in result {
          locations.append(data)
        }
        XCTAssert(locations.count != 0)
       
        exp.fulfill()
      })
      
      waitForExpectations(timeout: 10) { (error) in
        if let error = error {
          XCTFail("error: \(error)")
        }
      }
   
  }
  
}
