//
//  LocationSettingsController+navbar.swift
//  leBaluchon
//
//  Created by Mathieu Janneau on 13/01/2018.
//  Copyright © 2018 Mathieu Janneau. All rights reserved.
//

import UIKit

extension LocationSettingsController {
  
  func setupNavbar(){
    
    //Properties
    let margin : CGFloat = 8
    let buttonHeight : CGFloat = 50
    let buttonWidth : CGFloat = 100
    
    //Instantiate Navbar
    let navBar: UIView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 60))
    let navBarWidth : CGFloat = navBar.frame.width
    //Set background color and alpha
    navBar.backgroundColor = UIColor.white
    //add to superview
    self.view.addSubview(navBar)
    addBackButton(navBarWidth, margin,buttonWidth,buttonHeight, navBar)
    addSearchInputField(margin,buttonWidth, navBarWidth, buttonHeight, navBar)
  }
  
  private func addSearchInputField(_ margin: CGFloat,_ buttonWidth:CGFloat, _ navBarWidth: CGFloat, _ buttonHeight: CGFloat, _ navBar: UIView) {
    //add textInput for search
    let searchInput = UITextField(frame: CGRect(x: (2 * margin + buttonWidth ), y: margin, width: navBarWidth - (2 * margin ) - (2 * margin ), height: buttonHeight))
    //Placeholdr text
    searchInput.placeholder = "Enter your request"
    searchInput.delegate = self
    input = searchInput
    // add it to navbar
    navBar.addSubview(searchInput)
  }
  
  private func addBackButton(_ navBarWidth: CGFloat, _ margin: CGFloat, _ buttonWidth: CGFloat, _ buttonHeight: CGFloat, _ navBar: UIView) {
    //add Search button
    //Create button
    let button = UIButton(frame: CGRect(x: margin, y: margin, width: buttonWidth, height: buttonHeight))
    // set title
    button.setTitle("Back", for: .normal)
    // Set title font
    button.titleLabel?.font = UIFont(name: "Montserrat-Bold", size:18)
    //Set title Color RGBA
    button.setTitleColor((selectedTextColor), for: .normal)
    //Add action
    //search.addTarget(self, action: #selector(self.performSearch), for: .touchUpInside)
    // add it to navbar
    button.addTarget(self, action: #selector(self.goBack), for: .touchUpInside)
    navBar.addSubview(button)
  }
  
  @objc func goBack(sender: UIButton){

    
    dismiss(animated: true, completion: nil)
    table!.reloadData()

  }

}
