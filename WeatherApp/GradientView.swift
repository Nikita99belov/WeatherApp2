//
//  GradientView.swift
//  WeatherApp
//
//  Created by Sofi on 02.03.2021.
//

import UIKit

@IBDesignable
class GradientView: UIView {
    
    @IBInspectable
    var startColor: UIColor = .white {
        didSet {
            self.updateColors()
        }
    }
    @IBInspectable
    var endColor: UIColor = .black {
        didSet {
            self.updateColors()
        }
    }
    
    @IBInspectable
    var startLocation: CGFloat = 0 {
        didSet {
            self.updateLocations()
        }
    }
    
    @IBInspectable
    var endLocation: CGFloat = 1 {
        didSet {
            self.updateLocations()
        }
        
    }
    
    @IBInspectable
    var startPoint: CGPoint = .zero {
        didSet {
            self.updateStartPoint()
        }
    }
    
    @IBInspectable
    var endPoint: CGPoint = CGPoint(x: 0, y: 1) {
        didSet {
            self.updateEndPoint()
        }
    }
    
    override static var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    var gradientLayer: CAGradientLayer {
        return self.layer as! CAGradientLayer
    }
    
    func updateLocations() {
        gradientLayer.locations = [
            startLocation as NSNumber,
            endLocation as NSNumber
        ]
    }
    
    func updateColors() {
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
    
    func updateStartPoint() {
        gradientLayer.startPoint = startPoint
    }
    
    func updateEndPoint() {
        gradientLayer.endPoint = endPoint
    }
    
}
