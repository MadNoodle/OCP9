//
//  UserSettingsViewController.swift
//  leBaluchon
//
//  Created by Mathieu Janneau on 07/01/2018.
//  Copyright © 2018 Mathieu Janneau. All rights reserved.
//

import UIKit

class UserSettingsViewController: UIViewController {
  
  // MARK: - properties
  // Detail settings View Controllers that user can access from general Settings
  let languageListVc = LanguageSettings(style: .plain, homeDisplayKey: "homeLanguage", awayDisplayKey: "awayLanguage", homeIndexKey: "homeLanguageIndex", awayIndexKey: "awayLanguageIndex")
  let currencyListVc = CurrencySettings(style: .plain, homeDisplayKey: "homeCurrency", awayDisplayKey: "awayCurrency", homeIndexKey: "homeCurrencyIndex", awayIndexKey: "awayCurrencyIndex")
  
  // ColorScheme to send to detail view. Color arre different for away & home scheme
  var backgroundColor : UIColor?
  var selectedTextColor  : UIColor?
  
  // Optionnal value to receive result from detail Vc's and to be stored in persistence
  var awayLanguage : String?
  var homeLanguage : String?
  var selectedHome : Int?
  var selectedAway : Int?
  

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
  }
  
  override func viewWillAppear(_ animated: Bool) {
    awayLanguage = languageListVc.away
    homeLanguage = languageListVc.home
    selectedHome = languageListVc.selectedHome
    selectedAway = languageListVc.selectedAway
    ALang.text = awayLanguage
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
}
