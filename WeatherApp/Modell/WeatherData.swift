//
//  Weather.swift
//  WeatherApp
//
//  Created by Sofi on 01.03.2021.
//

import Foundation
struct WeatherData: Decodable {
    let main: Main
    let wind: Wind
}
struct Main: Decodable {
    
    let temp: Float?
    let temp_min: Float?
    let temp_max: Float?
    }

struct Wind: Decodable {
    let speed : Float?
}



