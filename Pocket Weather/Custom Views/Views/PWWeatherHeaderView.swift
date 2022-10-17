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
    @UsesAutoLayout var weatherIconImageView = UIImageView()
    @UsesAutoLayout var temperatureLabel = PWSectionHeaderLabel(textAlignment: .center)
    @UsesAutoLayout var cityLabel = PWSectionHeaderLabel(textAlignment: .center)
    @UsesAutoLayout var stackView = UIStackView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")

    }
    
    
    func configure() {
        weatherIconImageView.contentMode = .scaleAspectFit
        weatherIconImageView.tintColor = .secondaryLabel
        cityLabel.font = .systemFont(ofSize: 30, weight: .bold)
        conditionLabel.font = .systemFont(ofSize: 18, weight: .light)
        
        temperatureLabel.font = .systemFont(ofSize: 62, weight: .regular)
        
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        
        backgroundColor = UIColor(red: 100/255, green: 163/255, blue: 195/255, alpha: 0.50)
        layer.cornerRadius = 10
        
        cityLabel.addShadow()
        weatherIconImageView.addShadow()
        temperatureLabel.addShadow()
    
        addSubviews()
    }

    
    func addSubviews() {
        addSubview(cityLabel)
        addSubview(stackView)
        stackView.addArrangedSubview(weatherIconImageView)
        stackView.addArrangedSubview(temperatureLabel)
        addSubview(conditionLabel)
        
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            cityLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            cityLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            cityLabel.heightAnchor.constraint(equalToConstant: 30),
            
            weatherIconImageView.widthAnchor.constraint(equalToConstant: 80),
            
            temperatureLabel.widthAnchor.constraint(equalToConstant: 110),
            
            stackView.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 20),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 80),

            conditionLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 15),
            conditionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            conditionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            conditionLabel.heightAnchor.constraint(equalToConstant: 20),

            
        ])
    }
    
    
    func set(for location: LocationData, tabBar: UITabBar, navBar: UINavigationBar, bgView: UIView) {
        
        cityLabel.text = location.city
        
        let formatter = MeasurementFormatter()
        formatter.unitStyle = .short
        formatter.numberFormatter.maximumFractionDigits = 0
        
        let tempString = formatter.string(from: (location.weather?.currentWeather.temperature)!)
        temperatureLabel.text = tempString

        var navBarColor: UIColor = .clear
        
        let images = UIHelper.getSFSymbolWithConfiguration(symbol: (location.weather?.currentWeather.symbolName)!)
        weatherIconImageView.image = images.weatherImage
        bgView.backgroundColor = UIColor(patternImage: images.backgroundImage!)
        
        conditionLabel.text = location.weather?.currentWeather.condition.description
        
        
        
//        UIHelper.createAxialGradient(in: self, startPoint: CGPoint(x: 0.5, y: 0), endPoint: CGPoint(x: 0.5, y: 1), colors: [UIColor.clear.cgColor, UIColor(displayP3Red: 0/255, green: 0/255, blue: 0/255, alpha: 0.06).cgColor, UIColor(displayP3Red: 0/255, green: 0/255, blue: 0/255, alpha: 0.06).cgColor, UIColor.clear.cgColor])
        
    }
}
