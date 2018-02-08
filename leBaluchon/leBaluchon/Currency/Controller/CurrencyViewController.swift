//
//  CurrencyViewController.swift
//  leBaluchon
//
//  Created by Mathieu Janneau on 06/01/2018.
//  Copyright © 2018 Mathieu Janneau. All rights reserved.
//

import UIKit

class CurrencyViewController: UIViewController {
  
  // ////////////////// //
  // MARK: - properties //
  // ////////////////// //
  
  /// Inittialize Data Logic
  var currencyConverter = CurrencyConverter()
  /// Exchange rate
  var rateValue : Double = 0.0
  /// Load home currency from Core data
  var homeCurrency = UserSettings.defaults.object(forKey: "homeCurrency") as? String
  /// Load away Currency from Core Data
  var awayCurrency = UserSettings.defaults.object(forKey: "awayCurrency") as? String
  
  // /////////////// //
  // MARK: - OUTLETS //
  // /////////////// //
  
  ///  today's date display
  @IBOutlet weak var date: UILabel!
  /// exchange rate display
  @IBOutlet weak var rate: UILabel!
  /// Away currency rate display
  @IBOutlet weak var awayAmount: UILabel!
  /// Home currency rate display
  @IBOutlet weak var homeAmount: UILabel!
  /// Number Pad buttons
  @IBOutlet var numberButtons: [UIButton]!
  
  // /////////////////////// //
  // MARK: LifeCycle Methods //
  // /////////////////////// //
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Currency"
    currencyConverterSetup()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    currencyConverterSetup()
    self.homeAmount.text = "0 \(self.homeCurrency!)"
    self.awayAmount.text = "0 \(self.awayCurrency!)"
  }
  
  // /////////////////////// //
  // MARK: - BUTTONS ACTIONS //
  // /////////////////////// //
  
  @IBAction func tappedNumberButton(_ sender: UIButton) {
    for (i, numberButton) in numberButtons.enumerated() where sender == numberButton {
      let value = numberButton.titleLabel?.text!
      currencyConverter.addNewNumber(i, value!)
      print(currencyConverter.stringNumbers)
      updateDisplay()
    }
  }
  
  @IBAction func decimalIsTapped(_ sender: UIButton) {
    if currencyConverter.canAddDecimal {
      currencyConverter.addDecimal()
      updateDisplay()
    } else {
      showAlert(message: "Expression incorrecte !")
    }
  }
  
  @IBAction func convertIsTapped(_ sender: UIButton) {
    
    let convertValue = String(currencyConverter.convert(rate: rateValue))
    awayAmount.text = "\(convertValue) \(awayCurrency!)"
  }
  
  @IBAction func allClearIsTapped(_ sender: UIButton) {
    currencyConverter.allClear()
    homeAmount.text = "0 \(homeCurrency!)"
    awayAmount.text = "0 \(awayCurrency!)"
  }
  
  // /////////////////////// //
  // MARK: - Display methods //
  // /////////////////////// //
  
  /**
   This method create the initial state of the converter.
     - present date
     - home currency to zero
     - away currency to zero
 */
  func setupDisplay() {
    let currentDateToDisplay = currentDate()
    date.text = currentDateToDisplay
    homeAmount.text = "0 \(homeCurrency!)"
    awayAmount.text = "0 \(awayCurrency!)"
  }
  
 
  /// update home currency display when nulbers and decimal are tapped
  func updateDisplay() {
    var text = ""
    let stack = currencyConverter.stringNumbers.enumerated()
    for (i, stringNumber) in stack {
      // Add operator
      if i > 0 {
        //text += currencyConverter.operators[i]
      }
      // Add number
      text += stringNumber
    }
    homeAmount.text = "\(text) \(homeCurrency!)"
  }
  
  // ///////////////////////// //
  // MARK: - Converter Methods //
  // ///////////////////////// //
  

  /// This method handles the fetching of currenct name from UserDefault
  /// and REST API call to grab the exchang rate.
  /// This informations feed the converter
  private func currencyConverterSetup() {
    setupDisplay()
    // grab data asynchroneously to not overload UILoading
    DispatchQueue.main.async {
      // Grab currency informations from UserDefault
      self.homeCurrency = UserSettings.defaults.object(forKey: "homeCurrency") as? String
      self.awayCurrency = UserSettings.defaults.object(forKey: "awayCurrency") as? String
      // REST API request
      CurrencyService.fetchExchangeRate(apiUrl: CurrencyService.api, from: self.homeCurrency!, to: self.awayCurrency!, completion: {(result, error) in
        // display an alert connexions fails
        if error != nil {
          self.showAlert(message: "Problème de connexion au serveur")
          return
        }
        self.rateValue = result.rate!
        self.rate.text = " 1 \(self.homeCurrency!) = \(self.rateValue) \(self.awayCurrency!)"
      })
    }
  }
  

  /// Grab current date and format it
  ///
  /// - Returns: String Date
  private func currentDate() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE, MMMM d, yyyy"
    let currentDate = Date()
    let convertedDateString = dateFormatter.string(from:currentDate as Date)
    return convertedDateString
  }
  
  ///  Show alert when user try to do an invalid operation such as 2
  /// decimal points in the same number or connexion problem
  ///
  /// - Parameter message: String. Message to explain the error
  func showAlert(message:String) {
    let alertVC = UIAlertController(title: "Attention", message: message, preferredStyle: .alert)
    alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
    self.present(alertVC, animated: true, completion: nil)
  }
}
