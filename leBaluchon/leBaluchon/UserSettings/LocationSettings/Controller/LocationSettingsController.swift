//
//  LocationSettingsController.swift
//  leBaluchon
//
//  Created by Mathieu Janneau on 13/01/2018.
//  Copyright © 2018 Mathieu Janneau. All rights reserved.
//

import UIKit

class LocationSettingsController: UIViewController {
  
  var dataSet = [LocationModel]()
  // MARK: - properties
  //Init properties
  var table : UITableView?
  var input : UITextField?
  // storing keys in UserDefaults for home City
  var homeDisplayKey : String = "homeCity"
  var homeIndexKey: String = "homeCityIndex"
  
  // storing keys in UserDefaults for Away City
  var awayDisplayKey : String = "awayCity"
  var awayIndexKey: String = "awayCityIndex"
  
  //Value to customize Color Scheme
  var backgroundColor : UIColor?
  var selectedTextColor  : UIColor?
  
  // Value to store
  var source = "home"
  var value = "log"
  var home : String?
  var away : String?
  var selectedHome : Int?
  var selectedAway : Int?
  
  /**
   Additive init method that allows us to pass the color scheme just before pushing the Vc from generalSettings Vc.
   - important: To change the colors, you need to change them in UserSettingsViewController.
   - parameters:
   - bgColor: UIcolor for background
   - txtSelect: UIColor secondary color for text and highlights
   - destination: String.
   ** Can be home or away. This value
   allows us to pass the value to the good vc and to retrieve them in the persistent container
   */
  func initDetail(bgColor:UIColor, txtSelect: UIColor, destination: String){
    self.backgroundColor = bgColor
    self.selectedTextColor = txtSelect
    self.source = destination
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupNavbar()
    self.view.backgroundColor = backgroundColor
    self.table = setupTableView()
    self.view.addSubview(table!)
    table?.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")
    table?.delegate = self
    table?.dataSource = self
    table?.isHidden = true
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    self.view.backgroundColor = backgroundColor
    table?.isHidden = true
  }
  
  
  override func viewWillDisappear(_ animated: Bool){
    if input?.text != nil {
      saveLocationSettings()
    }
    // reset the tableView to empty to not interfer if user directly goes to the away controller
    dataSet = []
    input?.text = ""
    table?.reloadData()
  }
  /**
   Pretty self explanatory. Stores value in persistent container
   */
  private func saveLocationSettings() {
    if source == "home" {
      // Sanity check for empty texfield
      if selectedHome != nil
      {
        UserSettings.saveData(displayKey: homeDisplayKey, value: home!, indexKey: homeIndexKey, index: selectedHome!)}
      
    } else {
      // Sanity check for empty texfield
      if selectedAway != nil
      { UserSettings.saveData(displayKey: awayDisplayKey, value: away!, indexKey: awayIndexKey, index: selectedAway!)}
    }
  }
}
