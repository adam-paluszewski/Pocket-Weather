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
    
    
    func set(for location: LocationData) {
        
        cityLabel.text = location.city
        
        let formatter = MeasurementFormatter()
        formatter.unitStyle = .short
        formatter.numberFormatter.maximumFractionDigits = 0
        
        let tempString = formatter.string(from: (location.weather?.currentWeather.temperature)!)
        temperatureLabel.text = tempString

        let images = UIHelper.getImagesAndColors(for: (location.weather?.currentWeather.symbolName)!)
        weatherIconImageView.image = images.weatherImage
       
        backgroundColor =  images.currentWeatherBackgroundColor
        
        conditionLabel.text = location.weather?.currentWeather.condition.description
    }
    
    
    func scale(offset: CGFloat) {
        var cityLabelTransform = CGAffineTransform.identity
        cityLabelTransform = cityLabelTransform.translatedBy(x: offset * -0.55, y: offset * 0.15) //0.65
        cityLabelTransform = cityLabelTransform.scaledBy(x: 1 - offset * 0.003, y: 1 - offset * 0.003)
        cityLabel.transform = cityLabelTransform

        var stackViewTransform = CGAffineTransform.identity
        stackViewTransform = stackViewTransform.translatedBy(x: offset * 0.95, y: offset * -0.8) //-0.2
        stackViewTransform = stackViewTransform.scaledBy(x: 1 - offset * 0.007, y: 1 - offset * 0.007)
        stackView.transform = stackViewTransform
        
        conditionLabel.transform = CGAffineTransform(scaleX: max(0, 1 - offset * 0.2), y: max(0, 1 - offset * 0.2))
        
        
//        cityLabel.transform = CGAffineTransform(translationX: offset * -3, y: 0)
//        stackView.transform  = CGAffineTransform(translationX: offset * 3, y: 0)
    }
}
