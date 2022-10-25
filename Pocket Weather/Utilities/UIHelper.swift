//
//  UIHelper.swift
//  Pocket Weather
//
//  Created by Adam Paluszewski on 17/10/2022.
//

import UIKit
import AVKit
import WeatherKit


struct UIHelper {
    
    static func createAxialGradient(in view: UIView, startPoint: CGPoint, endPoint: CGPoint, colors: [CGColor]) {
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        gradient.colors = colors
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        view.layer.insertSublayer(gradient, at: 0)
    }
    
    
    static func addGradientAnimation(in view: UIView) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = view.frame
        gradientLayer.zPosition = -1
        view.layer.addSublayer(gradientLayer)

        let animation = CABasicAnimation(keyPath: "colors")
        animation.fromValue = [UIColor(red: 68/255, green: 149/255, blue: 230/255, alpha: 1).cgColor, UIColor(red: 171/255, green: 203/255, blue: 235/255, alpha: 1).cgColor]
        animation.toValue = [UIColor(red: 46/255, green: 104/255, blue: 161/255, alpha: 1).cgColor, UIColor(red: 138/255, green: 150/255, blue: 162/255, alpha: 1).cgColor]
        animation.duration = 1
        gradientLayer.add(animation, forKey: nil)
        
        gradientLayer.colors = [UIColor(red: 46/255, green: 104/255, blue: 161/255, alpha: 1).cgColor, UIColor(red: 138/255, green: 150/255, blue: 162/255, alpha: 1).cgColor]
    }
    
    
    static func getWeatherImage(for symbol: String?) -> UIImage {
        var symbolName: String!
        var config = UIImage.SymbolConfiguration.preferringMulticolor()
        
        switch symbol {
            case "sun.max":
                symbolName = "sun.max.fill"
            case "cloud.sun":
                symbolName = "cloud.sun.fill"
            case "cloud":
                symbolName = "cloud.fill"
            case "cloud.drizzle":
                symbolName = "cloud.drizzle.fill"
            case "cloud.rain":
                symbolName = "cloud.rain.fill"
            case "cloud.moon":
                symbolName = "cloud.moon.fill"
                config = config.applying(UIImage.SymbolConfiguration(paletteColors: [.label, .systemYellow, .tertiaryLabel]))
            case "cloud.moon.rain":
                symbolName = "cloud.moon.rain.fill"
                config = config.applying(UIImage.SymbolConfiguration(paletteColors: [.label, .systemYellow, .tertiaryLabel]))
            case "moon.stars":
                symbolName = "moon.stars.fill"
                config = config.applying(UIImage.SymbolConfiguration(paletteColors: [.systemYellow, .secondaryLabel]))
            case "wind":
                symbolName = "wind"
            case "snow":
                symbolName = "snow"
            case "moon.haze":
                symbolName = "moon.haze.fill"
                config = config.applying(UIImage.SymbolConfiguration(paletteColors: [.label, .systemYellow, .tertiaryLabel]))
            case "sun.haze":
                symbolName = "sun.haze.fill"
                config = config.applying(UIImage.SymbolConfiguration(paletteColors: [.label, .systemYellow, .tertiaryLabel]))
            default:
                symbolName = "square.fill"
                config = config.applying(UIImage.SymbolConfiguration(paletteColors: [.secondaryLabel]))
        }
        return UIImage(systemName: symbolName, withConfiguration: config)!
    }
}
