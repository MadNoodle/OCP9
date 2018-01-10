//
//  CustomTabBar.swift
//  leBaluchon
//
//  Created by Mathieu Janneau on 06/01/2018.
//  Copyright © 2018 Mathieu Janneau. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
  override func viewDidLoad() {
    super.viewDidLoad()
    let currencyVc = CurrencyViewController()
    let translationVc = TranslationViewController()
    let weatherVc = WeatherViewController()
    let settingsVc = UserSettingsViewController()
    
    viewControllers = [
      createTabBarItem("Currency", imageName: "currency", for: currencyVc),
      createTabBarItem("Translation", imageName: "translation", for: translationVc),
      createTabBarItem("Weather", imageName: "weather", for: weatherVc),
      createTabBarItem("Settings", imageName: "settings", for: settingsVc)
    ]
  }
  
  func createTabBarItem(_ title: String, imageName: String, for controller : UIViewController) -> UINavigationController{
    let navController = UINavigationController(rootViewController: controller)
    navController.tabBarItem.title = title
    navController.tabBarItem.image = UIImage(named: imageName)
    return navController
  }
}
