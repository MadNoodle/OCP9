//
//  TranslationViewController.swift
//  leBaluchon
//
//  Created by Mathieu Janneau on 07/01/2018.
//  Copyright © 2018 Mathieu Janneau. All rights reserved.
//

import UIKit

/**
This controller handles translation display
 2 extensions complette him:
 - one for keyboard behaviour management
 - one for textField Delegation management
 */
class TranslationViewController: UIViewController, UITextFieldDelegate {
  
  // ////////////////// //
  // MARK: - properties //
  // ////////////////// //
  /// Initialize Translation Service
  let translationService = TranslationService()
  /// Iniatially set autodetect translation false. Change to true if autodetect always on
  var autodetect = false
  
  // ////////////////// //
  // MARK: - Outlets    //
  // ////////////////// //
  
  /// Stack View that contains the input and translation container
  @IBOutlet weak var stackView: UIStackView!
  /// Display the home language
  @IBOutlet weak var homeLanguage: UILabel!
  /// Display the Away Language
  @IBOutlet weak var awayLanguage: UILabel!
  /// TextField where user type the sentence he wants to translate
  @IBOutlet weak var inputTextField: UITextField!
  /// TextView that displays the translation
  @IBOutlet weak var translationContainer: UITextView!
  /// Container for the translation textView
  @IBOutlet weak var topView: UIView!
  
  // ////////////////////////// //
  // MARK: - CONSTRAINT OUTLETS //
  // ////////////////////////// //
  
  /// Outlets used to move the stackview up when keyboard pops up
  @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
  /// property used to reset stackView to initial position when keyboard pops out
  var originalConstraint: CGFloat = 0
  
  // /////////////////////// //
  // MARK: LifeCycle Methods //
  // /////////////////////// //
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Translation"
    inputFieldSetup()
    topTextViewSetup()
    loadLanguageSettings()
    
    //Observe when keyboard appears and trigger the animation up
    NotificationCenter.default.addObserver(self, selector: #selector( keyboardWillShow(notification: )), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
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
  // //////////////// //
  // MARK: - METHODS //
  // //////////////// //
  
  ///  Load languages settings from user default
  private func loadLanguageSettings() {
    guard case homeLanguage.text = UserSettings.defaults.object(forKey: Constants.LanguageStorage.home) as? String,
      case awayLanguage.text = UserSettings.defaults.object(forKey: Constants.LanguageStorage.away) as? String
      else { return}
  }
  
  /// Fetch translation of UITextfield text
  ///
  /// - Parameter url:  String. Character chain/sentence/word input in the textfield
  private func fetchTranslationforUrl(_ url: String) {
    translationService.fetchTranslation(translationUrl: url, completion: {(result, error) in
      // display an alert connexions fails
      if error != nil {
        UserAlert.show(title: Constants.AlertMessages.warning, message: Constants.AlertMessages.connexionProblem, controller: self)
        
        return
      }
      self.translationContainer.text  = result!.text
    })
  }
  
  /// This method handles the translation part.
  /// ** Important: 2 case are possible:
  /// - Autodetect is off : uses UserSettings languages
  /// - Autodetect is on : uses User Settings Away Language and retrieve home language from GOOGLE API
  ///
  /// - Parameter text: String. TextField input
  func translate(_ text: String) {
    var url = ""
    
    // Autodetection enabled
    if autodetect {
      translationService.detectLanguage(from: text, completion: {(language, error) in
        // display an alert connexions fails
        if error != nil {
          UserAlert.show(title: Constants.AlertMessages.warning, message: Constants.AlertMessages.connexionProblem, controller: self)
          return
        }
        // Create url from textField Input nalayze by GoogleApi who sent back a language
        url = self.translationService.createRequestUrl(text: text, from: String(language), to: self.awayLanguage.text!)
        //Send it the REST API CALL and return data
        self.fetchTranslationforUrl(url)
        self.homeLanguage.text! = String(language)
      })

    }
    // Autodetection not enabled
    else {
      // Create url from textField and userSettings languages
      url = translationService.createRequestUrl(text: text, from: homeLanguage.text!, to: awayLanguage.text!)
      //Send it the REST API CALL and return data
      fetchTranslationforUrl(url)
    }
  }
  
  // //////////////////////// //
  // MARK: - UI Setup Methods //
  // //////////////////////// //
  
  /// Setup of UIText field including autotranslation of the placeholder text according to user Settings
  func inputFieldSetup() {
    inputTextField.delegate = self
    inputTextField.font = UIFont(name: Constants.FontFamily.montserrat, size: 17.0)
    inputTextField.textAlignment = .left
    let inputSentence = Constants.TranslationPrompts.type
    let url = translationService.createRequestUrl(text: inputSentence, from: "en", to: homeLanguage.text!)
    translationService.fetchTranslation(translationUrl: url, completion: {(result, error) in
      // display an alert connexions fails
      if error != nil {
        UserAlert.show(title: Constants.AlertMessages.warning, message: Constants.AlertMessages.connexionProblem, controller: self)
        return
      }
      self.inputTextField.attributedPlaceholder = NSAttributedString(string: result!.text,
                                                                     attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
    })
  }

  /// Setup of Top UITextViewincluding autotranslation of the placeholder text according to user Settings
  func topTextViewSetup() {
    let translationSentence = Constants.TranslationPrompts.result
    let url = translationService.createRequestUrl(text: translationSentence, from: "en", to: homeLanguage.text!)
    translationService.fetchTranslation(translationUrl: url, completion: {(result, error) in
      // display an alert connexions fails
      if error != nil {
        UserAlert.show(title: Constants.AlertMessages.warning, message: Constants.AlertMessages.connexionProblem, controller: self)
        
        return
      }
      self.translationContainer.text = result!.text
    })
  }
}
