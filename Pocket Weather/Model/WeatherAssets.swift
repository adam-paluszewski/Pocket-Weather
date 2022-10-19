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
    
    
    init(symbol: String?, condition: String?) {
        var symbolName: String!
        var staticVerticalBgName: String!
        var config = UIImage.SymbolConfiguration.preferringMulticolor()
        
        switch symbol {
            case "sun.max":
                switch condition {
                    case "Mostly Clear":
                        symbolName = "sun.max.fill"
                        dynamicVerticalBgName = "mostly-clear-vd"
                        sectionColor = UIColor(red: 94/255, green: 134/255, blue: 174/255, alpha: 0.80)
                        navigationBarsColor = UIColor(red: 94/255, green: 134/255, blue: 174/255, alpha: 0.80)
                    case "Clear":
                        symbolName = "sun.max.fill"
                        staticVerticalBgName = "clear-bg"
                        sectionColor = UIColor(red: 71/255, green: 139/255, blue: 174/255, alpha: 0.65)
                        navigationBarsColor = .clear
                    default:
                        symbolName = "sun.max.fill"
                        staticVerticalBgName = "clear-bg"
                        sectionColor = UIColor(red: 71/255, green: 139/255, blue: 174/255, alpha: 0.65)
                        navigationBarsColor = .clear
                }
                
            case "cloud.sun":
                symbolName = "cloud.sun.fill"
                switch condition {
                    case "Partly Cloudy":
                        dynamicVerticalBgName = "partly-cloudy-vd"
                        sectionColor = UIColor(red: 94/255, green: 134/255, blue: 174/255, alpha: 0.80)
                        navigationBarsColor = UIColor(red: 94/255, green: 134/255, blue: 174/255, alpha: 0.80)
                    default:
                        staticVerticalBgName = "cloud-sun-bg-vertical"
                        sectionColor = UIColor(red: 71/255, green: 139/255, blue: 174/255, alpha: 0.80)
                        navigationBarsColor = .clear
                }
            
            case "cloud":
                symbolName = "cloud.fill"
                switch condition {
                    case "Mostly Cloudy":
                        staticVerticalBgName = "cloud-sun-bg-vertical"
                        dynamicVerticalBgName = "mostly-cloudy-vd"
                        sectionColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 0.80)
                        navigationBarsColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 0.80)
                    case "Cloudy":
                        staticVerticalBgName = "cloud-sun-bg-vertical"
                        sectionColor = UIColor(red: 71/255, green: 139/255, blue: 174/255, alpha: 0.80)
                        navigationBarsColor = .clear
                    default:
                        staticVerticalBgName = "clouds-bg"
                        sectionColor = UIColor(red: 84/255, green: 92/255, blue: 92/255, alpha: 0.65)
                        navigationBarsColor = UIColor(red: 84/255, green: 84/255, blue: 84/255, alpha: 0.65)
                }
                
                
            case "cloud.drizzle":
                symbolName = "cloud.drizzle.fill"
                staticVerticalBgName = "cloud-drizzle-bg"
                sectionColor = UIColor(red: 38/255, green: 138/255, blue: 188/255, alpha: 0.35)
                navigationBarsColor = .clear
                
            case "cloud.rain":
                symbolName = "cloud.rain.fill"
                staticVerticalBgName = "cloud-drizzle-bg"
                sectionColor = UIColor(red: 38/255, green: 138/255, blue: 188/255, alpha: 0.35)
                navigationBarsColor = .clear
                
            case "cloud.moon":
                symbolName = "cloud.moon.fill"
                staticVerticalBgName = "cloud-moon-bg-vertical"
                sectionColor = UIColor(red: 38/255, green: 138/255, blue: 188/255, alpha: 0.35)
                navigationBarsColor = .clear
                config = config.applying(UIImage.SymbolConfiguration(paletteColors: [.label, .systemYellow, .tertiaryLabel]))
                
            case "cloud.moon.rain":
                symbolName = "cloud.moon.rain.fill"
                staticVerticalBgName = "cloud-moon-bg-vertical"
                sectionColor = UIColor(red: 38/255, green: 138/255, blue: 188/255, alpha: 0.35)
                navigationBarsColor = .clear
                config = config.applying(UIImage.SymbolConfiguration(paletteColors: [.label, .systemYellow, .tertiaryLabel]))
                
            case "moon.stars":
                symbolName = "moon.stars.fill"
                staticVerticalBgName = "moon-stars-bg"
                sectionColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.1)
                navigationBarsColor = .clear
                config = config.applying(UIImage.SymbolConfiguration(paletteColors: [.systemYellow, .secondaryLabel]))
                
            default:
                symbolName = "heart"
                staticVerticalBgName = "moon-stars-bg"
                sectionColor = .clear
                navigationBarsColor = .clear
        }
        weatherConditionSymbol = UIImage(systemName: symbolName, withConfiguration: config)!

    }
    
    
}
