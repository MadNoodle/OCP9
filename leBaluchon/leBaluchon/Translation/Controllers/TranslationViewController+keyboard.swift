//
//  TranslationViewController+keyboard.swift
//  leBaluchon
//
//  Created by Mathieu Janneau on 13/01/2018.
//  Copyright © 2018 Mathieu Janneau. All rights reserved.
//

import UIKit

extension TranslationViewController {
  
  // MARK: - Keyboard folding methods
  @objc func keyboardWillShow(notification: NSNotification){
    if let info = notification.userInfo{
      //grab CGRect size of keybaord
      let rect : CGRect = info["UIKeyboardFrameEndUserInfoKey"] as! CGRect
      self.view.layoutIfNeeded()
      self.topView.isHidden = true
      //animating stack view up
      UIView.animate(withDuration: 0.25 , animations: {
        self.view.layoutIfNeeded()
        //self.topView.isHidden = true
        self.bottomConstraint.constant = rect.height - 50
      })
    }
  }
  
  func resetStackViewToOriginal() {
    UIView.animate(withDuration: 0.25 , animations: {
      self.topView.isHidden = false
      self.bottomConstraint.constant = self.originalConstraint
      self.view.layoutIfNeeded()
    })}
  

  
}
