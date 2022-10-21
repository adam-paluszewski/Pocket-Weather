//
//  PWCityCell.swift
//  Pocket Weather
//
//  Created by Adam Paluszewski on 13/10/2022.
//

import UIKit
import WeatherKit

class PWCityCell: UITableViewCell {
    
    static let cellId = "PWCityCell"
    
    @UsesAutoLayout var containerView = UIView()
    @UsesAutoLayout var bgImageView = UIImageView()
    @UsesAutoLayout var weatherIconImageView = UIImageView()
    @UsesAutoLayout var cityLabel = PWBodyLabel(textAlignment: .left)
    @UsesAutoLayout var temperatureLabel = PWSectionHeaderLabel(textAlignment: .center)
    @UsesAutoLayout var cloudCoverLabel = PWBodyLabel(textAlignment: .left)
    @UsesAutoLayout var cloudCoverImageView = UIImageView()
    @UsesAutoLayout var windLabel = PWBodyLabel(textAlignment: .left)
    @UsesAutoLayout var windImageView = UIImageView()
    @UsesAutoLayout var precipitationLabel = PWBodyLabel(textAlignment: .left)
    @UsesAutoLayout var precipitationImageView = UIImageView()
    @UsesAutoLayout var weatherDescLabel = PWBodyLabel(textAlignment: .left)
    
    var weatherAssets: WeatherAssets?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure() {
        backgroundColor = .clear
        
        bgImageView.contentMode = .scaleAspectFill
        bgImageView.clipsToBounds = true
        bgImageView.layer.cornerRadius = 20
        bgImageView.image = UIImage(named: "main-bg")
        
        var config = UIImage.SymbolConfiguration(paletteColors: [.secondaryLabel])
        let weatherIconImage = UIImage(systemName: "square.fill", withConfiguration: config)
        weatherIconImageView.image = weatherIconImage
        
        precipitationImageView.image = UIImage(named: "umbrella")
        cloudCoverImageView.image = UIImage(named: "clouds")
        windImageView.image = UIImage(named: "wind")
        
        precipitationImageView.contentMode = .scaleAspectFit
        cloudCoverImageView.contentMode = .scaleAspectFit
        windImageView.contentMode = .scaleAspectFit
        
        containerView.layer.cornerRadius = 20
        
        temperatureLabel.font = .systemFont(ofSize: 36, weight: .medium)
        cityLabel.font = .systemFont(ofSize: 24, weight: .medium)
        weatherDescLabel.textColor = .secondaryLabel
        
        weatherIconImageView.contentMode = .scaleAspectFit
        
        precipitationLabel.text = "-"
        cloudCoverLabel.text = "-"
        windLabel.text = "-"
        temperatureLabel.text = "-"
        cityLabel.text = "Checking weather..."
        
        addSubviews()
        
        
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 85, width: 400, height: 60)
        gradient.colors = [UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.4).cgColor,
                           UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.01).cgColor]
        gradient.startPoint = CGPoint(x: 0.5, y: 1)
        gradient.endPoint = CGPoint(x: 0.5, y: 0)
        
        bgImageView.layer.insertSublayer(gradient, at: 0)
    }
    
    
    func set(for location: LocationData) {

        if let weather = location.weather {
            weatherAssets = WeatherAssets(symbol: weather.currentWeather.symbolName, condition: weather.currentWeather.condition.description)
        }
        
        
        cityLabel.text = location.city
        
        let formatter = MeasurementFormatter()
        formatter.unitStyle = .short
        formatter.numberFormatter.maximumFractionDigits = 0
        
        if let temp = location.weather?.currentWeather.temperature {
            let tempString = formatter.string(from: temp)
            temperatureLabel.text = tempString
        }
        
        weatherIconImageView.image = weatherAssets?.weatherConditionSymbol
        bgImageView.image =  weatherAssets?.horizontalBgImage
        
        if let precipitation = location.weather?.hourlyForecast.forecast[0].precipitationChance {
            let precipitationChance = precipitation * 100
            let precipitationChanceFormatted = String(format: "%.0f", precipitationChance)
            precipitationLabel.text = "\(precipitationChanceFormatted)%"
        }
        
        
        if let cloudCover = location.weather?.currentWeather.cloudCover {
            let cloudCoverage = cloudCover * 100
            let cloudCoverageFormatted = String(format: "%.0f", cloudCoverage)
            cloudCoverLabel.text = "\(cloudCoverageFormatted)%"
        }
        
        
        if let windSpeed = location.weather?.currentWeather.wind.speed.value {
            let windFormatted = String(format: "%.0f", windSpeed)
            windLabel.text = "\(windFormatted) km/h"
        }

        
        
        weatherDescLabel.text = location.weather?.currentWeather.condition.description
    }
    
    
    func addSubviews() {
        addSubview(containerView)
        containerView.addSubview(bgImageView)
        containerView.addSubview(weatherIconImageView)
        containerView.addSubview(cityLabel)
        containerView.addSubview(cloudCoverLabel)
        containerView.addSubview(cloudCoverImageView)
        containerView.addSubview(windLabel)
        containerView.addSubview(windImageView)
        containerView.addSubview(precipitationLabel)
        containerView.addSubview(precipitationImageView)
        containerView.addSubview(temperatureLabel)
        containerView.addSubview(weatherDescLabel)
        
        let padding: CGFloat = 15
        let imageSize: CGFloat = 20
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            bgImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            bgImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            bgImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            bgImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            
            weatherIconImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            weatherIconImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            weatherIconImageView.heightAnchor.constraint(equalToConstant: 65),
            weatherIconImageView.widthAnchor.constraint(equalToConstant: 65),
            
            cityLabel.topAnchor.constraint(equalTo: weatherIconImageView.topAnchor),
            cityLabel.leadingAnchor.constraint(equalTo: weatherIconImageView.trailingAnchor, constant: 10),
            
            precipitationImageView.leadingAnchor.constraint(equalTo: weatherIconImageView.leadingAnchor, constant: 10),
            precipitationImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            precipitationImageView.widthAnchor.constraint(equalToConstant: imageSize),
            precipitationImageView.heightAnchor.constraint(equalToConstant: imageSize),
            
            precipitationLabel.leadingAnchor.constraint(equalTo: precipitationImageView.trailingAnchor, constant: 5),
            precipitationLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            precipitationLabel.widthAnchor.constraint(equalToConstant: 60),
            precipitationLabel.heightAnchor.constraint(equalToConstant: imageSize),
            
            cloudCoverImageView.leadingAnchor.constraint(equalTo: precipitationLabel.trailingAnchor, constant: 10),
            cloudCoverImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            cloudCoverImageView.widthAnchor.constraint(equalToConstant: imageSize),
            cloudCoverImageView.heightAnchor.constraint(equalToConstant: imageSize),
            
            cloudCoverLabel.leadingAnchor.constraint(equalTo: cloudCoverImageView.trailingAnchor, constant: 5),
            cloudCoverLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            cloudCoverLabel.widthAnchor.constraint(equalToConstant: 60),
            cloudCoverLabel.heightAnchor.constraint(equalToConstant: imageSize),
            
            windImageView.leadingAnchor.constraint(equalTo: cloudCoverLabel.trailingAnchor, constant: 10),
            windImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            windImageView.widthAnchor.constraint(equalToConstant: imageSize),
            windImageView.heightAnchor.constraint(equalToConstant: imageSize),
            
            windLabel.leadingAnchor.constraint(equalTo: windImageView.trailingAnchor, constant: 5),
            windLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            windLabel.widthAnchor.constraint(equalToConstant: 60),
            windLabel.heightAnchor.constraint(equalToConstant: imageSize),
            
            temperatureLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            temperatureLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            
            weatherDescLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 5),
            weatherDescLabel.leadingAnchor.constraint(equalTo: cityLabel.leadingAnchor)
        ])
    }
}
