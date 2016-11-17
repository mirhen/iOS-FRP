//
//  Temperature.swift
//  OpenWeather
//
//  Created by Nikolas Burk on 21/09/16.
//  Copyright © 2016 Nikolas Burk. All rights reserved.
//

import Foundation

struct Temperature {
  let avg: Float
  let min: Float
  let max: Float
  var unit: RxOpenWeatherMapAPI.TemperatureUnit = .fahrenheit
}
