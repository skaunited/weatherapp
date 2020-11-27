//
//  URL+Extension.swift
//  WeatherApp
//
//  Created by Skander Bahri on 27/11/2020.
//

import Foundation
extension URL {
    static func urlForWeatherAPI(withCity city: String) -> URL?{
        return URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=[YOUR_APPID]")
    }
}
