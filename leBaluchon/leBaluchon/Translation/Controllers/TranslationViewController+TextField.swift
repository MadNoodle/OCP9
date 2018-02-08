//
//  TranslationViewController+TextField.swift
//  leBaluchon
//
//  Created by Mathieu Janneau on 13/01/2018.
//  Copyright © 2018 Mathieu Janneau. All rights reserved.
//

import UIKit

/**
 Handles all text field delegate Methods
 */
extension TranslationViewController {
  // ////////////////////////////////// //
  // MARK: - TextField Delegate Methods //
  // ////////////////////////////////// //
  
  
  /**
  
 */
  ///  When user touches outside of the text field. it validates his text
  /// and send translation request. the keyboard disappear.
  ///
  /// - Parameters:
  ///   - touches: Touch
  ///   - event: event that trigger the action
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    translate(inputTextField.text!)
    resetTextField()
    self.view.endEditing(true)
  }
  

  /// When user presses enter on keyboard. it validates his text
  /// and send translation request. the keyboard disappear.
  ///
  /// - Parameter textField:  input textField
  /// - Returns: Boolean
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    translate(inputTextField.text!)
    resetTextField()
    return (true)
  }
  

  /// Animate back to original layout
  private func resetTextField() {
    inputTextField.resignFirstResponder()
    self.view.layoutIfNeeded()
    resetStackViewToOriginal()
  }
}
