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
  
  // ////////////////// //
  // MARK: - Properties //
  // ////////////////// //
  
  // Home city properties
  /// home city name label
  @IBOutlet weak var homeCity: UILabel!
  /// home city temperature label
  @IBOutlet weak var homeTemp: UILabel!
  /// home city weather icon
  @IBOutlet weak var homeIcon: UIImageView!
  
  // Away city properties
  /// away city name label
  @IBOutlet weak var awayCity: UILabel!
  /// away city temperature label
  @IBOutlet weak var awayIcon: UIImageView!
  /// away city weather icon
  @IBOutlet weak var awayTemp: UILabel!
  
  // /////////////////////// //
  // MARK: LifeCycle Methods //
  // /////////////////////// //
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupLabels()
    // set nav bar title
    self.title = Constants.ControlleTitles.weather
  }
  
  override func viewWillAppear(_ animated: Bool) {
    setupLabels()
  }
  // ////////////////////////////////////////// //
  // MARK: - Information grab & display methods //
  // ////////////////////////////////////////// //
    
  /// Grab home and away city from UserDefaults via UserSettings and call setpupCity method to display informations
  private func setupLabels() {
    // fetch home city from Core Data
    let homeCityCity = UserSettings.defaults.object(forKey: Constants.LocationStorage.home) as? String
    setupCity(homeCityCity!, cityLabel: homeCity, tempLabel: homeTemp, cityIcon: homeIcon )
    // fetch away city from Core Data
    let awayCityCity = UserSettings.defaults.object(forKey: Constants.LocationStorage.away) as? String
    setupCity(awayCityCity!, cityLabel: awayCity, tempLabel: awayTemp, cityIcon: awayIcon )
  }
  
  /// Display city name, temp and weather icon from data fetched by WeatherService
  /// ** Important: the data are fetched from Weather Service into a WeatherObject
  /// and its weather code property converter give a visual represation of the conditions
  ///
  /// - Parameters:
  ///   - city: String. City Name
  ///   - cityLabel: UILabel. Container for city Name
  ///   - tempLabel: UILabel. Container for city temperrature
  ///   - cityIcon: UIImageView. Container for city Icon
  func setupCity(_ city: String, cityLabel: UILabel, tempLabel: UILabel, cityIcon: UIImageView) {
    let city = city
    cityLabel.text = city
    // Call asynchroneously WeatherService to fetch data without sttopping UI from Loading
    DispatchQueue.main.async {
      WeatherService.fetchWeather(for: city, completion: { (weather, error) in
        // display an alert connexions fails
        if error != nil {
          UserAlert.show(title: Constants.AlertMessages.warning, message: Constants.AlertMessages.connexionProblem, controller: self)
          return
        }
        
        tempLabel.text = "\(weather.temperature!) °C"
        let condition = weather.iconCode
        // convert code from string representation of a number to an icon
        let iconName = WeatherCodeConverter.findConditions(for: condition!)
        cityIcon.image = UIImage(named: iconName!)
      }
      )
    }
  }
}
