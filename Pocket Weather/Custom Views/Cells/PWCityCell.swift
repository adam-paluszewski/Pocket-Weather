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
    @UsesAutoLayout var blackFilterView = UIView()
    @UsesAutoLayout var weatherIconImageView = UIImageView()
    @UsesAutoLayout var cityLabel = PWBodyLabel(textAlignment: .left)
    @UsesAutoLayout var temperatureLabel = PWSectionHeaderLabel(textAlignment: .center)
    @UsesAutoLayout var cloudCoverView = PWMiniConditionView(for: .cloudCover)
    @UsesAutoLayout var windView = PWMiniConditionView(for: .wind)
    @UsesAutoLayout var precipitationView = PWMiniConditionView(for: .precipitation)
    @UsesAutoLayout var weatherDescLabel = PWBodyLabel(textAlignment: .left)
    @UsesAutoLayout var stackView = UIStackView()
    
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
        
        blackFilterView.layer.cornerRadius = 20
        blackFilterView.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.25)
        
        containerView.layer.cornerRadius = 20
        containerView.clipsToBounds = true
        containerView.backgroundColor = UIColor(red: 108/255, green: 127/255, blue: 142/255, alpha: 1)
        
        let config = UIImage.SymbolConfiguration(paletteColors: [.secondaryLabel])
        let weatherIconImage = UIImage(systemName: "square.fill", withConfiguration: config)
        weatherIconImageView.image = weatherIconImage
        weatherIconImageView.contentMode = .scaleAspectFit
        weatherIconImageView.addShadow()
        
        temperatureLabel.font = .systemFont(ofSize: 36, weight: .medium)
        temperatureLabel.text = "-"
        temperatureLabel.addShadow()
        
        cityLabel.font = .systemFont(ofSize: 24, weight: .medium)
        cityLabel.addShadow()
        
        weatherDescLabel.textColor = .secondaryLabel
        weatherDescLabel.text = "Checking weather..."
        weatherDescLabel.addShadow()
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        addSubviews()
    }
    
    
    func set(for location: LocationData) {
        cityLabel.text = location.city
        guard let weather = location.weather else { return }

        weatherAssets = WeatherAssets(symbol: weather.currentWeather.symbolName, condition: weather.currentWeather.condition.description)
        
        
        let formatter = MeasurementFormatter()
        formatter.unitStyle = .short
        formatter.numberFormatter.maximumFractionDigits = 0
        
        if let temp = location.weather?.currentWeather.temperature {
            let tempString = formatter.string(from: temp)
            temperatureLabel.text = tempString
        }
        
        weatherIconImageView.image = weatherAssets?.weatherConditionSymbol
        
        containerView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height - 10)
        containerView.backgroundColor = .clear
        let videoBackgroundManager = VideoBackgroundManager()
        videoBackgroundManager.addPlayerLayer(in: containerView, with: weatherAssets!.dynamicVerticalBgName)
        
        if let precipitation = location.weather?.hourlyForecast.forecast[0].precipitationChance {
            let precipitationChance = precipitation * 100
            let precipitationChanceFormatted = String(format: "%.0f", precipitationChance)
            precipitationView.set(with: "\(precipitationChanceFormatted)%")
        }
        
        
        if let cloudCover = location.weather?.currentWeather.cloudCover {
            let cloudCoverage = cloudCover * 100
            let cloudCoverageFormatted = String(format: "%.0f", cloudCoverage)
            cloudCoverView.set(with: "\(cloudCoverageFormatted)%")
        }
        
        
        if let windSpeed = location.weather?.currentWeather.wind.speed.value {
            let windFormatted = String(format: "%.0f", windSpeed)
            windView.set(with: "\(windFormatted) km/h")
        }

        
        
        weatherDescLabel.text = location.weather?.currentWeather.condition.description
    }
    
    
    func addSubviews() {
        addSubview(containerView)
        containerView.addSubview(blackFilterView)
        containerView.addSubview(weatherIconImageView)
        containerView.addSubview(cityLabel)
        containerView.addSubview(temperatureLabel)
        containerView.addSubview(weatherDescLabel)
        addSubview(stackView)
        stackView.addArrangedSubview(precipitationView)
        stackView.addArrangedSubview(cloudCoverView)
        stackView.addArrangedSubview(windView)
        
        let padding: CGFloat = 15
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            
            blackFilterView.topAnchor.constraint(equalTo: containerView.topAnchor),
            blackFilterView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            blackFilterView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            blackFilterView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            
            weatherIconImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            weatherIconImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            weatherIconImageView.heightAnchor.constraint(equalToConstant: 50),
            weatherIconImageView.widthAnchor.constraint(equalToConstant: 50),
            
            cityLabel.topAnchor.constraint(equalTo: weatherIconImageView.topAnchor),
            cityLabel.leadingAnchor.constraint(equalTo: weatherIconImageView.trailingAnchor, constant: 15),

            temperatureLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            temperatureLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            
            weatherDescLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 2),
            weatherDescLabel.leadingAnchor.constraint(equalTo: cityLabel.leadingAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
