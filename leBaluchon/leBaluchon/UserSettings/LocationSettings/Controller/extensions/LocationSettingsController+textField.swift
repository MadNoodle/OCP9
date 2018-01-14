//
//  LocationSettingsController+textField.swift
//  leBaluchon
//
//  Created by Mathieu Janneau on 13/01/2018.
//  Copyright © 2018 Mathieu Janneau. All rights reserved.
//

import UIKit

extension LocationSettingsController: UITextFieldDelegate{
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    searchLocation()
    table?.isHidden = false
    input?.resignFirstResponder()
     self.view.endEditing(true)
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
   searchLocation()
    table?.isHidden = false
      self.input?.resignFirstResponder()
    return (true)
  }
  
  private func resetTextField() {
    input?.resignFirstResponder()
    self.view.layoutIfNeeded()

  }
  
  func searchLocation(){
    //TextField to perform the search
    let textfield = input
    // grab text from textfield
    if let query = textfield?.text {
      //Iniatialize empty array to store results
      
      DispatchQueue.global(qos: .userInteractive).async{
        LocationService.fetchData(for: query, completion: {(result) in
          for data in result {
            self.dataSet.append(data)
          }
          
          self.table?.reloadData()
        })
      }
    }
  }
}
