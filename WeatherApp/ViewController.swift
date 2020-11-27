//
//  ViewController.swift
//  WeatherApp
//
//  Created by Skander Bahri on 26/11/2020.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var cityTextName : UITextField!
    @IBOutlet weak var temeratorLabel : UILabel!
    @IBOutlet weak var humidityLabel : UILabel!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFiledListener()
    }

    private func textFiledListener(){
        self.cityTextName.rx.controlEvent(.editingDidEndOnExit)
            .asObservable()
            .map{ self.cityTextName.text }
            .subscribe(onNext: { city in
                if let city = city {
                    if city.isEmpty{
                        self.desplyWeather(nil)
                    }else{
                        self.fetchWeather(by: city)
                    }
                }
            }).disposed(by: disposeBag)
        
//        self.cityTextName.rx.value
//            .subscribe(onNext: { city in
//                if let city =  city {
//                    if city.isEmpty{
//                        self.desplyWeather(nil)
//                    }else{
//                        self.fetchWeather(by: city)
//                    }
//                }
//            }).disposed(by: disposeBag)
    }
    
    private func desplyWeather(_ weather: WeatherModel?){
        if let weather = weather{
            if let main = weather.main{
                if let temperature = main.temp{
                    self.temeratorLabel.text = "\(temperature) °F"
                }
                if let humidity = main.humidity{
                    self.humidityLabel.text = "\(humidity) 💦"
                }
            }
        }else{
            self.temeratorLabel.text = "Sorry I have no idea 🙉 "
            self.humidityLabel.text = "Sorry I have no idea 🙉 "
        }
    }
    
    private func fetchWeather(by city : String?){
        guard
            let cityEncoded = city?.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
            let url = URL.urlForWeatherAPI(withCity: cityEncoded )
        else { return }
        
        let resource = Resource<WeatherModel>(url: url)
        
        
        
        let search = URLRequest.load(resource: resource)
            .observeOn(MainScheduler.instance)
            .retry(3)
            .catchError{ error in
                print(error.localizedDescription)
                return Observable.just(WeatherModel.empty)
            }
            .asDriver(onErrorJustReturn: WeatherModel.empty)
        
        
        
        
//        let search = URLRequest.load(resource: resource)
//            .observeOn(MainScheduler.instance)
//            .asDriver(onErrorJustReturn: WeatherModel.empty)
//            //.catchErrorJustReturn(WeatherModel.empty)
        
        search.map{ "\($0.main?.temp) °F" }
            .drive(self.temeratorLabel.rx.text)
            //.bind(to: self.temeratorLabel.rx.text)
            .disposed(by: disposeBag)
        
        search.map{"\($0.main?.humidity) H"}
            .drive(self.humidityLabel.rx.text)
            //.bind(to: self.humidityLabel.rx.text)
            .disposed(by: disposeBag)
        
//            .subscribe(onNext: { result in
//                self.desplyWeather(result)
//            }).disposed(by: disposeBag)
    }
}

