//
//  PWTemperatureLabel.swift
//  Pocket Weather
//
//  Created by Adam Paluszewski on 09/10/2022.
//

import UIKit

class PWTemperatureLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure() {
        font = .systemFont(ofSize: 26, weight: .regular)
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
}
