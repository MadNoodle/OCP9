//
//  WeatherService.swift
//  leBaluchon
//
//  Created by Mathieu Janneau on 05/01/2018.
//  Copyright © 2018 Mathieu Janneau. All rights reserved.
//

import Foundation
import Alamofire

/**
 Structure that handles all the call to the yahoo weather API from creating request to fetching data.
 */
struct WeatherService {
  
  // MARK: - properties
  static let baseUrl = "https://query.yahooapis.com/v1/public/yql?q="
  static let endPoint = "&format=json"
  
  // MARK: - methods
  /**
   This method generate a string from a location and yql request
   ## Important
   YQL (Yahoo Query Language) is a SQL-like language that lets you query, filter, and join data from Web services. With YQL, you can access data across the Internet through simple REST requests, eliminating the need to learn how to use different APIs.
   - parameters:
      - location : the city you wish to get weather info
   - returns: String
 */
  static func createRequestUrl(for location: String) -> String{
    //Yql request can be modified to fetch more data
    // check examples here: https://developer.yahoo.com/weather/
    
    let yqlRequest = "select item.condition from weather.forecast where woeid in (select woeid from geo.places(1) where text='\(location)') and u='c'"
    
    //Transcoding
    guard
      let urlEncodedText = yqlRequest.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return ""}
    //Concatening url to the final requestUrl
    let requestUrl:String = baseUrl + urlEncodedText + endPoint
    return requestUrl
  }
  
  /**
   This method make a GET request on yahoo Weather Rest API and returns a parsed data object
   - parameters:
   - location : the city you wish to get weather info
   - returns: CurrentWeather
   */
  static func fetchWeather(for location: String, completion: @escaping(_ weather: CurrentWeather) ->Void){
    let requestUrl: String = createRequestUrl(for: location)
    //Initialize the optional weather to store result of the request if there is one
    var weather: CurrentWeather?
    
    // Sending Request on another thread to be independant from UI
    DispatchQueue.main.async {
      // Connecxion success check
      Alamofire.request(requestUrl).validate().responseJSON { response in
        switch response.result {
        case .success:
          print("Validation Successful")
          Alamofire.request(requestUrl).responseJSON { (response) in
            //Parsing
            if let jsonDictionnary = response.result.value as? [String : Any]{
              if let query = jsonDictionnary["query"] as? [String : Any] {
                if let results = query["results"] as? [String : Any] {
                  if let channel = results["channel"] as? [String : Any] {
                    if let item = channel["item"] as? [String : Any] {
                      if let condition = item["condition"] as? [String : Any]{
                        // Actual dataObject to return
                        weather = CurrentWeather(dictionnary: condition, for: location)
                        
                      }
                    }
                  }
                }
                completion(weather!)
              }
            }
            
          }
        case .failure(let error):
          print(error)
        }
      }
    }
  }
}
