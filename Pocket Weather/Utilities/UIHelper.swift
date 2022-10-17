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
    
    
    static func getSFSymbolWithConfiguration(symbol: String) -> (weatherImage: UIImage?, backgroundImage: UIImage?, sectionColor: UIColor) {
        var config = UIImage.SymbolConfiguration.preferringMulticolor()
        
        var iconName: String!
        var bgImageName: String!
        var sectionColor: UIColor!
        
        switch symbol {
            case "sun.max":
                iconName = "sun.max.fill"
                bgImageName = "clear-bg"
                sectionColor = .clear
            case "cloud.sun":
                iconName = "cloud.sun.fill"
                bgImageName = "cloud-sun-bg-vertical"
                sectionColor = .clear
            case "cloud":
                iconName = "cloud.fill"
                bgImageName = "clouds-bg"
                sectionColor = .clear
            case "cloud.drizzle":
                iconName = "cloud.drizzle.fill"
                bgImageName = "cloud-drizzle-bg"
                sectionColor = .clear
            case "cloud.moon":
                iconName = "cloud.moon.fill"
                bgImageName = "cloud-moon-bg-vertical"
                sectionColor = .clear
                config = config.applying(UIImage.SymbolConfiguration(paletteColors: [.label, .systemYellow, .tertiaryLabel]))
            case "moon.stars":
                iconName = "moon.stars.fill"
                bgImageName = "moon-stars-bg"
                sectionColor = .clear
                sectionColor = Constants.SectionColors.moonStars
                config = config.applying(UIImage.SymbolConfiguration(paletteColors: [.systemYellow, .secondaryLabel]))
            default:
                iconName = ""
                bgImageName = "moon-stars-bg"
                sectionColor = .clear
        }
        let weatherImage = UIImage(systemName: iconName, withConfiguration: config)
        let backgroundImage = UIImage(named: bgImageName)
        
        return (weatherImage: weatherImage, backgroundImage: backgroundImage, sectionColor: sectionColor)
    }
    
    
}
