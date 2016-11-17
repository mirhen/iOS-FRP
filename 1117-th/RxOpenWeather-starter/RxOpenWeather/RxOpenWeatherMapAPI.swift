//
//  RxOpenWeatherMapAPI.swift
//  RxOpenWeather
//
//  Created by Nikolas Burk on 17/11/16.
//  Copyright © 2016 Nikolas Burk. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class RxOpenWeatherMapAPI {
  
  // MARK: Public API
  
  func createWeatherObservable(for city: String, temperatureUnit: RxOpenWeatherMapAPI.TemperatureUnit = .fahrenheit) -> Observable<Weather?> {
    return Observable<Weather?>.just(nil) // just make the compiler happy by creating a default Observable that's always nil
  }

  
  // MARK: Build URLS
  
  fileprivate func buildURLForCurrentWeather(for city: String, temperatureUnit: RxOpenWeatherMapAPI.TemperatureUnit) -> URL? {
    let path = RxOpenWeatherMapAPI.Endpoint.weather.rawValue
    let queryString = buildGeneralURLArguments(for: city, temperatureUnit: temperatureUnit)
    let urlString = baseURL + "/" + path + "?" + queryString
    return URL(string: urlString)
  }
  
  fileprivate func buildGeneralURLArguments(for city: String, temperatureUnit: RxOpenWeatherMapAPI.TemperatureUnit) -> String {
    let urlEscapedCity = city.urlEscapedString
    let q = RxOpenWeatherMapAPI.GeneralParameters.q.rawValue + "=" + urlEscapedCity
    let appId = RxOpenWeatherMapAPI.GeneralParameters.appId.rawValue + "=" + apiKey
    var urlArguments = [q, appId]
    if temperatureUnit != .kelvin {
      let units = RxOpenWeatherMapAPI.GeneralParameters.units.rawValue + "=" + temperatureUnit.rawValue
      urlArguments.append(units)
    }
    return concatURLArguments(arguments: urlArguments) // q + "&" + units + "&" + appId
  }
  
  fileprivate func buildForecastURLArguments(for forecastPeriod: RxOpenWeatherMapAPI.ForecastPeriod) -> String {
    return RxOpenWeatherMapAPI.ForecastParameters.cnt.rawValue + "=" + forecastPeriod.rawValue
  }
  
  fileprivate func concatURLArguments(arguments: [String]) -> String {
    return arguments.joined(separator: "&")
  }
  
  
  // MARK: Parsing
  
  fileprivate func jsonToMaybeWeather(weatherInfo: [String: Any]) -> Weather? {
    
    guard let descriptionDataArray = weatherInfo["weather"] as? NSArray else {
      print("could not get description data array")
      return nil
    }
    
    guard let descriptionData = descriptionDataArray[0] as? [String: Any] else {
      print("could not get description data")
      return nil
    }
    
    guard let description = descriptionData["description"] as? String else {
      print("could not get description")
      return nil
    }
    
    guard let dateSeconds = weatherInfo["dt"] as? Double else {
      print("could not get date")
      return nil
    }
    
    guard let temperatureInfo = weatherInfo["main"] as? [String: Any] else {
      print("could not get temperature info")
      return nil
    }
    
    guard let min = temperatureInfo["temp_min"] as? Float else {
      print("could not get min temperature")
      return nil
    }
    
    guard let max = temperatureInfo["temp_max"] as? Float else {
      print("could not get max temperature")
      return nil
    }
    
    guard let avg = temperatureInfo["temp"] as? Float else {
      print("could not get avg temperature")
      return nil
    }
    
    let temperature = Temperature(avg: avg, min: min, max: max, unit: .fahrenheit)
    let date = Date(timeIntervalSince1970: dateSeconds)
    
    return Weather(date: date, description: description, temperature: temperature)
  }
  
  
  // MARK: Types & Constants
  
  let apiKey = ""

  fileprivate let baseURL = "http://api.openweathermap.org/data/2.5"
  
  fileprivate enum Endpoint: String {
    case weather = "weather"
    case forecast = "forecast/daily"
  }
  
  fileprivate enum GeneralParameters: String {
    case appId
    case q
    case units
  }
  
  fileprivate enum ForecastParameters: String {
    case cnt
  }
  
  enum TemperatureUnit: String {
    case fahrenheit = "imperial"
    case celsius = "metric"
    case kelvin
  }
  
  public static let maxForecastDays = 16
  enum ForecastPeriod: String {
    case oneDay = "1"
    case twoDays = "2"
    case threeDays = "3"
    case fourDays = "4"
    case fiveDays = "5"
    case sixDays = "6"
    case sevenDays = "7"
    case eightDays = "8"
    case nineDays = "9"
    case tenDays = "10"
    case elevenDays = "11"
    case twelveDays = "12"
    case thirteenDays = "13"
    case fourteenDays = "14"
    case fifteenDays = "15"
    case sixteenDays = "16"
  }
  
}

private extension String {
  var urlEscapedString: String {
    return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
  }
}
