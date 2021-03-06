//
//  CustomTabBar.swift
//  leBaluchon
//
//  Created by Mathieu Janneau on 06/01/2018.
//  Copyright © 2018 Mathieu Janneau. All rights reserved.
//

import UIKit

/**
 This class handles the main tab bar inititailization and behaviours
 */
class CustomTabBarController: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTabBar()
    setupSwipe()
  }
  
  /**
   Create programatically tab bar.
   */
  private func setupTabBar() {
    /// controller for currency converter
    let currencyVc = CurrencyViewController()
    /// controller for translation
    let translationVc = TranslationViewController()
    /// controller for weather info display
    let weatherVc = WeatherViewController()
    /// controller for user Settings
    let settingsVc = UserSettingsViewController()
    
    // Assign controllers to tab bar
    viewControllers = [
      createTabBarItem(Constants.ControlleTitles.weather, for: weatherVc),
      createTabBarItem(Constants.ControlleTitles.currency,
                       for: currencyVc),
      createTabBarItem(Constants.ControlleTitles.translation, for: translationVc),
      createTabBarItem(Constants.ControlleTitles.settings, for: settingsVc)
    ]
  }
  
  /**
   This method initialize tabBar item and insert them in a navigationController
   */
  func createTabBarItem(_ title: String, for controller: UIViewController) -> UINavigationController {
    /// Navigontion controller embedded in tabBar
    let navController = UINavigationController(rootViewController: controller)
    // Set title
    navController.tabBarItem.title = title
    //Set icon
    let imageName = Constants.ControlleTitles.getIcon(for: title)
    navController.tabBarItem.image = UIImage(named: imageName)
    return navController
  }
  
  /**
   Initialize left and rigth swipe gesture in order to swipe between tab bars items
   */
  private func setupSwipe() {
    
    /// Right swipe gesture instantiation
    let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
    swipeRight.direction = UISwipeGestureRecognizerDirection.right
    self.view.addGestureRecognizer(swipeRight)
    
    /// Left swipe gesture instantiation
    let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
    swipeLeft.direction = UISwipeGestureRecognizerDirection.left
    self.view.addGestureRecognizer(swipeLeft)}
  
  /**
   Callback function for swipe gesture
   */
  @objc func swiped(_ sender: UISwipeGestureRecognizer) {
    if sender.direction == UISwipeGestureRecognizerDirection.left {
      self.selectedIndex += 1
    } else if sender.direction == UISwipeGestureRecognizerDirection.right {
      self.selectedIndex -= 1
    }
  }
}
