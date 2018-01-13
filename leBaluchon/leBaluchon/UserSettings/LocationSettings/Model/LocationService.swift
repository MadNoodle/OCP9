//
//  File.swift
//  leBaluchon
//
//  Created by Mathieu Janneau on 13/01/2018.
//  Copyright © 2018 Mathieu Janneau. All rights reserved.
//

import Foundation
import Alamofire

class LocationService {
  
  static let baseUrl = "http://nominatim.openstreetmap.org/search?q="
  static let endPoint = "&format=json"
  static func fetchData(for location:String, completion: @escaping ([LocationModel]) -> Void){
    guard
      let urlEncodedText = location.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
    let url = baseUrl + urlEncodedText + endPoint
    var resultArray : [LocationModel] = []
    // Make the call async to separate from UI calls
    DispatchQueue.main.async {
      Alamofire.request(url).validate().responseJSON { response in
        
        switch response.result {
        case .success:
          print("Validation Successful")
          Alamofire.request(url).responseJSON { (response) in
           
            if let jsonDictionnary = response.result.value as? [Any]{
              for json in jsonDictionnary {
                if let result = json as? [ String : Any] {
                  if let display = result["display_name"] as? String{
                   let city = display.components(separatedBy: ",")
                    let location = LocationModel(city: city[0],region: city[1], country: city.last!)
                    resultArray.append(location)
                  }
                }
               
              }
            }
            completion(resultArray)
          }
        case .failure(let error):
          print(error.localizedDescription)

        }
      }
    }
  }
  
}
