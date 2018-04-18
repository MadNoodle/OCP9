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
class DetailSettings: UITableViewController {
  
  // ////////////////// //
  // MARK: - properties //
  // ////////////////// //
  
   /// Array to store the results from search before displaying them in the tableView
  var dataSet: [[String: String]] = []
  
  //Init properties
  /// storing keys in UserDefaults for Away City
  var awayDisplayKey: String = ""
   /// storing keys in UserDefaults for home City
  var homeDisplayKey: String = ""
  /// storing keys in UserDefaults for home CityIndex
  var homeIndexKey: String = ""
  //"homeLanguageIndex"
  /// storing keys in UserDefaults for Away CityIndex
  var awayIndexKey: String = ""
  //"awayLanguageIndex"
  
  // Color Scheme properties
  /// Value to customize Color Scheme background
  var backgroundColor: UIColor?
  /// Value to customize Color Scheme text
  var selectedTextColor: UIColor?
  // Value to store
  var controllerType: Settings?
  /// storing the value if location is home or Away
  var source: Destination?
  /// CoreData key to retrieve value
  var value = "log"
  /// Optional Value that stores home city Name
  var home: String?
  /// Optional Value that stores Away city Name
  var away: String?
  /// Optional Value that stores home city Index to highligth it in tableView when reloading
  var selectedHome: Int?
  /// Optional Value that stores Away city Index to highligth it in tableView when reloading
  var selectedAway: Int?
  
  // MARK: - Custom Initializer

  /**
   Method that allows us to use the same controller for away and home language
   by sending color scheme and destination "home" or "away"
   - parameters:
   - bgColor: UIColor. Background color
   - txtSelecct: UIColor.TintColor for Higligtht
   - destination: String. destination "home" or "away"
 */
  func initDetail(destination: Destination, of type: Settings) {
    if destination == .home {
      self.backgroundColor = ColorTemplate.green.rawValue
      self.selectedTextColor = ColorTemplate.red.rawValue
    } else {
      self.backgroundColor = ColorTemplate.red.rawValue
      self.selectedTextColor = ColorTemplate.green.rawValue
    }
    self.controllerType = type
    self.source = destination
  }

  // ///////////////////////// //
  // MARK: - LifeCycle Methods //
  // ///////////////////////// //
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupProperties(for: controllerType!)
    tableView.delegate = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
    tableView.reloadData()
  }
  
  func setupProperties(for controllerType: Settings) {
    switch controllerType {
    case .language:
      homeDisplayKey = Constants.LanguageStorage.home
      awayDisplayKey = Constants.LanguageStorage.away
      homeIndexKey = Constants.LanguageStorage.homeIndex
      awayIndexKey = Constants.LanguageStorage.awayIndex
      dataSet = Languages.languages
    case .currency:
      homeDisplayKey = Constants.CurrencyStorage.home
      awayDisplayKey = Constants.CurrencyStorage.away
      homeIndexKey = Constants.CurrencyStorage.homeIndex
      awayIndexKey = Constants.CurrencyStorage.awayIndex
      dataSet = CurrencyList.list
    case .location:
      break
    }
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    // reload data when pushing the VC
    tableView.reloadData()
    // Load data pastly stored and display it visualy in the tableView
    if source == .home { // home
      selectedHome = UserSettings.loadData(displayKey: homeDisplayKey, indexKey: homeIndexKey).1
      home = dataSet[selectedHome!][value]!
      selectRow(selectedHome!)
    } else { // away
      selectedAway = UserSettings.loadData(displayKey: awayDisplayKey, indexKey: awayIndexKey).1
      away = dataSet[selectedAway!][value]!
      selectRow(selectedAway!)
    }
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    // save data when leaving the controller
    if source == .home { //home
      UserSettings.saveData(displayKey: homeDisplayKey, value: home!, indexKey: homeIndexKey, index: selectedHome!)
      notifyChange(for: "home", with: home!, in: homeDisplayKey)
    } else {//away
      UserSettings.saveData(displayKey: awayDisplayKey, value: away!, indexKey: awayIndexKey, index: selectedAway!)
      notifyChange(for: "away", with: awayDisplayKey, in: away!)
    }

  }

  func notifyChange(for key: String, with value: String, in container: String) {
    switch controllerType {
    case .currency?:
    let place = "\(key)CurrencyValueChanged"
      NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: place),
                                                   object: nil,
                                                   userInfo: ["Key": container,
                                                              "currency": value]
      ))
    case .language?:
     let place = "\(key)LanguageValueChanged"
      NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: place),
                                                   object: nil,
                                                   userInfo: ["Key": container,
                                                              "language": value]
      ))
    case .location?:
      break
    case .none:
      break
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
    let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath)
    let data = dataSet[indexPath.row]["name"]!
 
    setup(cell, with: data)
    // check is cell is seleccted and apply the current highligth color Scheme
    if cell.isSelected {
      highlight(cell, with: selectedTextColor!)
    }
    return cell
  }
  
  // /////////////////////////// //
  // MARK: - Cell State handling //
  // /////////////////////////// //
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // Add a visual cue to indicate that the cell was selected.
    
    if source == .home { // home
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
  func setup(_ cell: UITableViewCell, with data: String) {
    //Setup data
    cell.textLabel?.text = data
    //set up cell appearance
    cell.backgroundColor = backgroundColor
    cell.textLabel?.textColor = .white
    cell.textLabel?.font = UIFont(name: Constants.FontFamily.montserrat, size: 18.0)
  }
  /// Used to select the cell according to Language code
  ///
  /// - Parameter rowNumber: Int row number to select
  func selectRow(_ rowNumber: Int) {
    let indexPath = IndexPath(row: rowNumber, section: 0)
    self.tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
  }
  
  /// Change to new selected colorScheme fonts & check mark
  ///
  /// - Parameters:
  ///   - cell: UITableViewCell to Style
  ///   - color: UIColor colorschem Color
  func highlight(_ cell: UITableViewCell, with color: UIColor) {
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
  func deSelectedCell(at indexPath: IndexPath) {
    // remove checkMark
    tableView.cellForRow(at: indexPath)?.accessoryType = .none
    // Reset Background color
    tableView.cellForRow(at: indexPath)?.backgroundColor = backgroundColor
    // Reset Text color to default value
    tableView.cellForRow(at: indexPath)?.textLabel?.textColor = UIColor.white
  }
  
}
