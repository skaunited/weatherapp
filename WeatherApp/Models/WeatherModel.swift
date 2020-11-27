//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Skander Bahri on 27/11/2020.
//

import Foundation

struct WeatherModel : Encodable, Decodable {
    let coord: Coord?
    let weather: [Weather]?
    let base: String?
    let main: Main?
    let visibility: Int?
    let wind: Wind?
    let clouds: Clouds?
    let dt: Int?
    let sys: Sys?
    let timezone, id: Int?
    let name: String?
    let cod: Int?
}

struct Coord: Encodable, Decodable {
    let lon, lat: Double?
}
struct Weather: Encodable, Decodable  {
    let id: Int?
    let main :String?
    let weatherDescription: String?
    let icon: String?
}
struct Main: Encodable, Decodable {
    let temp : Double?
    let feels_like : Double?
    let temp_min : Double?
    let temp_max :Double?
    let pressure : Int?
    let humidity :Int?
}
struct Wind: Encodable, Decodable {
    let speed: Double?
    let deg: Int?
}
struct Clouds: Encodable, Decodable{
    let all: Int?
}
struct Sys: Encodable, Decodable {
    let type, id: Int?
    let country: String?
    let sunrise, sunset: Int?
}

extension WeatherModel{
    static var empty : WeatherModel{
        let main = Main(temp: 0.0, feels_like: 0.0, temp_min: 0.0, temp_max: 0.0, pressure: 0, humidity: 0)
        return WeatherModel(coord: nil, weather: nil, base: nil, main: main, visibility: nil, wind: nil, clouds: nil, dt: nil, sys: nil, timezone: nil, id: nil, name: nil, cod: nil)
    }
}
