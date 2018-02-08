//
//  LocationSettingsController.swift
//  leBaluchon
//
//  Created by Mathieu Janneau on 13/01/2018.
//  Copyright © 2018 Mathieu Janneau. All rights reserved.
//

import UIKit

class LocationSettingsController: UIViewController {

  
  // ////////////////// //
  // MARK: - properties //
  // ////////////////// //
  
  /// Array to store the results from search before displaying them in the tableView
  var dataSet = [LocationModel]()
  
  //Init properties
  /// table view to display location results
  var table : UITableView?
  /// textField where user enter his query
  var input : UITextField?
  /// storing keys in UserDefaults for home City
  var homeDisplayKey : String = "homeCity"
  /// storing keys in UserDefaults for home CityIndex
  var homeIndexKey: String = "homeCityIndex"
  /// storing keys in UserDefaults for Away City
  var awayDisplayKey : String = "awayCity"
  /// storing keys in UserDefaults for Away CityIndex
  var awayIndexKey: String = "awayCityIndex"
  /// Value to customize Color Scheme background
  
  // Color Scheme properties
  /// Value to customize Color Scheme background
  var backgroundColor : UIColor?
   /// Value to customize Color Scheme text
  var selectedTextColor  : UIColor?
  // Value to store
  /// storing the value if location is home or Away
  var source = "home"
  /// CoreData key to retrieve value
  var value = "log"
  /// Optional Value that stores home city Name
  var home : String?
  /// Optional Value that stores Away city Name
  var away : String?
  /// Optional Value that stores home city Index to highligth it in tableView when reloading
  var selectedHome : Int?
  /// Optional Value that stores Away city Index to highligth it in tableView when reloading
  var selectedAway : Int?

  ///  Additive init method that allows us to pass the color scheme just before pushing the Vc from generalSettings Vc.
  ///- important: To change the colors, you need to change them in UserSettingsViewController.
  ///
  /// - Parameters:
  ///   - bgColor: UIcolor for background
  ///   - txtSelect: UIColor secondary color for text and highlights
  ///   - destination: String Location
  func initDetail(bgColor:UIColor, txtSelect: UIColor, destination: String){
    self.backgroundColor = bgColor
    self.selectedTextColor = txtSelect
    self.source = destination
  }
  
  // /////////////////////// //
  // MARK: LifeCycle Methods //
  // /////////////////////// //
  
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
  
  // ////////////////////// //
  // MARK: - Saving methods //
  // ////////////////////// //
  
  
  /**
   Stores value in persistent container
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
