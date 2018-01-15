//
//  UserSettingsViewController.swift
//  leBaluchon
//
//  Created by Mathieu Janneau on 07/01/2018.
//  Copyright © 2018 Mathieu Janneau. All rights reserved.
//

import UIKit

/**
 This Vc handles all the communication to display value for user settings.
 It guides the user througth new Vcs : language, location and currency settings.
 For sanity, this controller does set any value. All the value are saved in the dedicated vcs throuth dedicated models
 */
class UserSettingsViewController: UIViewController {
  
  // MARK: - properties
  
  // MARK: -  Delegate Vcs
  ///Language settings View Controller
  let languageListVc = LanguageSettings(style: .plain, homeDisplayKey: "homeLanguage", awayDisplayKey: "awayLanguage", homeIndexKey: "homeLanguageIndex", awayIndexKey: "awayLanguageIndex")
  ///Currrency settings View Controller
  let currencyListVc = CurrencySettings(style: .plain, homeDisplayKey: "homeCurrency", awayDisplayKey: "awayCurrency", homeIndexKey: "homeCurrencyIndex", awayIndexKey: "awayCurrencyIndex")
  ///Location settings View Controller
  let locationListVc = LocationSettingsController(nibName: nil, bundle: nil)
  
  // MARK: - ColorScheme
  // ColorScheme to send to detail view. Color arre different for away & home scheme
  var backgroundColor : UIColor?
  var selectedTextColor  : UIColor?
  
  // MARK: - data exchange valeus to Vcs
  // Optionnal value to receive result from detail Vc's and to be stored in persistence
  var awayLanguage : String?
  var homeLanguage : String?
  var selectedHome : Int?
  var selectedAway : Int?
  
  // MARK: - Label's Outlets
  @IBOutlet weak var Acity: UILabel!
  @IBOutlet weak var ALang: UILabel!
  @IBOutlet weak var ACurrency: UILabel!
  @IBOutlet weak var Bcity: UILabel!
  @IBOutlet weak var BLang: UILabel!
  @IBOutlet weak var BCurrency: UILabel!
  
  // MARK: - LifeCycle methods
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Settings"
    updateUI()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    updateUI()
    receiveValueForLanguage()
  }

  // MARK: - Actions

  // Language Actions
  @IBAction func gotToHomeLanguageSettings(_ sender: UIButton) {
   languageListVc.initDetail(bgColor: #colorLiteral(red: 0.2588235294, green: 0.8039215686, blue: 0.768627451, alpha: 1), txtSelect: #colorLiteral(red: 1, green: 0.4196078431, blue: 0.4078431373, alpha: 1), destination: "home")
    navigationController?.pushViewController(languageListVc, animated: true)
  }
  
  @IBAction func goToAwayLanguageSettings(_ sender: UIButton) {
    languageListVc.initDetail(bgColor: #colorLiteral(red: 1, green: 0.4196078431, blue: 0.4078431373, alpha: 1), txtSelect: #colorLiteral(red: 0.2588235294, green: 0.8039215686, blue: 0.768627451, alpha: 1), destination: "away")
    navigationController?.pushViewController(languageListVc, animated: true)
  }
  
  // Currency actions
  @IBAction func goToCurrencySettings(_ sender: UIButton) {
    currencyListVc.initDetail(bgColor: #colorLiteral(red: 1, green: 0.4196078431, blue: 0.4078431373, alpha: 1), txtSelect: #colorLiteral(red: 0.2588235294, green: 0.8039215686, blue: 0.768627451, alpha: 1), destination: "away")
    navigationController?.pushViewController(currencyListVc, animated: true)
  }
  
  @IBAction func goToHomeCurrencySettings(_ sender: UIButton) {
    currencyListVc.initDetail(bgColor: #colorLiteral(red: 0.2588235294, green: 0.8039215686, blue: 0.768627451, alpha: 1), txtSelect: #colorLiteral(red: 1, green: 0.4196078431, blue: 0.4078431373, alpha: 1), destination: "home")
    navigationController?.pushViewController(currencyListVc, animated: true)
  }
  
  // LocationActions
  @IBAction func goToAwayLocation(_ sender: UIButton) {
    locationListVc.initDetail(bgColor: #colorLiteral(red: 0.2588235294, green: 0.8039215686, blue: 0.768627451, alpha: 1), txtSelect: #colorLiteral(red: 1, green: 0.4196078431, blue: 0.4078431373, alpha: 1), destination: "away")
    navigationController?.present(locationListVc, animated: true, completion: nil)
  }
  
  @IBAction func gotToHomeLocation(_ sender: UIButton) {
    locationListVc.initDetail(bgColor: #colorLiteral(red: 0.2588235294, green: 0.8039215686, blue: 0.768627451, alpha: 1), txtSelect: #colorLiteral(red: 1, green: 0.4196078431, blue: 0.4078431373, alpha: 1), destination: "home")
    navigationController?.present(locationListVc, animated: true, completion: nil)
  }
  
  // MARK: - UI methods
  private func updateUI() {
    updateLabel(ALang, for: "awayLanguage")
    updateLabel(BLang, for: "homeLanguage")
    updateLabel(ACurrency, for: "awayCurrency")
    updateLabel(BCurrency, for: "homeCurrency")
    updateLabel(Acity, for: "awayCity")
    updateLabel(Bcity, for: "homeCity")
  }
  
  /**
   This method load data from persistent container asyncroneously to populate label
   - parameters:
   - label: UILabel destination label to populate
   - key: String to call in UserDefaults to retrieve the current value to display
 */
  func updateLabel(_ label: UILabel, for key: String){
    // call persistent container and optional binding to prevent nil value
    if let text = UserSettings.defaults.object(forKey: key) as! String!
    {
      // async load to prevent from nil value while fetching from persistent container
      DispatchQueue.main.async {
        label.text = text
      }
    }
  }
  
  private func receiveValueForLanguage() {
    // Receive value from language contaienr
    selectedHome = languageListVc.selectedHome
    selectedAway = languageListVc.selectedAway
  }
}
