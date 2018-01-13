//
//  LocationSettings+TableView.swift
//  leBaluchon
//
//  Created by Mathieu Janneau on 13/01/2018.
//  Copyright © 2018 Mathieu Janneau. All rights reserved.
//

import UIKit

extension LocationSettingsController : UITableViewDelegate,UITableViewDataSource {
  
  func setupTableView() -> UITableView{
    let height = self.view.frame.height - 50
    let width = self.view.frame.width
    //add textInput for search
    let tableView = UITableView(frame: CGRect(x: 0, y: 50, width: width, height: height))
    //Placeholdr text
    tableView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
    return tableView
  }

  // MARK: - Table View Delegate Methods
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  // MARK: - Table View Protocol Methods
 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  return dataSet.count
  }

  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
    //load data set
    let data = dataSet[indexPath.row]
    cell.textLabel?.text = "\(data.city),\(data.region),\(data.country) "
    
    setup(cell)
    // check is cell is seleccted and apply the current highligth color Scheme
    if cell.isSelected{
      highlight(cell,with: selectedTextColor!)
    }
    return cell
  }

  // MARK: - Cell State handling
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // Add a visual cue to indicate that the cell was selected.

    if source == "home" {
      home = dataSet[indexPath.row].city
      away = ""
      selectedHome = indexPath.row
    } else {
      home = ""
      away = dataSet[indexPath.row].city
      selectedAway = indexPath.row
    }
    let cell = tableView.cellForRow(at: indexPath)
    highlight(cell!, with: selectedTextColor!)
  }


  // MARK: - custom cell style handling

  //set style and data for cell
  func setup(_ cell: UITableViewCell){
    //Setup data

    //set up cell appearance
    cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
    cell.textLabel?.textColor = .white
    cell.textLabel?.font = UIFont(name: "Montserrat-regular.otf", size: 18.0)
  }


  //change to new selected colorScheme fonts & check mark
  func highlight(_ cell: UITableViewCell, with color: UIColor){
    cell.tintColor = color
    cell.accessoryType = .checkmark
    cell.textLabel?.textColor =  color
    cell.backgroundColor = .white
    let bgColorView = UIView()
    bgColorView.backgroundColor = UIColor.white
    cell.selectedBackgroundView = bgColorView
  }

  //Used to select the cell according to Language code
  func selectRow(_ rowNumber: Int){
    let indexPath = IndexPath(row:rowNumber , section: 0)
    table?.selectRow(at: indexPath, animated: false, scrollPosition: .none)
  }
  

  
  // Reset Style to default
  func deSelectedCell(at indexPath: IndexPath){
    table?.cellForRow(at: indexPath)?.accessoryType = .none
    table?.cellForRow(at: indexPath)?.backgroundColor = backgroundColor
    table?.cellForRow(at: indexPath)?.textLabel?.textColor = UIColor.white
  }
  

}

