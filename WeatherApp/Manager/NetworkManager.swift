//
//  NetworkManager.swift
//  
//
//  Created by Sofi on 05.03.2021.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func fetchWeather(city: String, with complition: @escaping (WeatherData) -> Void) {
        
        let baseURL = "http://api.openweathermap.org/data/2.5/weather?q=\(city)&units=metric"
        let apiKey =
            "&appid=54fa6b429d4a85967820d5e82253dc97"
        
        AF.request(baseURL + apiKey)
            .validate()
            .responseJSON { responseData in
                switch responseData.result {
                case .success(let weatherValue):
                    DispatchQueue.main.async {
                        guard let mains = WeatherData.getWeather(for: weatherValue) else {return}
                        complition(mains)
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func getImage(city: String ,with complition: @escaping (ImageData) -> Void) {
        
        let baseURL =
            "https://pixabay.com/api/?"
        let apiKey =
            "key=20482327-ec3d3cfd7bd17262d17473f45"
        let parametrs =
            "&q=\(city)&lorientation=vertical&per_page=200&image_type=photo"
        
        AF.request(baseURL + apiKey + parametrs)
            .validate()
            .responseDecodable(of:ImageData.self ){ responseData in
                switch responseData.result {
                case .success(let weatherValue):
                    DispatchQueue.main.async {
                        complition(weatherValue)
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
}
