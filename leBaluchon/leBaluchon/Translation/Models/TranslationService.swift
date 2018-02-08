//
//  TranslationService.swift
//  leBaluchon
//
//  Created by Mathieu Janneau on 04/01/2018.
//  Copyright © 2018 Mathieu Janneau. All rights reserved.
//

import Foundation
import Alamofire

/**
 Handles all the translation model and methods
 */
class TranslationService {
  /// api key private for security. Change it to your own if you want to reuse the codde
  static private let API_KEY = "AIzaSyDBiXmXXpi5D2I0QIb0buMGNZgxXnD0X2k"
  

  /// Create the url request from a String a base language and final language
  ///
  /// - Parameters:
  ///   - text: String. text to translate
  ///   - source: String. Source language
  ///   - target: String. target Language
  /// - Returns: String url for request
  func createRequestUrl(text: String, from source: String, to target: String) -> String {
    guard
      let urlEncodedText = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return ""}
    let url =  "https://www.googleapis.com/language/translate/v2?key=\(TranslationService.API_KEY)&q=\(urlEncodedText)&source=\(source)&target=\(target)"
 
    return url
  }
  

  /// this function uses Alamofire framework to make Webrequest. and fetch Data in a CurrenyRate Object
  ///
  /// - Parameters:
  ///   - translationUrl: String url to reach te API
  ///   - completion: TranslationObject
  func fetchTranslation(translationUrl: String, completion: @escaping (_ result: TranslationObject?, _ error: Error?) -> Void) {
    var result: TranslationObject?
    
    // Make the call async to separate from UI calls
    DispatchQueue.main.async {
      Alamofire.request(translationUrl).validate().responseJSON { response in
        
        switch response.result {
        case .success:
          print("Validation Successful")
          Alamofire.request(translationUrl).responseJSON { (response) in
            // Parse result pyramid of doom
            if let json =  response.result.value as? [String : Any] {
              if let data = json["data"] as? [String : Any]{
                if let translations = data["translations"] as? [ Any] {
                  if let text = translations[0] as? [String:Any]{
                    result = TranslationObject(text: text["translatedText"] as! String)
                  }
                }
              }
            }
            completion(result, nil)
          }
        case .failure(let error):
          result = TranslationObject(text: "Error")
          completion(result, error)
        }
      }
    }
  }
  

  /// Method to auto detect the language from a text to translate. Can be combined with fetchTranslation to create an autodetected source language request to another
  ///
  /// - Parameters:
  ///   - string: String. Input text
  ///   - completion: String. Language of the text
  func detectLanguage(from string:String, completion: @escaping(_ language: String, _ error: Error?)-> Void ){
    //Convert String to url friendly string
    guard
      let urlEncodedText = string.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
    let request = "https://translation.googleapis.com/language/translate/v2/detect?key=\(TranslationService.API_KEY)&q=\(urlEncodedText)"
    var language: String?
    
    // Make the call async to separate from UI calls
    DispatchQueue.main.async {
      Alamofire.request(request).validate().responseJSON { response in
        
        switch response.result {
        case .success:
          print("Validation Successful")
          Alamofire.request(request).responseJSON { (response) in
            // Parse result
            if let json =  response.result.value as? [String : Any] {
              if let data = json["data"] as? [String : Any]{
                if let detections = data["detections"] as? [ Any] {
                  if let detection = detections[0] as? [Any]{
                  if let result = detection[0] as? [String:Any]{
                    language = (result["language"] as! String)
                  }
                  }
                }
              }
              completion(language!,nil)
            }
           
          }
        case .failure(let error):
         language = "error"
         completion(language!, error)
        }
      }
    }  }
}
