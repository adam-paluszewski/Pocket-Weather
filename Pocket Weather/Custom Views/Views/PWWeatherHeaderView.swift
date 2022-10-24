//
//  PWWeatherHeaderView.swift
//  Pocket Weather
//
//  Created by Adam Paluszewski on 09/10/2022.
//

import UIKit
import WeatherKit

class PWWeatherHeaderView: UIView {

    @UsesAutoLayout var conditionLabel = PWBodyLabel(textAlignment: .center)
    @UsesAutoLayout var temperatureLabel = PWSectionHeaderLabel(textAlignment: .center)
    @UsesAutoLayout var cityLabel = PWSectionHeaderLabel(textAlignment: .center)
    @UsesAutoLayout var fetchingWeatherLabel = PWSectionHeaderLabel(textAlignment: .center)
    
    var weatherAssets: CurrentWeatherAssets!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")

    }
    
    
    func configure() {
        cityLabel.font = .systemFont(ofSize: 30, weight: .medium)
        fetchingWeatherLabel.font = .systemFont(ofSize: 32, weight: .regular)
        fetchingWeatherLabel.numberOfLines = 0
        conditionLabel.font = .systemFont(ofSize: 18, weight: .regular)
        
        temperatureLabel.font = .systemFont(ofSize: 100, weight: .thin)

        cityLabel.addShadow()
        temperatureLabel.addShadow()
        fetchingWeatherLabel.addShadow()
        conditionLabel.addShadow()
        
        fetchingWeatherLabel.text = "Checking location..."
    
        addSubviews()
    }

    
    func addSubviews() {
        addSubview(cityLabel)
        addSubview(fetchingWeatherLabel)
        addSubview(temperatureLabel)
        addSubview(conditionLabel)
        
        NSLayoutConstraint.activate([
            fetchingWeatherLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            fetchingWeatherLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            fetchingWeatherLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            
            temperatureLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 10),
            temperatureLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -15),
            temperatureLabel.widthAnchor.constraint(equalToConstant: 150),
            
            cityLabel.bottomAnchor.constraint(equalTo: temperatureLabel.topAnchor, constant: -10),
            cityLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            cityLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            cityLabel.heightAnchor.constraint(equalToConstant: 30),
             
            conditionLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor),
            conditionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            conditionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            conditionLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
        

    }
    
    
    func set(for location: LocationData) {
        fetchingWeatherLabel.isHidden = true
        
        cityLabel.text = location.city
        
        let formatter = MeasurementFormatter()
        formatter.unitStyle = .short
        formatter.numberFormatter.maximumFractionDigits = 0
        
        if let temperature = location.weather?.currentWeather.temperature {
            let tempString = formatter.string(from: temperature)
            temperatureLabel.text = tempString
        }
        
        conditionLabel.text = location.weather?.currentWeather.condition.description
    }
    
    
    func animate(offset: CGFloat) {
        let viewHeight = frame.height
        
        cityLabel.transform = CGAffineTransform(translationX: 0, y: offset * 0.92)
        temperatureLabel.transform = CGAffineTransform(translationX: 0, y: offset * 0.92)
        conditionLabel.transform = CGAffineTransform(translationX: 0, y: offset * 0.9)
        
        conditionLabel.alpha = 1 - (offset - viewHeight * 0.30) * 0.05 //1px = 5%
        temperatureLabel.alpha = 1 - (offset - viewHeight * 0.45) * 0.05
        cityLabel.alpha = 1 - (offset - viewHeight * 0.90) * 0.05
    }
}

