//
//  LanguageSettings.swift
//  leBaluchon
//
//  Created by Mathieu Janneau on 11/01/2018.
//  Copyright © 2018 Mathieu Janneau. All rights reserved.
//

import UIKit

/**
 Handles all the language Settings for home and away city
 */
class LanguageSettings: UITableViewController {
  
  // ////////////////// //
  // MARK: - properties //
  // ////////////////// //
  
   /// Array to store the results from search before displaying them in the tableView
  let dataSet = Languages.languages
  
  
  //Init properties
  /// storing keys in UserDefaults for Away City
  var awayDisplayKey : String
   /// storing keys in UserDefaults for home City
  var homeDisplayKey : String
  /// storing keys in UserDefaults for home CityIndex
  var homeIndexKey: String = "homeLanguageIndex"
  /// storing keys in UserDefaults for Away CityIndex
  var awayIndexKey: String = "awayLanguageIndex"
  
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
  
  // MARK: - Custom Initializer
  init(style:UITableViewStyle, homeDisplayKey:String, awayDisplayKey:String, homeIndexKey:String,awayIndexKey:String){
    self.awayDisplayKey = awayDisplayKey
    self.homeDisplayKey = homeDisplayKey
    self.homeIndexKey = homeIndexKey
    self.awayIndexKey = awayIndexKey
    super.init(style: style)
  }
  /**
   Method that allows us to use the same controller for away and home language
   by sending color scheme and destination "home" or "away"
   - parameters:
   - bgColor: UIColor. Background color
   - txtSelecct: UIColor.TintColor for Higligtht
   - destination: String. destination "home" or "away"
 */
  func initDetail(bgColor:UIColor, txtSelect: UIColor, destination: String){
    self.backgroundColor = bgColor
    self.selectedTextColor = txtSelect
    self.source = destination
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // ///////////////////////// //
  // MARK: - LifeCycle Methods //
  // ///////////////////////// //
  
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
    // Load data pastly stored and display it visualy in the tableView
    if source == "home" { // home
      selectedHome = UserSettings.loadData(displayKey: homeDisplayKey, indexKey: homeIndexKey).1
      home = dataSet[selectedHome!][value]!
      selectRow(selectedHome!)
    } else { // away
      selectedAway = UserSettings.loadData(displayKey: awayDisplayKey, indexKey: awayIndexKey).1
      away = dataSet[selectedAway!][value]!
      selectRow(selectedAway!)
    }
  }
  
  override func viewWillDisappear(_ animated: Bool){
    // save data when leaving the controller
    if source == "home" { //home
      UserSettings.saveData(displayKey: homeDisplayKey, value: home!, indexKey: homeIndexKey, index: selectedHome!)
    } else {//away
      UserSettings.saveData(displayKey: awayDisplayKey, value: away!, indexKey: awayIndexKey, index: selectedAway!)
    }
  }
  
  // //////////////////////////////////// //
  // MARK: - Table view delegate methods  //
  // //////////////////////////////////// //
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataSet.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
    //load data set
    let data = dataSet[indexPath.row]
    setup(cell, with: data)
    // check is cell is seleccted and apply the current highligth color Scheme
    if cell.isSelected{
      highlight(cell,with: selectedTextColor!)
    }
    return cell
  }
  
  // /////////////////////////// //
  // MARK: - Cell State handling //
  // /////////////////////////// //
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // Add a visual cue to indicate that the cell was selected.
    
    if source == "home" { // home
      home = dataSet[indexPath.row][value]!
      away = ""
      selectedHome = indexPath.row
    } else { // away
      home = ""
      away = dataSet[indexPath.row][value]!
      selectedAway = indexPath.row
    }
    let cell = tableView.cellForRow(at: indexPath)
    // visually higligth selected cell
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
  
  // ////////////////////////////////// //
  // MARK: - custom cell style handling //
  // ////////////////////////////////// //
  
  /// set style and data for cell
  ///
  /// - Parameter cell: UITableViewCell cell to style
  func setup(_ cell: UITableViewCell, with data:[String:String]){
    //Setup data
    cell.textLabel?.text = data["name"]
    //set up cell appearance
    cell.backgroundColor = backgroundColor
    cell.textLabel?.textColor = .white
    cell.textLabel?.font = UIFont(name: "Montserrat-regular.otf", size: 18.0)
  }
  /// Used to select the cell according to Language code
  ///
  /// - Parameter rowNumber: Int row number to select
  func selectRow(_ rowNumber: Int){
    let indexPath = IndexPath(row:rowNumber , section: 0)
    self.tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
  }
  
  /// Change to new selected colorScheme fonts & check mark
  ///
  /// - Parameters:
  ///   - cell: UITableViewCell to Style
  ///   - color: UIColor colorschem Color
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
  
  
  /// Reset Style to default
  ///
  /// - Parameter indexPath: indexPAth of the Cell to resets
  func deSelectedCell(at indexPath: IndexPath){
    // remove checkMark
    tableView.cellForRow(at: indexPath)?.accessoryType = .none
    // Reset Background color
    tableView.cellForRow(at: indexPath)?.backgroundColor = backgroundColor
    // Reset Text color to default value
    tableView.cellForRow(at: indexPath)?.textLabel?.textColor = UIColor.white
  }
  
}
