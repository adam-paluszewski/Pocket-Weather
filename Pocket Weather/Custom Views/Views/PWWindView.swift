//
//  PWWindView.swift
//  Pocket Weather
//
//  Created by Adam Paluszewski on 12/10/2022.
//

import UIKit
import WeatherKit

class PWWindView: UIView {

    @UsesAutoLayout var windImageView = UIImageView()
    @UsesAutoLayout var windLabel = PWCaptionLabel(textAlignment: .center)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure() {
        windLabel.textColor = .label
        windImageView.contentMode = .scaleAspectFill
        
        addSubviews()
        

    }

    
    func addSubviews() {
        addSubview(windImageView)
        addSubview(windLabel)
        
        NSLayoutConstraint.activate([
            windLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 9),
            windLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            windLabel.widthAnchor.constraint(equalToConstant: 60),
            windLabel.heightAnchor.constraint(equalToConstant: 11),
            
            windImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -9),
            windImageView.centerXAnchor.constraint(equalTo: windLabel.centerXAnchor),
        ])
    }
    
    
    func set(weather: HourWeather) {
        let windSpeed = weather.wind.speed.value
        let windFormatted = String(format: "%.0f", windSpeed)
        windLabel.text = "\(windFormatted) km/h"
        
        let windDirection = weather.wind.compassDirection
        var image = UIImage()
        
        switch windDirection {
            case .north:
                image = UIImage(systemName: "arrow.up")!
            case .northNortheast, .northeast, .eastNortheast:
                image = UIImage(systemName: "arrow.up.right")!
            case .east:
                image = UIImage(systemName: "arrow.right")!
            case .eastSoutheast, .southeast, .southSoutheast:
                image = UIImage(systemName: "arrow.down.right")!
            case .south:
                image = UIImage(systemName: "arrow.down")!
            case .southSouthwest, .southwest, .westSouthwest:
                image = UIImage(systemName: "arrow.down.left")!
            case .west:
                image = UIImage(systemName: "arrow.left")!
            case .westNorthwest, .northwest, .northNorthwest:
                image = UIImage(systemName: "arrow.up.left")!
        }
        windImageView.image = image
        
        switch windSpeed {
            case 0...20:
                windImageView.tintColor = UIColor(red: 53/255, green: 81/255, blue: 92/255, alpha: 1)
                NSLayoutConstraint.activate([
                    windImageView.widthAnchor.constraint(equalToConstant: 17),
                    windImageView.heightAnchor.constraint(equalToConstant: 17),
                ])
            case 21...40:
                windImageView.tintColor = .systemYellow
                NSLayoutConstraint.activate([
                    windImageView.widthAnchor.constraint(equalToConstant: 19),
                    windImageView.heightAnchor.constraint(equalToConstant: 19),
                ])
            case 41...60:
                windImageView.tintColor = .systemRed
                NSLayoutConstraint.activate([
                    windImageView.widthAnchor.constraint(equalToConstant: 21),
                    windImageView.heightAnchor.constraint(equalToConstant: 21),
                ])
            case 61...80:
                windImageView.tintColor = .systemRed
                NSLayoutConstraint.activate([
                    windImageView.widthAnchor.constraint(equalToConstant: 23),
                    windImageView.heightAnchor.constraint(equalToConstant: 23),
                ])
            default:
                print()
        }
    }
    
    
    func set(weather: DayWeather) {
        let windSpeed = weather.wind.speed.value
        let windFormatted = String(format: "%.0f", windSpeed)
        windLabel.text = "\(windFormatted) km/h"
        
        let windDirection = weather.wind.compassDirection
        var image = UIImage()
        
        switch windDirection {
            case .north:
                image = UIImage(systemName: "arrow.up")!
            case .northNortheast, .northeast, .eastNortheast:
                image = UIImage(systemName: "arrow.up.right")!
            case .east:
                image = UIImage(systemName: "arrow.right")!
            case .eastSoutheast, .southeast, .southSoutheast:
                image = UIImage(systemName: "arrow.down.right")!
            case .south:
                image = UIImage(systemName: "arrow.down")!
            case .southSouthwest, .southwest, .westSouthwest:
                image = UIImage(systemName: "arrow.down.left")!
            case .west:
                image = UIImage(systemName: "arrow.left")!
            case .westNorthwest, .northwest, .northNorthwest:
                image = UIImage(systemName: "arrow.up.left")!
        }
        windImageView.image = image
        
        switch windSpeed {
            case 0...14:
                windImageView.tintColor = .systemGreen
            case 14...20:
                windImageView.tintColor = .systemYellow
            case 21...30:
                windImageView.tintColor = .systemRed
            default:
                print()
        }
    }
}
