//
//  CurrentWeather+codes.swift
//  leBaluchon
//
//  Created by Mathieu Janneau on 06/01/2018.
//  Copyright © 2018 Mathieu Janneau. All rights reserved.
//

import Foundation
import UIKit

class WeatherCodeConverter {
  
  static let clearDay = ["32","34","36"]
  static let clearNight =  ["31","33"]
  static let cloudy = ["26","44"]
  static let fog =  ["19","20","21","22","23"]
  static let hail = ["17"]
  static let partlyCloudyDay = ["28","30"]
  static let partlyCloudyNight = ["27","29"]
  static let rain = ["8","9","10","11","12","35","40"]
  static let sleet = ["6","18"]
  static let snow = ["5","7","13","14","15","16","41","42","43","46","47"]
  static let thunderstorm = ["3","4","37","38","39","45"]
  static let tornado =  ["0","1", "2"]
  static let wind =  ["24"]
  static let error = ["3200"]
  
  static let weathers: [(String,[String])] = [("clear-day",clearDay), ("clear-night", clearNight), ("cloudy", cloudy), ("fog", fog), ("hail",hail),("partly-cloudy-day", partlyCloudyDay), ("partly-cloudy-night",partlyCloudyNight), ("rain", rain), ("sleet", sleet),("snow",  snow), ("thunderstorm", thunderstorm),("tornado", tornado),("wind" ,wind),("error",error)]
  
  static func FindConditions(for code: String) -> String?{
    var conditions : String?
    for weather in weathers {
      if weather.1.contains(code){
        conditions = weather.0
      }
    }
    return conditions!
  }

}

