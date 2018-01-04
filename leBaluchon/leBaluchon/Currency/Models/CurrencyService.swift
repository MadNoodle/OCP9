//
//  CurrencyService.swift
//  leBaluchon
//
//  Created by Mathieu Janneau on 03/01/2018.
//  Copyright © 2018 Mathieu Janneau. All rights reserved.
//

import Foundation
import Alamofire

/**
 This Servvice handle the collection of rates from https://api.fixer.io.
 Documentation available at : http://fixer.io/
 The API updates rates daily around 4PM CET
 https://github.com/hakanensari/fixer/
 */
class CurrencyService {
  
  /**
   this function uses Alamofire framework to make Webrequest. and fetch Data in a CurrenyRate Object
 */
  func fetchExchangeRate(apiUrl: String,from base: String, to final: String, completion: @escaping (_ currency: CurrencyRate) -> Void) {
    let requestUrl = apiUrl + base
    var rate: CurrencyRate?
    // Make the call async to separate from UI calls
    DispatchQueue.main.async {
      
    
      Alamofire.request(requestUrl).validate().responseJSON { response in
        switch response.result {
        case .success:
          print("Validation Successful")
      Alamofire.request(requestUrl).responseJSON { (response) in
        
        if let jsonDictionnary = response.result.value as? [String : Any]{
          if let currentRates = jsonDictionnary["rates"] as? [String : Any]{
            rate = CurrencyRate(currencyDictionnary: currentRates, to: final)
          }
        }
        completion(rate!)
      }
          case .failure(let error):
            rate = CurrencyRate(currencyDictionnary: ["error fetching Data":""], to: final)
          print(error)
      }
    }
   
  }
}
}
  

