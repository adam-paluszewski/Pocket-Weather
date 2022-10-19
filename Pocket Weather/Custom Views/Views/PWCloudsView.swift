//
//  PWCloudsView.swift
//  Pocket Weather
//
//  Created by Adam Paluszewski on 12/10/2022.
//

import UIKit
import WeatherKit

class PWCloudsView: UIView {

    @UsesAutoLayout var cloudCoverLabel = PWCaptionLabel(textAlignment: .center)
    @UsesAutoLayout var cloudCoverBar = UIProgressView(progressViewStyle: .default)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure() {
        cloudCoverBar.progressTintColor = .systemGreen
        cloudCoverBar.trackTintColor = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 0.2)
        cloudCoverLabel.textColor = .label
        
        addSubviews()
    }

    
    func addSubviews() {
        addSubview(cloudCoverLabel)
        addSubview(cloudCoverBar)
        
        NSLayoutConstraint.activate([
            cloudCoverLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -7),
            cloudCoverLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            cloudCoverLabel.widthAnchor.constraint(equalToConstant: 60),
            
            cloudCoverBar.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 7),
            cloudCoverBar.leadingAnchor.constraint(equalTo: cloudCoverLabel.leadingAnchor),
            cloudCoverBar.widthAnchor.constraint(equalToConstant: 60),
            cloudCoverBar.heightAnchor.constraint(equalToConstant: 10)
        ])
    }
    
    
    func set(weather: HourWeather) {
        let cloudCoverage = weather.cloudCover * 100
        let cloudCoverageFormatted = String(format: "%.0f", cloudCoverage)
        cloudCoverLabel.text = "\(cloudCoverageFormatted)%"
        
        cloudCoverBar.progress = Float(weather.cloudCover)
        
        let colors = [UIColor(red: 220/255, green: 236/255, blue: 255/255, alpha: 1),
                      UIColor(red: 206/255, green: 221/255, blue: 246/255, alpha: 1),
                      UIColor(red: 196/255, green: 205/255, blue: 229/255, alpha: 1),
                      UIColor(red: 166/255, green: 172/255, blue: 184/255, alpha: 1),
                      UIColor(red: 135/255, green: 142/255, blue: 152/255, alpha: 1)]
        
//        let colors = [UIColor(red: 106/255, green: 173/255, blue: 239/255, alpha: 1),
//                      UIColor(red: 153/255, green: 204/255, blue: 255/255, alpha: 1),
//                      UIColor(red: 204/255, green: 229/255, blue: 255/255, alpha: 1),
//                      UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1),
//                      UIColor(red: 160/255, green: 160/255, blue: 160/255, alpha: 1)]
//
        switch cloudCoverBar.progress*100 {
            case 0..<20:
                cloudCoverBar.progressTintColor = colors[0]
            case 20..<40:
                cloudCoverBar.progressTintColor = colors[1]
            case 40..<60:
                cloudCoverBar.progressTintColor = colors[2]
            case 60..<80:
                cloudCoverBar.progressTintColor = colors[3]
            case 80...100:
                cloudCoverBar.progressTintColor = colors[4]
            default:
                print()
        }
    }
}
