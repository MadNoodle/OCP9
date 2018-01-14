//
//  CurrencyViewController.swift
//  leBaluchon
//
//  Created by Mathieu Janneau on 06/01/2018.
//  Copyright © 2018 Mathieu Janneau. All rights reserved.
//

import UIKit

class CurrencyViewController: UIViewController {
  // Inittialize Data Logic
  var currencyConverter = CurrencyConverter()
  // MARK: - properties
  var rateValue : Double = 0.0
  var homeCurrency = UserSettings.defaults.object(forKey: "homeCurrency") as? String
  var awayCurrency = UserSettings.defaults.object(forKey: "awayCurrency") as? String
  
  // MARK: - OUTLETS
  @IBOutlet weak var date: UILabel!
  @IBOutlet weak var rate: UILabel!
  @IBOutlet weak var awayAmount: UILabel!
  @IBOutlet weak var homeAmount: UILabel!
  @IBOutlet var numberButtons: [UIButton]!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Currency"
    setupDisplay()
    DispatchQueue.main.async {
      self.homeCurrency = UserSettings.defaults.object(forKey: "homeCurrency") as? String
      self.awayCurrency = UserSettings.defaults.object(forKey: "awayCurrency") as? String
      CurrencyService.fetchExchangeRate(apiUrl: CurrencyService.api, from: self.homeCurrency!, to: self.awayCurrency!, completion: {(result) in
        self.rateValue = result.rate!
        self.rate.text = " 1 \(self.homeCurrency!) = \(self.rateValue) \(self.awayCurrency!)"
      })
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    setupDisplay()
    DispatchQueue.main.async {
      self.homeCurrency = UserSettings.defaults.object(forKey: "homeCurrency") as? String
      self.awayCurrency = UserSettings.defaults.object(forKey: "awayCurrency") as? String
      CurrencyService.fetchExchangeRate(apiUrl: CurrencyService.api, from: self.homeCurrency!, to: self.awayCurrency!, completion: {(result) in
        self.rateValue = result.rate!
        self.rate.text = " 1 \(self.homeCurrency!) = \(self.rateValue) \(self.awayCurrency!)"
        self.homeAmount.text = "0 \(self.homeCurrency!)"
        self.awayAmount.text = "0 \(self.awayCurrency!)"
      })
    }
    
  }
  
  // MARK: - BUTTONS ACTIONS
  
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
      showAlert()
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
  
  // MARK: - Display methods
  func setupDisplay() {
    let currentDateToDisplay = currentDate()
    date.text = currentDateToDisplay
    homeAmount.text = "0 \(homeCurrency!)"
    awayAmount.text = "0 \(awayCurrency!)"
  }
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
  
  func showAlert() {
    let alertVC = UIAlertController(title: "Attention", message: "Expression incorrecte !", preferredStyle: .alert)
    alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
    self.present(alertVC, animated: true, completion: nil)
  }
  
  // MARK: - Formatting Date
  private func currentDate() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE, MMMM d, yyyy"
    let currentDate = Date()
    let convertedDateString = dateFormatter.string(from:currentDate as Date)
    return convertedDateString
  }
}
