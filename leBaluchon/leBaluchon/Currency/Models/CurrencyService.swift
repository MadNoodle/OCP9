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
  /**
   Stores last update time in User default
 */
  func storeLastUpdateDate() {
    let date = Date()
    let defaults: UserDefaults = UserDefaults.standard
    defaults.set(date, forKey: "lastUpdate")
  }
  
  
  /**
  Compare last update date from userDefault and send true if interval is greater than one day or if it is later 4 pm (BCE update time).
   - parameters:
      - date: date stored in userDefaults
      - actualDate: variable is Date() but used to test method
   - returns: Bool
   */
  func verifyIfUpdateNeeded(since date:Date, to actualDate: Date) -> Bool {
    var checkResult:Bool?
    
    let interval = date.interval(ofComponent: .day, fromDate: actualDate)
    if interval >= 1 || verifyIfBankRatesUpdated(){
      checkResult = true
    } else {
      checkResult =  false
    }
    return checkResult!
  }
  
  /**
   Method that check if it s later than 4 pm GMT (BCE update time)
 */
  func verifyIfBankRatesUpdated() -> Bool {
    var checkResult:Bool?
    var BCECalendar = Calendar.current
    BCECalendar.timeZone = .current
     let centralBankUpdateCheck = BCECalendar.component(.hour, from: Date())
    if centralBankUpdateCheck >= 16{
      checkResult = true
    } else {
      checkResult =  false
    }
    return checkResult!
  }
}
