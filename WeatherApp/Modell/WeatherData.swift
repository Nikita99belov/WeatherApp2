//
//  Weather.swift
//  WeatherApp
//
//  Created by Sofi on 01.03.2021.
//

import Foundation
struct WeatherData {
    let main: [String: Any]?
    let wind: [String: Any]?
    let temp: Double?
    let tempMax: Double?
    let tempMin: Double?
    let speed: Double?
  
    init(weatherData: [String: Any]) {
        main = weatherData ["main"] as? [String: Any]
        wind = weatherData ["wind"] as? [String: Any]
        temp = main?["temp"] as? Double
        tempMax = main?["temp_max"] as? Double
        tempMin = main?["temp_min"] as? Double
        speed = wind?["speed"] as? Double
    }
    static func getWeather (for value: Any) -> WeatherData? {
        guard let weathersDat = value as? [String: Any] else {return nil}
        let weather = WeatherData(weatherData: weathersDat)
        return weather
    }
}


