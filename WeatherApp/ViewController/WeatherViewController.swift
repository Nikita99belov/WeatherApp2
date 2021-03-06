//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Sofi on 02.03.2021.
//

import UIKit
import Alamofire

class WeatherViewController: UIViewController {
    @IBOutlet var loadingImageIndicator: UIActivityIndicatorView!
    
    @IBOutlet var backView: UIView!
    @IBOutlet var backImage: UIImageView!
    
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var termLabel: UILabel!
    @IBOutlet var minTempLabel: UILabel!
    @IBOutlet var windLabel: UILabel!
    @IBOutlet var maxTempLabel: UILabel!
    
    @IBOutlet var tempImage: UIImageView!
    @IBOutlet var maxTempImage: UIImageView!
    @IBOutlet var windImage: UIImageView!
    @IBOutlet var minTempImage: UIImageView!
    
    var citis: String = ""
    var weather: WeatherData?
    var image: ImageData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingImageIndicator.startAnimating()
        loadingImageIndicator.hidesWhenStopped = true
        
        dataBack ()

        NetworkManager.shared.fetchWeather(city: citis) { (weather) in
            guard let temp = weather.temp else {return}
            guard let tempMax = weather.tempMax else {return}
            guard let tempMin = weather.tempMin else {return}
            guard let wind = weather.speed else {return}
            
            self.termLabel.text = String(format: "%.0f",temp)
            self.maxTempLabel.text = String(format: "%.0f", tempMax)
            self.minTempLabel.text = String(format: "%.0f", tempMin)
            self.windLabel.text = String(format: "%.0f", wind)
            self.loadingImageIndicator.stopAnimating()
        }
        NetworkManager.shared.getImage(city: citis) { (image) in
            guard let randomURL = image.hits.randomElement() else {return}
            guard let stringURL = randomURL.largeImageURL else {return}
            guard let imageURL = URL(string: stringURL) else {return}
            guard let imageData = try? Data(contentsOf:imageURL) else {return}
            
            self.backgroundImageView.image = UIImage(data: imageData )
            self.backgroundImageView.alpha = 0.9
        }
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
