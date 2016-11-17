//
//  TodaysWeatherViewController.swift
//  RxOpenWeather
//
//  Created by Nikolas Burk on 17/11/16.
//  Copyright © 2016 Nikolas Burk. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TodaysWeatherViewController: UIViewController {
  
  @IBOutlet weak var cityTextField: UITextField!
  @IBOutlet weak var forecastButton: UIButton!
  
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var minTemperatureLabel: UILabel!
  @IBOutlet weak var maxTemperatureLabel: UILabel!
  @IBOutlet weak var avgTemperatureLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  
}

