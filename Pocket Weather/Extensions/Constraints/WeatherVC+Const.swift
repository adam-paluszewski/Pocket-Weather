//
//  WeatherVCConst.swift
//  Pocket Weather
//
//  Created by Adam Paluszewski on 28/10/2022.
//

import UIKit


extension WeatherVC {
    
    func activateConstraints() {
        hourForecastViewHeightConstraint = hourForecastView.heightAnchor.constraint(equalToConstant: 660)
        dayForecastViewHeightConstraint = dayForecastView.heightAnchor.constraint(equalToConstant: 635)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            headerView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.35),
            
            hourForecastViewHeightConstraint,
            dayForecastViewHeightConstraint,

            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -15),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -15),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -30),
        ])
    }
}
