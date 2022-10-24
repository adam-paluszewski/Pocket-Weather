//
//  PWDayForecastCell.swift
//  Pocket Weather
//
//  Created by Adam Paluszewski on 12/10/2022.
//

import UIKit
import WeatherKit

class PWDayForecastCell: UITableViewCell {

    static let cellid = "DayForecastCell"

    @UsesAutoLayout var stackView = UIStackView()
    @UsesAutoLayout var dayLabel = PWBodyLabel(textAlignment: .center, fontWeight: .bold)
    @UsesAutoLayout var minTempLabel = PWBodyLabel(textAlignment: .center)

    @UsesAutoLayout var conditionView = PWConditionView()
    @UsesAutoLayout var precipitationLabel = PWCaptionLabel(textAlignment: .center)
    @UsesAutoLayout var windView = PWWindView()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure() {
        clipsToBounds = true
        backgroundColor = .clear
        addSubviews()
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        precipitationLabel.textColor = .label
        
        minTempLabel.font = .systemFont(ofSize: 16, weight: .light)
    }
    
    
    func addSubviews() {
        addSubview(stackView)
        stackView.addArrangedSubview(dayLabel)
        stackView.addArrangedSubview(conditionView)
        stackView.addArrangedSubview(minTempLabel)
        stackView.addArrangedSubview(precipitationLabel)
        stackView.addArrangedSubview(windView)
        

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            dayLabel.widthAnchor.constraint(equalToConstant: 60),
            conditionView.widthAnchor.constraint(equalToConstant: 60),
            precipitationLabel.widthAnchor.constraint(equalToConstant: 60),
            windView.widthAnchor.constraint(equalToConstant: 60),
            minTempLabel.widthAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    
    func set(weather: DayWeather) {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        formatter.timeZone = .autoupdatingCurrent
        dayLabel.text = formatter.string(from: weather.date)
    
        
        let precipitationChance = weather.precipitationChance * 100
        let precipitationChanceFormatted = String(format: "%.0f", precipitationChance)
        precipitationLabel.text = "\(precipitationChanceFormatted)%"
        
        if precipitationChanceFormatted == "0" {
            precipitationLabel.text = "-"
            precipitationLabel.textColor = .secondaryLabel
//            precipitationLabel.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.2)
        }
        
        windView.set(weather: weather)
        conditionView.set(weather: weather)
        
        let formatter2 = MeasurementFormatter()
        formatter2.unitStyle = .short
        formatter2.numberFormatter.maximumFractionDigits = 0
        minTempLabel.text = formatter2.string(from: weather.lowTemperature)
    }

}
