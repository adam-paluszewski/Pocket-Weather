//
//  PWNavBarTitleView.swift
//  Pocket Weather
//
//  Created by Adam Paluszewski on 18/10/2022.
//

import UIKit

class PWNavBarTitleView: UIView {

    @UsesAutoLayout var stackView = UIStackView()
    @UsesAutoLayout var conditionIconImageView = UIImageView()
    @UsesAutoLayout var temperatureLabel = PWBodyLabel(textAlignment: .center)
    @UsesAutoLayout var cityLabel = PWBodyLabel(textAlignment: .center)
    
    var weatherAssets: WeatherAssets!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    init(location: LocationData) {
        super.init(frame: .zero)
        
        weatherAssets = WeatherAssets(symbol: location.weather?.currentWeather.symbolName, condition: location.weather?.currentWeather.condition.description)
        conditionIconImageView.image = weatherAssets.weatherConditionSymbol
        conditionIconImageView.contentMode = .scaleAspectFit
        
        let formatter = MeasurementFormatter()
        formatter.unitStyle = .short
        formatter.numberFormatter.maximumFractionDigits = 0
        let tempString = formatter.string(from: (location.weather?.currentWeather.temperature)!)
        temperatureLabel.text = tempString
        
        cityLabel.text = location.city + "   | "
        
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure() {
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally

        addSubviews()
    }

    
    func addSubviews() {
        addSubview(stackView)
        stackView.addArrangedSubview(cityLabel)
        stackView.addArrangedSubview(conditionIconImageView)
        stackView.addArrangedSubview(temperatureLabel)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 200),
            stackView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

}
