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
  
  var homeDisplayKey: String?
  
  var awayDisplayKey: String?
  
  var homeIndexKey: String?
  
  var awayIndexKey: String?

  // /////////////////// //
  // MARK: - properties  //
  // /////////////////// //
  
  ///Language settings View Controller
  let languageListVc = DetailSettings()
  ///Currrency settings View Controller
  let currencyListVc = DetailSettings()
  ///Location settings View Controller
  let locationListVc = LocationSettingsController(nibName: nil, bundle: nil)
  // /////////////////// //
  // MARK: - ColorScheme //
  // /////////////////// //

  // Color Scheme properties
  /// Value to customize Color Scheme background
  var backgroundColor: UIColor?
  /// Value to customize Color Scheme text
  var selectedTextColor: UIColor?
  
  // MARK: - data exchange valeus to Vcs
  // Optionnal value to receive result from detail Vc's and to be stored in persistence
  /// Away Language value (refer to Language)
  var awayLanguage: String?
  /// home LAnguage value (refer to Language)
  var homeLanguage: String?
   /// Optional Value that stores home city Index to highligth it in tableView when reloading
  var selectedHome: Int?
    /// Optional Value that stores Away city Index to highligth it in tableView when reloading
  var selectedAway: Int?

  // MARK: - Label's Outlets
  ///Away city name
  @IBOutlet weak var aCity: UILabel!
  /// Away country language
  @IBOutlet weak var aLang: UILabel!
  /// Away country currency
  @IBOutlet weak var aCurrency: UILabel!
  /// home city name
  @IBOutlet weak var bCity: UILabel!
  /// home country language
  @IBOutlet weak var bLang: UILabel!
  /// home country currency
  @IBOutlet weak var bCurrency: UILabel!

  // /////////////////////// //
  // MARK: LifeCycle Methods //
  // /////////////////////// //
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = Constants.ControlleTitles.settings
    updateUI()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    updateUI()
    receiveValueForLanguage()
  }
  
  // //////////////// //
  // MARK: - Actions  //
  // //////////////// //

  @IBAction func gotToHomeLanguageSettings(_ sender: UIButton) {
  
    languageListVc.initDetail( destination: .home, of: .language)
    navigationController?.pushViewController(languageListVc, animated: true)
  }
  
  @IBAction func goToAwayLanguageSettings(_ sender: UIButton) {
    languageListVc.initDetail(destination: .away, of: .language)
    navigationController?.pushViewController(languageListVc, animated: true)
  }
  
  // Currency actions
  @IBAction func goToCurrencySettings(_ sender: UIButton) {
      currencyListVc.initDetail( destination: .away, of: .currency)
  
    navigationController?.pushViewController(currencyListVc, animated: true)
  }
  
  @IBAction func goToHomeCurrencySettings(_ sender: UIButton) {
      currencyListVc.initDetail( destination: .home, of: .currency)
    navigationController?.pushViewController(currencyListVc, animated: true)
  }
  
  // LocationActions
  @IBAction func goToAwayLocation(_ sender: UIButton) {
    locationListVc.initDetail( destination: .away)
    navigationController?.present(locationListVc, animated: true, completion: nil)
  }
  
  @IBAction func gotToHomeLocation(_ sender: UIButton) {
    locationListVc.initDetail( destination: .home)
    navigationController?.present(locationListVc, animated: true, completion: nil)
  }

  // ////////////////// //
  // MARK: - UI methods //
  // ////////////////// //

  /// Load informations into labels and update UI
  private func updateUI() {
    updateLabel(aLang, for: Constants.LanguageStorage.away)
    updateLabel(bLang, for: Constants.LanguageStorage.home)
    updateLabel(aCurrency, for: Constants.CurrencyStorage.away)
    updateLabel(bCurrency, for: Constants.CurrencyStorage.home)
    updateLabel(aCity, for: Constants.LocationStorage.away)
    updateLabel(bCity, for: Constants.LocationStorage.home)
  }

  ///  This method load data from persistent container asyncroneously to populate label
  ///
  /// - Parameters:
  ///   - label: UILabel destination label to populate
  ///   - key: String to call in UserDefaults to retrieve the current value to display
  func updateLabel(_ label: UILabel, for key: String) {
    // call persistent container and optional binding to prevent nil value
    if let text = UserSettings.defaults.object(forKey: key) as? String? {
      // async load to prevent from nil value while fetching from persistent container
      DispatchQueue.main.async {
        label.text = text
      }
    }
  }

  /// Load values from external Vc's in selectedValues
  private func receiveValueForLanguage() {
    // Receive value from language container
    selectedHome = languageListVc.selectedHome
    selectedAway = languageListVc.selectedAway
  }
}
