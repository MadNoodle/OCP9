//
//  LocationSettingsController+textField.swift
//  leBaluchon
//
//  Created by Mathieu Janneau on 13/01/2018.
//  Copyright © 2018 Mathieu Janneau. All rights reserved.
//

import UIKit

/**
 This extension handles everything relative to the textField in the Location settings Controller, including delegate methods
 */
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
  /**
   This method takes the input text and generate a request trhoughth Location Service
   - returns : [LocationModel] that will be displayed in table view
 */
  func searchLocation(){
    //TextField to perform the search
    let textfield = input
    // grab text from textfield
    if let query = textfield?.text {
      
      // Background task to save time for UI display
      DispatchQueue.global(qos: .userInteractive).async{
        LocationService.fetchData(for: query, completion: {(result) in
          for data in result {
            self.dataSet.append(data)
          }
          // display data in tableView
          self.table?.reloadData()
        })
      }
    }
  }
}
