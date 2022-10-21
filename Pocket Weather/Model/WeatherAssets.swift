//
//  WeatherAssets.swift
//  Pocket Weather
//
//  Created by Adam Paluszewski on 19/10/2022.
//

import UIKit


struct WeatherAssets {
    
    var sectionColor: UIColor!
    var navigationBarsColor: UIColor!
    var weatherConditionSymbol: UIImage!
    var dynamicVerticalBgName: String = "mostly-cloudy-vd"
    var horizontalBgImage: UIImage!
    
    
    init(symbol: String?, condition: String?) {
        var symbolName: String!
        var config = UIImage.SymbolConfiguration.preferringMulticolor()
        
        switch symbol {
            case "sun.max":
                symbolName = "sun.max.fill"
                switch condition {
                    case "Mostly Clear":
                        dynamicVerticalBgName = "mostly-clear-vd"
                        sectionColor = UIColor(red: 94/255, green: 134/255, blue: 174/255, alpha: 0.80)
                        horizontalBgImage = UIImage(named: "clear")
                    case "Clear":
                        dynamicVerticalBgName = "clear-vd"
                        sectionColor = UIColor(red: 58/255, green: 105/255, blue: 152/255, alpha: 0.8)
                        horizontalBgImage = UIImage(named: "clear")
                    default:
                        sectionColor = UIColor(red: 71/255, green: 139/255, blue: 174/255, alpha: 0.65)
                }
                
            case "cloud.sun":
                symbolName = "cloud.sun.fill"
                dynamicVerticalBgName = "partly-cloudy-vd"
                sectionColor = UIColor(red: 94/255, green: 134/255, blue: 174/255, alpha: 0.80)
                horizontalBgImage = UIImage(named: "cloud-sun-bg")
            
            case "cloud":
                symbolName = "cloud.fill"
                switch condition {
                    case "Mostly Cloudy":
                        dynamicVerticalBgName = "mostly-cloudy-vd"
                        sectionColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 0.80)
                        horizontalBgImage = UIImage(named: "clouds-bg")
                    case "Cloudy":
                        dynamicVerticalBgName = "cloud-vd"
                        sectionColor = UIColor(red: 70/255, green: 110/255, blue: 141/255, alpha: 0.80)
                        horizontalBgImage = UIImage(named: "clouds-bg")
                    default:
                        sectionColor = .clear
                        navigationBarsColor = .clear
                }
                
                
            case "cloud.drizzle":
                symbolName = "cloud.drizzle.fill"
                dynamicVerticalBgName = "drizzle-vd"
                sectionColor = UIColor(red: 152/255, green: 156/255, blue: 136/255, alpha: 0.80)
                horizontalBgImage = UIImage(named: "clouds-bg")
                
            case "cloud.rain":
                symbolName = "cloud.rain.fill"
                dynamicVerticalBgName = "rain-vd"
                sectionColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 0.80)
                horizontalBgImage = UIImage(named: "clouds-bg")
                
            case "cloud.moon":
                symbolName = "cloud.moon.fill"
                dynamicVerticalBgName = "cloud-moon-vd"
                sectionColor = UIColor(red: 32/255, green: 32/255, blue: 32/255, alpha: 0.8)
                horizontalBgImage = UIImage(named: "cloud-moon-bg")
                config = config.applying(UIImage.SymbolConfiguration(paletteColors: [.label, .systemYellow, .tertiaryLabel]))
                
            case "cloud.moon.rain":
                symbolName = "cloud.moon.rain.fill"
                sectionColor = UIColor(red: 38/255, green: 138/255, blue: 188/255, alpha: 0.35)
                horizontalBgImage = UIImage(named: "clouds-bg")
                config = config.applying(UIImage.SymbolConfiguration(paletteColors: [.label, .systemYellow, .tertiaryLabel]))
                
            case "moon.stars":
                symbolName = "moon.stars.fill"
                dynamicVerticalBgName = "moon-stars-vd"
                sectionColor = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 0.8)
                horizontalBgImage = UIImage(named: "moon-stars-bg")
                config = config.applying(UIImage.SymbolConfiguration(paletteColors: [.systemYellow, .secondaryLabel]))
                
            case "wind":
                symbolName = "wind"
                dynamicVerticalBgName = "wind-vd"
                sectionColor = UIColor(red: 150/255, green: 154/255, blue: 140/255, alpha: 0.8)
                horizontalBgImage = UIImage(named: "clouds-bg")
                
            default:
                symbolName = "square.fill"
                sectionColor = .clear
                horizontalBgImage = UIImage(named: "main-bg")
                config = config.applying(UIImage.SymbolConfiguration(paletteColors: [.secondaryLabel]))
        }
        weatherConditionSymbol = UIImage(systemName: symbolName, withConfiguration: config)!

    }
    
    
}
