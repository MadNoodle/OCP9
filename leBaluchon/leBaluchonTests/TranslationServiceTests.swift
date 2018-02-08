//
//  TranslationServiceTests.swift
//  leBaluchonTests
//
//  Created by Mathieu Janneau on 04/01/2018.
//  Copyright © 2018 Mathieu Janneau. All rights reserved.
//

import XCTest
@testable import leBaluchon

class TranslationServiceTests: XCTestCase {
  let translationService = TranslationService()
  
  func testRequestUrlCreation() {
    let request: String = translationService.createRequestUrl(text: "bonjour poulet.", from: "fr", to: "en")
    XCTAssertEqual(request, "https://www.googleapis.com/language/translate/v2?key=AIzaSyDBiXmXXpi5D2I0QIb0buMGNZgxXnD0X2k&q=bonjour%20poulet.&source=fr&target=en")
  }
  
  func testSuccesfullConnexionToTranslationRemoteService() {
    let ex = expectation(description: "result should be hello chicken")
    let request: String = translationService.createRequestUrl(text: "bonjour poulet.", from: "fr", to: "en")
    var translation = ""
    translationService.fetchTranslation(translationUrl: request, completion: {(result,error) in
      translation = (result?.text)!
      XCTAssertEqual(translation,"hello chicken." )
      ex.fulfill()
    })
  
    waitForExpectations(timeout: 10) { (error) in
      if let error = error {
        XCTFail("error: \(error)")
      }
    }
  }
  
  func testLanguageDetection() {
    let ex = expectation(description: "fr")
    let request: String = translationService.createRequestUrl(text: "bonjour poulet.", from: "fr", to: "en")
    var translation = ""
    translationService.fetchTranslation(translationUrl: request, completion: {(result,error) in
      translation = (result?.text)!
      XCTAssertEqual(translation,"hello chicken." )
      ex.fulfill()
    })
    
    waitForExpectations(timeout: 10) { (error) in
      if let error = error {
        XCTFail("error: \(error)")
      }
    }
  }
  func testDetectLanguage() {
    let input = "bonjour tout le monde"
    var result = ""
    let ex = expectation(description: "language is french")
    
    translationService.detectLanguage(from: input, completion: {(language,error) in
      result = language
      XCTAssert(result == "fr")
      ex.fulfill()
    })
    
    waitForExpectations(timeout: 10) { (error) in
      if let error = error {
        XCTFail("error: \(error)")
      }
  }
}
}
