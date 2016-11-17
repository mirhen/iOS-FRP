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
    
    let disposeBag = DisposeBag()
    let openWeatherMapAPI = RxOpenWeatherMapAPI()
        override func viewDidLoad() {
        super.viewDidLoad()
        setUpObservables()
    }
    
    func setUpObservables() {
        let weatherObservable: Observable<Weather?> = cityTextField.rx.text.asObservable()
            .throttle(0.75, scheduler: MainScheduler.instance)
            .flatMapLatest{ (query: String?) -> Observable<Weather?> in
                return self.openWeatherMapAPI.createWeatherObservable(for: query!)
        }
        weatherObservable.subscribe { weather in
            print(weather)
            
        }.addDisposableTo(disposeBag)
        
        weatherObservable.map { (weather: Weather?) in
            return weather != nil
        }.bindTo(forecastButton.rx.isEnabled).addDisposableTo(disposeBag)
        
        weatherObservable.map { (weather: Weather?) in
            if let weather = weather {
               return weather.description
            }
                return "-"
            }.bindTo(descriptionLabel.rx.text).addDisposableTo(disposeBag)
        
        weatherObservable.map { (weather: Weather?) in
            if let weather = weather {
                return String(weather.temperature.avg)
            }
                return "-"
            }.bindTo(avgTemperatureLabel.rx.text).addDisposableTo(disposeBag)
        
        weatherObservable.map { (weather: Weather?) in
            if let weather = weather {
                return String(weather.temperature.min)
            }
            return "-"
            }.bindTo(minTemperatureLabel.rx.text).addDisposableTo(disposeBag)

        weatherObservable.map { (weather: Weather?) in
            if let weather = weather {
                return String(weather.temperature.max)
            }
            return "-"
            }.bindTo(maxTemperatureLabel.rx.text).addDisposableTo(disposeBag)
 
        }
    }

