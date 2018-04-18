//
//  File.swift
//  leBaluchon
//
//  Created by Mathieu Janneau on 13/01/2018.
//  Copyright © 2018 Mathieu Janneau. All rights reserved.
//

import Foundation
import Alamofire

/**
 this class handles all the REST API request to search for location.
 Documentation can be found on: https://wiki.openstreetmap.org/wiki/Nominatim
 It returns a area of possible locations that user will choose from.
 */

class LocationService {
  // ////////////////// //
  // MARK: - properties //
  // ////////////////// //
  /// base url to fetch api
  static let baseUrl = Constants.Url.LOC_BASE_URL
  /// callback endPoint for format
  static let endPoint = Constants.Url.LOC_END_POINT
  /// array initialized to store results that will be sent back by fetchDAta method
  static var resultArray: [LocationModel] = []
  
  // ////////////////// //
  // MARK: - methods    //
  // ////////////////// //
 
  /// user input a string the method sends back an array of
 /// possible matching location
  /// * this method relies on Alamofire Framework and makes
  /// a connexion check inside.
  /// ** in case of error an error is printed in console.
  /// but a guard properties make a first sanity check for url creation
  ///
  /// - Parameters:
  ///   - location: String City
  ///   - completion: [LocationModel] this function returns an array of LocationModel
  static func fetchData(for location: String, completion: @escaping ([LocationModel]) -> Void) {
    // encode text to replace space
    guard let urlEncodedText = location.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
      else {return}
    /// Final Url to find a location
    let url = baseUrl + urlEncodedText + endPoint
    // Make the call async to separate from UI calls
    DispatchQueue.main.async {
      Alamofire.request(url).validate().responseJSON { response in
        switch response.result {
        // check for connexion to remote server
        case .success:
          print(Constants.Validation.success)
          Alamofire.request(url).responseJSON { (response) in
            parseResult(response)
            // escape resultArray
            completion(resultArray)
          }
        case .failure(let error):
          print(error.localizedDescription)
        }
      }
    }
  }
  
  ///  Parse json result fetched from server and append each results in resultArray
  ///
  /// - Parameter response: Response from location API call
  static func parseResult(_ response: (DataResponse<Any>)) {
    
    if let jsonDictionnary = response.result.value as? [Any] {
      for json in jsonDictionnary {
        if let result = json as? [ String: Any] {
          if let display = result["display_name"] as? String {
            let city = display.components(separatedBy: ",")
            let location = LocationModel(city: city[0], region: city[1], country: city.last!)
            resultArray.append(location)
          }
        }
      }
    }
  }
}
