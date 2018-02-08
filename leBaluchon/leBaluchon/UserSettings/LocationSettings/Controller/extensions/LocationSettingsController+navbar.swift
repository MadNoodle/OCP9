//
//  LocationSettingsController+navbar.swift
//  leBaluchon
//
//  Created by Mathieu Janneau on 13/01/2018.
//  Copyright © 2018 Mathieu Janneau. All rights reserved.
//

import UIKit

/**
 This extension handles everything relative to the navbar in the Location settings Controller
 */
extension LocationSettingsController {

  ///  Instantiate a bespoke nav bar containing input text field and back button
  func setupNavbar(){
    //Properties
    /// Margin Constant
    let margin : CGFloat = 8
    /// Navigation Bar Button Height in px
    let buttonHeight : CGFloat = 50
    /// Navigation Bar Button width in px
    let buttonWidth : CGFloat = 100
    
    // instantiation
    /// Instantiate Navbar
    let navBar: UIView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 60))
    let navBarWidth : CGFloat = navBar.frame.width
    //Set background color and alpha
    navBar.backgroundColor = UIColor.white
    //add to superview
    self.view.addSubview(navBar)
    addBackButton(navBarWidth, margin,buttonWidth,buttonHeight, navBar)
    addSearchInputField(margin,buttonWidth, navBarWidth, buttonHeight, navBar)
  }
  
  /// Programatically created textfield
  ///
  /// - Parameters:
  ///   - navBarWidth: CGFloat width of navbar
  ///   - margin: CGFloat Margin between items
  ///   - buttonWidth: CGFloat width of buttons
  ///   - buttonHeight: CGFloat height of buttons
  ///   - navBar: UIView NavBar container
  private func addSearchInputField(_ margin: CGFloat,_ buttonWidth:CGFloat, _ navBarWidth: CGFloat, _ buttonHeight: CGFloat, _ navBar: UIView) {
    /// add textInput for search
    let searchInput = UITextField(frame: CGRect(x: (2 * margin + buttonWidth ), y: margin, width: navBarWidth - (2 * margin ) - (2 * margin ), height: buttonHeight))
    // Placeholder text
    searchInput.placeholder = "Enter your request"
    searchInput.delegate = self
    input = searchInput
    // add it to navbar
    navBar.addSubview(searchInput)
  }
  

  /// Programatically created back button
  ///
  /// - Parameters:
  ///   - navBarWidth: CGFloat width of navbar
  ///   - margin: CGFloat Margin between items
  ///   - buttonWidth: CGFloat width of buttons
  ///   - buttonHeight: CGFloat height of buttons
  ///   - navBar: UIView NavBar container
  private func addBackButton(_ navBarWidth: CGFloat, _ margin: CGFloat, _ buttonWidth: CGFloat, _ buttonHeight: CGFloat, _ navBar: UIView) {
    /// Create button
    let button = UIButton(frame: CGRect(x: margin, y: margin, width: buttonWidth, height: buttonHeight))
    // set title
    button.setTitle("Back", for: .normal)
    // Set title font
    button.titleLabel?.font = UIFont(name: "Montserrat-Bold", size:18)
    //Set title Color RGBA
    button.setTitleColor((selectedTextColor), for: .normal)
    // add it to navbar
    button.addTarget(self, action: #selector(self.goBack), for: .touchUpInside)
    navBar.addSubview(button)
  }
  

  /// Callback function / selector for back button
  ///
  /// - Parameter sender: Left Navbar Button
  @objc func goBack(sender: UIButton){
    dismiss(animated: true, completion: nil)
    table!.reloadData()

  }

}
