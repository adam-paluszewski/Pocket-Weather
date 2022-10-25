//
//  WeatherAssets.swift
//  Pocket Weather
//
//  Created by Adam Paluszewski on 19/10/2022.
//

import UIKit
import WeatherKit


struct CurrentWeatherAssets {
    
    var sectionColor: UIColor!
    var navigationBarsColor: UIColor!
    var weatherConditionSymbol: UIImage!
    var dynamicVerticalBgName: String = "mostly-cloudy-vd"
    var horizontalBgImage: UIImage!
    
    
    init(weather: Weather?) {
        let currentWeather = weather?.currentWeather
        let isDaylight = currentWeather?.isDaylight
        
        var horizontalBgName: String!
        var symbolName: String!
        var config = UIImage.SymbolConfiguration.preferringMulticolor()
        
        switch currentWeather?.symbolName {
            case "sun.max":
                symbolName = "sun.max.fill"
                switch currentWeather?.condition.description {
                    case Localization.mostlyClear:
                        dynamicVerticalBgName = "mostly-clear-vd"
                        horizontalBgName = "mostly-clear-h"
                        sectionColor = UIColor(red: 94/255, green: 134/255, blue: 174/255, alpha: 0.80)
                    case Localization.clear:
                        dynamicVerticalBgName = "clear-vd"
                        horizontalBgName = "clear-h"
                        sectionColor = UIColor(red: 58/255, green: 105/255, blue: 152/255, alpha: 0.8)
                    default:
                        print()
                }
                
            case "cloud.sun":
                symbolName = "cloud.sun.fill"
                dynamicVerticalBgName = "partly-cloudy-vd"
                horizontalBgName = "partly-cloudy-h"
                sectionColor = UIColor(red: 94/255, green: 134/255, blue: 174/255, alpha: 0.80)
            
            case "cloud":
                symbolName = "cloud.fill"
                switch currentWeather?.condition.description {
                    case Localization.mostlyCloudy:
                        dynamicVerticalBgName = "mostly-cloudy-vd"
                        horizontalBgName = "mostly-cloudy-h"
                        sectionColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 0.80)
                    case Localization.cloudy:
                        dynamicVerticalBgName = "cloud-vd"
                        horizontalBgName = "clouds-h"
                        sectionColor = UIColor(red: 70/255, green: 110/255, blue: 141/255, alpha: 0.80)
                    default:
                        print()
                }
                
                
            case "cloud.drizzle":
                symbolName = "cloud.drizzle.fill"
                dynamicVerticalBgName = "drizzle-vd"
                horizontalBgName = "drizzle-h"
                sectionColor = UIColor(red: 152/255, green: 156/255, blue: 136/255, alpha: 0.80)
                
            case "cloud.rain":
                symbolName = "cloud.rain.fill"
                dynamicVerticalBgName = "rain-vd"
                horizontalBgName = "rain-h"
                sectionColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 0.80)
                
            case "cloud.moon":
                symbolName = "cloud.moon.fill"
                dynamicVerticalBgName = "cloud-moon-vd"
                horizontalBgName = "cloud-moon-h"
                sectionColor = UIColor(red: 32/255, green: 32/255, blue: 32/255, alpha: 0.8)
                config = config.applying(UIImage.SymbolConfiguration(paletteColors: [.label, .systemYellow, .tertiaryLabel]))
                
            case "cloud.moon.rain":
                symbolName = "cloud.moon.rain.fill"
                horizontalBgName = "moon-stars-h"
                sectionColor = UIColor(red: 38/255, green: 138/255, blue: 188/255, alpha: 0.35)
                config = config.applying(UIImage.SymbolConfiguration(paletteColors: [.label, .systemYellow, .tertiaryLabel]))
                // to do
                
            case "moon.stars":
                symbolName = "moon.stars.fill"
                dynamicVerticalBgName = "moon-stars-vd"
                horizontalBgName = "moon-stars-h"
                sectionColor = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 0.8)
                config = config.applying(UIImage.SymbolConfiguration(paletteColors: [.systemYellow, .secondaryLabel]))
                
            case "wind":
                symbolName = "wind"
                dynamicVerticalBgName = "wind-vd"
                horizontalBgName = "wind-h"
                sectionColor = UIColor(red: 150/255, green: 154/255, blue: 140/255, alpha: 0.8)
                
            case "snow":
                symbolName = "snow"
                dynamicVerticalBgName = "wind-vd"
                horizontalBgName = "wind-h"
                sectionColor = UIColor(red: 150/255, green: 154/255, blue: 140/255, alpha: 0.8)
                // to do
                
            case "moon.haze":
                symbolName = "moon.haze.fill"
                dynamicVerticalBgName = "moon-haze-vd"
                horizontalBgName = "moon-haze-h"
                sectionColor = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 0.8)
                config = config.applying(UIImage.SymbolConfiguration(paletteColors: [.label, .systemYellow, .tertiaryLabel]))
                // to do
                
            case "sun.haze":
                symbolName = "sun.haze.fill"
                dynamicVerticalBgName = "wind-vd"
                horizontalBgName = "wind-h"
                sectionColor = UIColor(red: 150/255, green: 154/255, blue: 140/255, alpha: 0.8)
                config = config.applying(UIImage.SymbolConfiguration(paletteColors: [.label, .systemYellow, .tertiaryLabel]))
                // to do
                
            default:
                print()
        }
        weatherConditionSymbol = UIImage(systemName: symbolName, withConfiguration: config)!
        horizontalBgImage = UIImage(named: horizontalBgName)
    }
    
    
}
