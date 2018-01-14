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
    dataSet = []
    input?.text = ""
    table?.reloadData()
  }
  
  private func saveLocationSettings() {
    if source == "home" {
      if selectedHome != nil
      {UserSettings.saveData(displayKey: homeDisplayKey, value: home!, indexKey: homeIndexKey, index: selectedHome!)}
      
    } else {
      if selectedAway != nil
      { UserSettings.saveData(displayKey: awayDisplayKey, value: away!, indexKey: awayIndexKey, index: selectedAway!)}
    }
  }
}
