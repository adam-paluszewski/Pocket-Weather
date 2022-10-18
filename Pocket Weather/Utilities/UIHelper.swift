//
//  UIHelper.swift
//  Pocket Weather
//
//  Created by Adam Paluszewski on 17/10/2022.
//

import UIKit


struct UIHelper {
    
    static func createAxialGradient(in view: UIView, startPoint: CGPoint, endPoint: CGPoint, colors: [CGColor]) {
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        gradient.colors = colors
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        gradient.locations = [0, 0.1, 0.9, 1]
        view.layer.insertSublayer(gradient, at: 0)
    }
    
    
    static func getImagesAndColors(for symbol: String) -> (weatherImage: UIImage, backgroundImage: UIImage, sectionColor: UIColor, currentWeatherBackgroundColor: UIColor) {
        var config = UIImage.SymbolConfiguration.preferringMulticolor()
        
        var iconName: String!
        var bgImageName: String!
        var sectionColor: UIColor!
        var currentWeatherBackgroundColor: UIColor!
        var navigationColor: UIColor!
        
        switch symbol {
            case "sun.max":
                iconName = "sun.max.fill"
                bgImageName = "clear-bg"
                sectionColor = UIColor(red: 71/255, green: 139/255, blue: 174/255, alpha: 0.65)
                currentWeatherBackgroundColor = .clear
            case "cloud.sun":
                iconName = "cloud.sun.fill"
                bgImageName = "cloud-sun-bg-vertical"
                sectionColor = UIColor(red: 71/255, green: 139/255, blue: 174/255, alpha: 0.80)
                currentWeatherBackgroundColor = .clear
            case "cloud":
                iconName = "cloud.fill"
                bgImageName = "clouds-bg"
                sectionColor = UIColor(red: 84/255, green: 92/255, blue: 92/255, alpha: 0.65)
                currentWeatherBackgroundColor = .clear
            case "cloud.drizzle":
                iconName = "cloud.drizzle.fill"
                bgImageName = "cloud-drizzle-bg"
                sectionColor = UIColor(red: 38/255, green: 138/255, blue: 188/255, alpha: 0.35)
                currentWeatherBackgroundColor = .clear
            case "cloud.rain":
                iconName = "cloud.rain.fill"
                bgImageName = "cloud-drizzle-bg"
                sectionColor = UIColor(red: 38/255, green: 138/255, blue: 188/255, alpha: 0.35)
                currentWeatherBackgroundColor = .clear
            case "cloud.moon":
                iconName = "cloud.moon.fill"
                bgImageName = "cloud-moon-bg-vertical"
                sectionColor = UIColor(red: 38/255, green: 138/255, blue: 188/255, alpha: 0.35)
                currentWeatherBackgroundColor = .clear
                config = config.applying(UIImage.SymbolConfiguration(paletteColors: [.label, .systemYellow, .tertiaryLabel]))
            case "cloud.moon.rain":
                iconName = "cloud.moon.rain.fill"
                bgImageName = "cloud-moon-bg-vertical"
                sectionColor = UIColor(red: 38/255, green: 138/255, blue: 188/255, alpha: 0.35)
                currentWeatherBackgroundColor = .clear
                config = config.applying(UIImage.SymbolConfiguration(paletteColors: [.label, .systemYellow, .tertiaryLabel]))
            case "moon.stars":
                iconName = "moon.stars.fill"
                bgImageName = "moon-stars-bg"
                sectionColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.65)
                currentWeatherBackgroundColor = .clear
                config = config.applying(UIImage.SymbolConfiguration(paletteColors: [.systemYellow, .secondaryLabel]))
            default:
                iconName = "heart"
                bgImageName = "moon-stars-bg"
                sectionColor = .clear
                currentWeatherBackgroundColor = .clear
        }
        let weatherImage = UIImage(systemName: iconName, withConfiguration: config)!
        let backgroundImage = UIImage(named: bgImageName)!
        
        return (weatherImage: weatherImage, backgroundImage: backgroundImage, sectionColor: sectionColor, currentWeatherBackgroundColor: currentWeatherBackgroundColor)
    }
    
    
}
