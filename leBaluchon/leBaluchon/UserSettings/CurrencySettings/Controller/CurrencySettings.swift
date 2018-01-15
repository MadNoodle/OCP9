//
//  CurrencySettings.swift
//  leBaluchon
//
//  Created by Mathieu Janneau on 11/01/2018.
//  Copyright © 2018 Mathieu Janneau. All rights reserved.
//

import UIKit

/**
 This class handles the settings for Currency selecction for home and away coountry and stores them in persistent container
 */
class CurrencySettings: UITableViewController {
  //Initialize dataModel
  let dataSet = CurrencyList.list
  
  // MARK: - properties
  
  //Init properties
  var awayDisplayKey : String
  var homeDisplayKey : String
  var homeIndexKey: String = "homeCurrencyIndex"
  var awayIndexKey: String = "awayCurrencyIndex"
  
  //Value to customize Color Scheme
  var backgroundColor : UIColor?
  var selectedTextColor  : UIColor?
  
  // Value to store
  var source = "home"
  var value = "log"
  var away : String?
  var home : String?
  var selectedHome : Int?
  var selectedAway : Int?
  
  // MARK: - Custom Initializer
  init(style:UITableViewStyle, homeDisplayKey:String, awayDisplayKey:String, homeIndexKey:String,awayIndexKey:String){
    self.awayDisplayKey = awayDisplayKey
    self.homeDisplayKey = homeDisplayKey
    self.homeIndexKey = homeIndexKey
    self.awayIndexKey = awayIndexKey
    super.init(style: style)
  }
  
  
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
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  // MARK: - LifeCycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")
    tableView.reloadData()
  }
  
  
  override func viewWillAppear(_ animated: Bool){
    super.viewWillAppear(animated)
    // reload data when pushing the VC
    tableView.reloadData()
    if source == "home" {
      selectedHome = UserSettings.loadData(displayKey: homeDisplayKey, indexKey: homeIndexKey).1
      home = dataSet[selectedHome!]
      // highligth the cell according to the saved value
      selectRow(selectedHome!)
    } else { // is Away
      selectedAway = UserSettings.loadData(displayKey: awayDisplayKey, indexKey: awayIndexKey).1
      away = dataSet[selectedAway!]
      // highligth the cell according to the saved value
      selectRow(selectedAway!)
    }
  }
  
  
  override func viewWillDisappear(_ animated: Bool){
    // save data when going back to userSettings Vc
    if source == "home" {
      UserSettings.saveData(displayKey: homeDisplayKey, value: home!, indexKey: homeIndexKey, index: selectedHome!)
    } else { // is Away
      UserSettings.saveData(displayKey: awayDisplayKey, value: away!, indexKey: awayIndexKey, index: selectedAway!)
    }
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  
  // MARK: - Table View Protocol Methods
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataSet.count
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
    //load data set
    let data = dataSet[indexPath.row]
    cell.textLabel?.text = data
    setup(cell)
    // check is cell is seleccted and apply the current highligth color Scheme
    if cell.isSelected{
      highlight(cell,with: selectedTextColor!)
    }
    return cell
  }
  
  
  // MARK: - Cell State handling
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    // Send back value to data exchange properties in order
    //to retrieve them in user settings
    if source == "home" {
      home = dataSet[indexPath.row]
      away = ""
      selectedHome = indexPath.row
    } else { // is Away
      home = ""
      away = dataSet[indexPath.row]
      selectedAway = indexPath.row
    }
    // Add a visual cue to indicate that the cell was selected.
    let cell = tableView.cellForRow(at: indexPath)
    highlight(cell!, with: selectedTextColor!)
  }
  
  
  override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    // Invoked so we can prepare for a change in selection.
    // Remove previous selection, if any.
    if let selectedIndex = self.tableView.indexPathForSelectedRow {
      self.tableView.deselectRow(at: selectedIndex, animated: false)
      // Remove the visual selection indications checkmark and color scheme.
      deSelectedCell(at: selectedIndex)
    }
    return indexPath
  }
  
  // MARK: - custom cell style handling
  
  
  /**
   set style and data for cell
   */
  func setup(_ cell: UITableViewCell){
    //Setup data
    
    //set up cell appearance
    cell.backgroundColor = backgroundColor
    cell.textLabel?.textColor = .white
    cell.textLabel?.font = UIFont(name: "Montserrat-regular.otf", size: 18.0)
  }
  
  
  /**
   Used to select the cell according to Language code
   */
  func selectRow(_ rowNumber: Int){
    let indexPath = IndexPath(row:rowNumber , section: 0)
    self.tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
  }
  
  
  /**
   Change to new selected colorScheme fonts & check mark
   */
  func highlight(_ cell: UITableViewCell, with color: UIColor){
    // Set the higlight color scheme
    cell.tintColor = color
    cell.textLabel?.textColor =  color
    // Set cell background to white
    cell.backgroundColor = .white
    let bgColorView = UIView()
    bgColorView.backgroundColor = UIColor.white
    cell.selectedBackgroundView = bgColorView
    // add a check mark
    cell.accessoryType = .checkmark
  }
  
  
  /**
   Reset Style to default
   */
  func deSelectedCell(at indexPath: IndexPath){
    // remove checkMark
    tableView.cellForRow(at: indexPath)?.accessoryType = .none
    // Reset Background color
    tableView.cellForRow(at: indexPath)?.backgroundColor = backgroundColor
    // Reset Text color to default value
    tableView.cellForRow(at: indexPath)?.textLabel?.textColor = UIColor.white
  }
  
  
}
