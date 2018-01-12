//
//  TranslationViewController.swift
//  leBaluchon
//
//  Created by Mathieu Janneau on 07/01/2018.
//  Copyright © 2018 Mathieu Janneau. All rights reserved.
//

import UIKit

class TranslationViewController: UIViewController,UITextFieldDelegate {
  // Initialize Translation Service
  let translationService = TranslationService()
  // Load Data from Userdefault
  private func loadLanguageSettings() {
    homeLanguage.text = UserSettings.defaults.object(forKey: "homeLanguage") as! String!
    awayLanguage.text = UserSettings.defaults.object(forKey: "awayLanguage") as! String!
  }
  
  // MARK: - OUTLETS
  @IBOutlet weak var stackView: UIStackView!
  @IBOutlet weak var homeLanguage: UILabel!
  @IBOutlet weak var awayLanguage: UILabel!
  @IBOutlet weak var inputTextField: UITextField!
  @IBOutlet weak var translationContainer: UITextView!
  @IBOutlet weak var topView: UIView!
  
  // MARK: - CONSTRAINT OUTLETS
  @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
  var originalConstraint: CGFloat = 0
  
  // MARK: - LifeCycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Translation"
    inputTextField.delegate = self
    loadLanguageSettings()
    //Observe when keyboard appears and trigger the animation up
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    loadLanguageSettings()
  }
  
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
  
  // MARK: - TextField Delegate Methods
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    translate()
    resetTextField()
    self.view.endEditing(true)
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
   
    resetTextField()
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    translate()
    resetTextField()
    return (true)
  }
  
  private func resetTextField() {
    inputTextField.resignFirstResponder()
    self.view.layoutIfNeeded()
    resetStackViewToOriginal()
  }
  
  func translate() {
    let url = translationService.createRequestUrl(text: inputTextField.text!, from: homeLanguage.text!, to: awayLanguage.text!)
    translationService.fetchTranslation(translationUrl: url, completion: {(result) in
      self.translationContainer.text  = result!.text
    })
   
  }
  
}
