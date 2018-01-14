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
  var autodetect = false
  
  
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
    inputFieldSetup()
    topTextViewSetup()
    loadLanguageSettings()
    
    //Observe when keyboard appears and trigger the animation up
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    inputFieldSetup()
    topTextViewSetup()
    loadLanguageSettings()
  }
  
  // MARK: - ACTIONS
  @IBAction func toggleAutodetection(_ sender: UISwitch) {
    if sender.isOn {
      autodetect = true
    } else {
      autodetect = false
    }
  }
  
  
  
  // MARK : - Methods
  // Load Data from Userdefault
  private func loadLanguageSettings() {
    homeLanguage.text = UserSettings.defaults.object(forKey: "homeLanguage") as! String!
    awayLanguage.text = UserSettings.defaults.object(forKey: "awayLanguage") as! String!
  }
  fileprivate func fetchTranslationforUrl(_ url: String) {
    translationService.fetchTranslation(translationUrl: url, completion: {(result) in
      self.translationContainer.text  = result!.text
    })
  }
  
  func translate(_ text: String) {
    var url = ""
    if autodetect {
      translationService.detectLanguage(from: text, completion: {(language) in
        
        url = self.translationService.createRequestUrl(text: text, from: String(language), to: self.awayLanguage.text!)
        self.fetchTranslationforUrl(url)
        self.homeLanguage.text! = String(language)
      })
      
    } else{
      url = translationService.createRequestUrl(text: text, from: homeLanguage.text!, to: awayLanguage.text!)
      fetchTranslationforUrl(url)
    }
    
    
    
  }
  
  // MARK: - UI Setup Methods
  
  func inputFieldSetup() {
    inputTextField.delegate = self
    inputTextField.font = UIFont(name: "Montserrrat-Regular.otf", size: 17.0)
    inputTextField.textAlignment = .left
    let inputSentence = "Type your text here"
    let url = translationService.createRequestUrl(text: inputSentence, from: "en", to: homeLanguage.text!)
    translationService.fetchTranslation(translationUrl: url, completion: {(result) in
      self.inputTextField.attributedPlaceholder = NSAttributedString(string: result!.text, attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
    })
  }
  
  func topTextViewSetup(){
    let translationSentence = "Your translation will appear here"
    let url = translationService.createRequestUrl(text: translationSentence, from: "en", to: homeLanguage.text!)
    translationService.fetchTranslation(translationUrl: url, completion: {(result) in
      self.translationContainer.text = result!.text
    })
  }
  
  
}
