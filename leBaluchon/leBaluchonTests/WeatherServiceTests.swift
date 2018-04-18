//
//  WeatherServiceTests.swift
//  leBaluchonTests
//
//  Created by Mathieu Janneau on 05/01/2018.
//  Copyright © 2018 Mathieu Janneau. All rights reserved.
//

import XCTest
import Alamofire
@testable import leBaluchon

class WeatherServiceTests: XCTestCase {

  func testEncodingYqlQuery() {
    let yqlRequest = "select item.condition from weather.forecast where woeid in (select woeid from geo.places(1) where text='Paris') and u='c'"
    let urlEncodedText = yqlRequest.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    XCTAssertEqual(urlEncodedText, "select%20item.condition%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text='Paris')%20and%20u='c'")
  }
  func testFetchingWeather() {
    let city = "Paris"
    var actualWeather: CurrentWeather?
    WeatherService.fetchWeather(for: city, completion: {(weather, _) in
      actualWeather = weather
      XCTAssertEqual(actualWeather?.city, "Paris")
      XCTAssert(actualWeather?.conditions != nil)
      XCTAssert(actualWeather?.temperature != nil)
    })
  }
  
  func testSuccesfullConnexionToWeatherService() {
    let exp = expectation(description: "weather object is populated")
    
    let city = "Paris"
    var actualWeather: CurrentWeather?
    WeatherService.fetchWeather(for: city, completion: {(weather, _) in
      actualWeather = weather
      XCTAssert(actualWeather != nil)
      exp.fulfill()
    })
    
    waitForExpectations(timeout: 10) { (error) in
      if let error = error {
        XCTFail("error: \(error)")
      }
    }
  }
  func testCodeRetrieving() {
    let string = "24"
    let result = WeatherCodeConverter.findConditions(for: string)
    XCTAssert(result == "wind")
    
  }
}
