//
//  PWConditionView.swift
//  Pocket Weather
//
//  Created by Adam Paluszewski on 12/10/2022.
//

import UIKit
import WeatherKit

class PWConditionView: UIView {

    @UsesAutoLayout var conditionIconImageView = UIImageView()
    @UsesAutoLayout var maxTemperatureLabel = PWBodyLabel(textAlignment: .center)
    @UsesAutoLayout var minTemperatureLabel = PWCaptionLabel(textAlignment: .center)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure() {
        conditionIconImageView.tintColor = .label
        conditionIconImageView.addShadow()

        addSubviews()
    }

    
    func addSubviews() {
        addSubview(conditionIconImageView)
        addSubview(maxTemperatureLabel)
        addSubview(minTemperatureLabel)
        
        NSLayoutConstraint.activate([
            conditionIconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            conditionIconImageView.widthAnchor.constraint(equalToConstant: 30),
            conditionIconImageView.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    
    func set(weather: HourWeather) {
        let weatherImage = UIHelper.getSFSymbolWithConfiguration(symbol: weather.symbolName)
        conditionIconImageView.image = weatherImage.weatherImage
        

        
        
        let formatter2 = MeasurementFormatter()
        formatter2.unitStyle = .short
        formatter2.numberFormatter.maximumFractionDigits = 0
        
        
        maxTemperatureLabel.text = formatter2.string(from: weather.temperature)
        
        minTemperatureLabel.textColor = .clear
        NSLayoutConstraint.activate([
            maxTemperatureLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            maxTemperatureLabel.leadingAnchor.constraint(equalTo: conditionIconImageView.trailingAnchor, constant: 4),
            maxTemperatureLabel.widthAnchor.constraint(equalToConstant: 30),

        ])
    }
    
    
    func set(weather: DayWeather) {
        var iconName: String = ""
        switch weather.symbolName {
            case "sun.max":
                iconName = "sun.max"
            case "cloud":
                iconName = "cloud"
            case "cloud.drizzle":
                iconName = "cloud.drizzle"
            case "cloud.moon":
                iconName = "cloud.moon"
            case "moon.stars":
                iconName = "moon.stars"
            case "cloud.sun":
                iconName = "cloud.sun"
            case "cloud.rain":
                iconName = "cloud.rain"
            default:
                print()
        }
        
        let image = UIImage(systemName: weather.symbolName + ".fill")
        let config = UIImage.SymbolConfiguration.preferringMulticolor()
        conditionIconImageView.image = UIImage(systemName: weather.symbolName + ".fill", withConfiguration: config)
        
        
        let formatter2 = MeasurementFormatter()
        formatter2.unitStyle = .short
        formatter2.numberFormatter.maximumFractionDigits = 0
        
        
        maxTemperatureLabel.text = formatter2.string(from: weather.highTemperature)
        minTemperatureLabel.text = formatter2.string(from: weather.lowTemperature)
        
        NSLayoutConstraint.activate([
            maxTemperatureLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -8),
            maxTemperatureLabel.leadingAnchor.constraint(equalTo: conditionIconImageView.trailingAnchor, constant: 4),
            maxTemperatureLabel.widthAnchor.constraint(equalToConstant: 30),
            
            minTemperatureLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 8),
            minTemperatureLabel.centerXAnchor.constraint(equalTo: maxTemperatureLabel.centerXAnchor)
        ])
    }
}
