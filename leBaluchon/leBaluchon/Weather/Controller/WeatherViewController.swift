//
//  WeatherViewController.swift
//  leBaluchon
//
//  Created by Mathieu Janneau on 07/01/2018.
//  Copyright © 2018 Mathieu Janneau. All rights reserved.
//

import UIKit
/**
 Controller that handles weather displaying from API
 */
class WeatherViewController: UIViewController {
  
  // MARK: - Properties
  
  // Home city properties
  @IBOutlet weak var homeCity: UILabel!
  @IBOutlet weak var homeTemp: UILabel!
  @IBOutlet weak var homeIcon: UIImageView!
  
  // Away city properties
  @IBOutlet weak var awayCity: UILabel!
  @IBOutlet weak var awayIcon: UIImageView!
  @IBOutlet weak var awayTemp: UILabel!
  
  
  // MARK: - LifeCycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    setupLabels()
    // set nav bar title
    self.title = "Weather"
  }
  
  override func viewWillAppear(_ animated: Bool) {
    setupLabels()
  }
  
  // MARK: - Information grab & display methods
  /**
   Grab home and away city from UserDefaults via UserSettings and call setpupCity method to display informations
   */
  private func setupLabels() {
    let homeCityCity = UserSettings.defaults.object(forKey: "homeCity") as? String
    setupCity(homeCityCity!, cityLabel: homeCity ,tempLabel:homeTemp, cityIcon: homeIcon )
    let awayCityCity = UserSettings.defaults.object(forKey: "awayCity") as? String
    setupCity(awayCityCity!, cityLabel: awayCity ,tempLabel: awayTemp, cityIcon: awayIcon )
  }
  
  
  /**
   Display city name, temp and weather icon from data fetched by WeatherService
   ** Important: the data are fetched from Weather Service into a WeatherObject
   and its weather code property converter give a visual represation of the conditions
   - parameters:
       - city: String. City Name
       - cityLabel: UILabel. Container for city Name
       - tempLabel: UILabel. Container for city temperrature
       - tempIcon: UIImageView. Container for city Icon
   */
  func setupCity(_ city:String, cityLabel:UILabel, tempLabel:UILabel, cityIcon: UIImageView){
    let city = city
    cityLabel.text = city
    // Call asynchroneously WeatherService to fetch data without sttopping UI from Loading
    DispatchQueue.main.async {
      WeatherService.fetchWeather(for: city, completion: { (weather,error) in
        // display an alert connexions fails
        if error != nil {
          self.showAlert()
          return
        }
        
        tempLabel.text = "\(weather.temperature!) °C"
        let condition = weather.iconCode
        // convert code from string representation of a number to an icon
        let iconName = WeatherCodeConverter.FindConditions(for: condition!)
        cityIcon.image = UIImage(named: iconName!)
      }
      )
    }
  }
  
  
  /**
   Show alert when user try to do an invalid operation such as 2
   decimal points in the same number
   */
  func showAlert() {
    let alertVC = UIAlertController(title: "Attention", message: "problème de connexion au servveur!", preferredStyle: .alert)
    alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
    self.present(alertVC, animated: true, completion: nil)
  }
  
}
