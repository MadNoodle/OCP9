//
//  WeatherViewController.swift
//  leBaluchon
//
//  Created by Mathieu Janneau on 07/01/2018.
//  Copyright © 2018 Mathieu Janneau. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
  
  // MARK: Properties
  // Home city properties
  @IBOutlet weak var homeCity: UILabel!
  @IBOutlet weak var homeTemp: UILabel!
  @IBOutlet weak var homeIcon: UIImageView!
  
  // Away city properties
  @IBOutlet weak var awayCity: UILabel!
  @IBOutlet weak var awayIcon: UIImageView!
  @IBOutlet weak var awayTemp: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Weather"
    setupLabels()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    setupLabels()
  }
  
  func setupCity(_ city:String, cityLabel:UILabel, tempLabel:UILabel, cityIcon: UIImageView){
    let city = city
    cityLabel.text = city
    DispatchQueue.main.async {
      WeatherService.fetchWeather(for: city, completion: { (weather) in
        tempLabel.text = "\(weather.temperature!) °C"
        let condition = weather.iconCode
        let iconName = WeatherCodeConverter.FindConditions(for: condition!)
        cityIcon.image = UIImage(named: iconName!)
      }
      )
    }
  }
  
  private func setupLabels() {
    
    let homeCityCity = UserSettings.defaults.object(forKey: "homeCity") as? String
    setupCity(homeCityCity!, cityLabel: homeCity ,tempLabel:homeTemp, cityIcon: homeIcon )
    
    let awayCityCity = UserSettings.defaults.object(forKey: "awayCity") as? String
    setupCity(awayCityCity!, cityLabel: awayCity ,tempLabel: awayTemp, cityIcon: awayIcon )
    
  }
  
  
  
}
