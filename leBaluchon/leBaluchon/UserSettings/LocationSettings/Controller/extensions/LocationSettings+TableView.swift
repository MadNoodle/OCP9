//
//  LocationSettings+TableView.swift
//  leBaluchon
//
//  Created by Mathieu Janneau on 13/01/2018.
//  Copyright © 2018 Mathieu Janneau. All rights reserved.
//

import UIKit

/**
 This extension handles everything relative to the tableView
 in the Location settings Controller, including delegate methods,
 and custom styling
 */
extension LocationSettingsController: UITableViewDelegate, UITableViewDataSource {
  
  /**
   Programmatically created tableView
 */
  func setupTableView() -> UITableView {
    //height is minus 50 to leave the place for navBar.
    let height = self.view.frame.height - 50
    let width = self.view.frame.width
    // Intantiation
    let tableView = UITableView(frame: CGRect(x: 0, y: 60, width: width, height: height))
    //Styling
    tableView.backgroundColor = backgroundColor
    return tableView
  }

  // MARK: - Table View Delegate Methods
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  return dataSet.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath)
    //load data set
    let data = dataSet[indexPath.row ]
    cell.textLabel?.text = "\(data.city),\(data.region),\(data.country) "
    
    setup(cell)
    // check is cell is selected and apply the current highligth color Scheme
    if cell.isSelected {
      highlight(cell, with: selectedTextColor!)
    }
    return cell
  }

  // MARK: - Cell State handling
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
   
    // Store value to pass tehm to user Settings Vc
    if source == .home {
      home = dataSet[indexPath.row].city
      selectedHome = indexPath.row
      away = ""
    } else {
      home = ""
      away = dataSet[indexPath.row].city
      selectedAway = indexPath.row
    }
     // Add a visual cue to indicate that the cell was selected.
    let cell = tableView.cellForRow(at: indexPath)
    highlight(cell!, with: selectedTextColor!)
  }

  // MARK: - custom cell style handling

  //set style and data for cell
  func setup(_ cell: UITableViewCell) {
    //Setup data

    //set up cell appearance
    cell.backgroundColor = backgroundColor
    cell.textLabel?.textColor = .white
    cell.textLabel?.font = UIFont(name: Constants.FontFamily.montserrat, size: 18.0)
  }

  //change to new selected colorScheme fonts & check mark
  func highlight(_ cell: UITableViewCell, with color: UIColor) {
    //Higlight Color Schem
    cell.tintColor = color
    cell.textLabel?.textColor =  color
    cell.backgroundColor = .white
    // Background Color Higligth
    let bgColorView = UIView()
    bgColorView.backgroundColor = UIColor.white
    cell.selectedBackgroundView = bgColorView
    // Add a checkMark
    cell.accessoryType = .checkmark
  }

  //Used to select the cell according to Language code
  func selectRow(_ rowNumber: Int) {
    let indexPath = IndexPath(row: rowNumber, section: 0)
    table?.selectRow(at: indexPath, animated: false, scrollPosition: .none)
  }
  
  // Reset Style to default
  func deSelectedCell(at indexPath: IndexPath) {
    table?.cellForRow(at: indexPath)?.accessoryType = .none
    table?.cellForRow(at: indexPath)?.backgroundColor = backgroundColor
    table?.cellForRow(at: indexPath)?.textLabel?.textColor = UIColor.white
  }
}
