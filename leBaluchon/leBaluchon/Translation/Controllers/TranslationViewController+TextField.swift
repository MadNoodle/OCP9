//
//  TranslationViewController+TextField.swift
//  leBaluchon
//
//  Created by Mathieu Janneau on 13/01/2018.
//  Copyright © 2018 Mathieu Janneau. All rights reserved.
//

import UIKit

extension TranslationViewController {
  // MARK: - TextField Delegate Methods
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    translate(inputTextField.text!)
    resetTextField()
    self.view.endEditing(true)
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    translate(inputTextField.text!)
    resetTextField()
    return (true)
  }
  
  private func resetTextField() {
    inputTextField.resignFirstResponder()
    self.view.layoutIfNeeded()
    resetStackViewToOriginal()
  }
}
