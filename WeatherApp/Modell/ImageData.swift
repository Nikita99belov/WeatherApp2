//
//  ImageData.swift
//  WeatherApp
//
//  Created by Sofi on 02.03.2021.
//

import Foundation

struct ImageData: Decodable {
    let hits: [Image]
}

struct Image: Decodable {
   let largeImageURL: String?
}
