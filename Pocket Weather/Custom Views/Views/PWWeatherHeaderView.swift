//
//  PWWeatherHeaderView.swift
//  Pocket Weather
//
//  Created by Adam Paluszewski on 09/10/2022.
//

import UIKit
import WeatherKit

class PWWeatherHeaderView: UIView {

    @UsesAutoLayout var bgImage = UIImageView()
    @UsesAutoLayout var conditionLabel = PWBodyLabel()
    @UsesAutoLayout var weatherIcon = UIImageView()
    @UsesAutoLayout var temperatureLabel = PWTemperatureLabel()
    @UsesAutoLayout var cityLabel = PWSectionHeaderLabel(textAlignment: .center)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")

    }
    
    
    func configure() {
        weatherIcon.contentMode = .scaleAspectFit
        weatherIcon.tintColor = .secondaryLabel
        cityLabel.font = .systemFont(ofSize: 30, weight: .bold)
    
        bgImage.layer.cornerRadius = 10
        bgImage.clipsToBounds = true
        
        addSubviews()
    }

    
    func addSubviews() {
        addSubview(bgImage)
        addSubview(cityLabel)
        addSubview(conditionLabel)
        addSubview(weatherIcon)
        addSubview(temperatureLabel)
        
        NSLayoutConstraint.activate([
            bgImage.topAnchor.constraint(equalTo: topAnchor),
            bgImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            bgImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            bgImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            cityLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            cityLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            cityLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            cityLabel.heightAnchor.constraint(equalToConstant: 30),
            
            conditionLabel.topAnchor.constraint(equalTo: bgImage.topAnchor, constant: 15),
            conditionLabel.leadingAnchor.constraint(equalTo: bgImage.leadingAnchor, constant: 15),
            conditionLabel.heightAnchor.constraint(equalToConstant: 20),
            
            temperatureLabel.trailingAnchor.constraint(equalTo: bgImage.trailingAnchor, constant: -140),
            temperatureLabel.centerYAnchor.constraint(equalTo: bgImage.centerYAnchor, constant: 20),
            
            weatherIcon.centerYAnchor.constraint(equalTo: bgImage.centerYAnchor, constant: 20),
            weatherIcon.trailingAnchor.constraint(equalTo: temperatureLabel.leadingAnchor, constant: -10),
            weatherIcon.heightAnchor.constraint(equalToConstant: 60),
            weatherIcon.widthAnchor.constraint(equalToConstant: 60),
            
        ])
    }
    
    
    func set(for location: LocationData, tabBar: UITabBar, navBar: UINavigationBar) {
        
        cityLabel.text = location.city
        
        let formatter = MeasurementFormatter()
        formatter.unitStyle = .medium
        formatter.numberFormatter.maximumFractionDigits = 0
        
        let tempString = formatter.string(from: (location.weather?.currentWeather.temperature)!)
        temperatureLabel.text = tempString

        var iconName: String = ""
        var imageName: String = ""
        var navBarColor: UIColor = .clear
        switch location.weather?.currentWeather.symbolName {
            case "sun.max":
                iconName = "sun.max"
                imageName = "clouds2"
                navBarColor = UIColor(red: 51/255, green: 153/255, blue: 255/255, alpha: 0.6)
            case "cloud":
                iconName = "cloud"
                imageName = "clouds2"
                navBarColor = .gray
            case "cloud.drizzle":
                iconName = "cloud.drizzle"
            case "cloud.moon":
                iconName = "cloud.moon"
            case "moon.stars":
                iconName = "moon.stars"
            case "cloud.sun":
                iconName = "cloud.sun"
            default:
                print()
                
        }
        weatherIcon.image = UIImage(named: iconName)
        bgImage.image = UIImage(named: imageName)
    }
}
