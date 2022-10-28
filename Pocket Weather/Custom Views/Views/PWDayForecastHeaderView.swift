//
//  PWDayForecastHeaderView.swift
//  Pocket Weather
//
//  Created by Adam Paluszewski on 12/10/2022.
//

import UIKit

class PWDayForecastHeaderView: PWForecastHeaderView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func configure() {
        super.configure()
        titleLabel.text = Localization.daily
    }
}
