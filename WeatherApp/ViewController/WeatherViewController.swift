//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Sofi on 02.03.2021.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet var backView: UIView!
    @IBOutlet var backImage: UIImageView!
    
    @IBOutlet var termLabel: UILabel!
    @IBOutlet var minTempLabel: UILabel!
    @IBOutlet var windLabel: UILabel!
    @IBOutlet var maxTempLabel: UILabel!
    
    @IBOutlet var tempImage: UIImageView!
    @IBOutlet var maxTempImage: UIImageView!
    @IBOutlet var windImage: UIImageView!
    @IBOutlet var minTempImage: UIImageView!
    
    var citis: String = ""
    let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.backgroundImage.image =  UIImage(contentsOfFile: "cropped")
        self.backgroundImage.alpha = 0.9
        self.view.insertSubview(self.backgroundImage, at: 0)
        
        dataBack ()
        getWeather(city: citis)
        getImage(city: citis)
    }
    
    func dataBack () {
        backView.layer.cornerRadius = 20
        backView.layer.shadowColor = UIColor.black.cgColor
        backView.layer.shadowOpacity = 100
        backView.layer.shadowOffset = .zero
        backView.layer.shadowRadius = 20
        backView.layer.shadowOpacity = 1
        backView.layer.shadowOffset = .init(width: -1, height: 0)
        backView.backgroundColor = .clear
        
        backImage.layer.cornerRadius = 20
        backImage.contentMode = .scaleAspectFill
        backImage.layer.masksToBounds = true
        backImage.layer.borderWidth = 2
        backImage.layer.borderColor = UIColor.black.cgColor
    }
}

extension WeatherViewController {
    
    func getWeather(city: String) {
        
        let baseURL = "http://api.openweathermap.org/data/2.5/weather?q=\(city)&units=metric"
        let apiKey =
            "&appid=54fa6b429d4a85967820d5e82253dc97"
        
        guard let url = URL(string: baseURL + apiKey) else {return}
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else {return}
            
            do {
                let weather = try JSONDecoder().decode(WeatherData.self , from: data)
                print(weather)
                print(url)
                DispatchQueue.main.async {
                    guard let temp = weather.main.temp else {return}
                    guard let tempMax = weather.main.temp_max else {return}
                    guard let tempMin = weather.main.temp_min else {return}
                    guard let wind = weather.wind.speed else {return}
                    
                    self.termLabel.text = String(format: "%.0f", temp)
                    self.maxTempLabel.text = String(format: "%.0f", tempMax)
                    self.minTempLabel.text = String(format: "%.0f", tempMin)
                    self.windLabel.text = String(format: "%.0f", wind)
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }
    
    func getImage(city: String) {
        
        let baseURL =
            "https://pixabay.com/api/?"
        let apiKey =
            "key=20482327-ec3d3cfd7bd17262d17473f45"
        let parametrs =
            "&q=\(city)&lorientation=vertical&image_type=photo"
        
        guard let url = URL(string: baseURL + apiKey + parametrs) else {return}
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else {return}
            
            do {
                let image = try JSONDecoder().decode(ImageData.self , from: data)
                DispatchQueue.main.async {
                    guard let randomURL = image.hits.randomElement() else {return}
                    guard let stringURL = randomURL.largeImageURL else {return}
                    guard let imageURL = URL(string: stringURL) else {return}
                    guard let imageData = try? Data(contentsOf:imageURL) else {return}
                    
                    self.backgroundImage.image = UIImage(data: imageData )
                    self.backgroundImage.alpha = 0.9
                    self.view.insertSubview(self.backgroundImage, at: 0)
                    print(imageData)
                }
                
            } catch let error {
                print(error)
            }
        }.resume()
    }
}
