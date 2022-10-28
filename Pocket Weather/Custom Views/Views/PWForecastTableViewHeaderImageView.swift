//
//  PWForecastTableViewHeaderImageView.swift
//  Pocket Weather
//
//  Created by Adam Paluszewski on 28/10/2022.
//

import UIKit

class PWForecastTableViewHeaderImageView: UIImageView {

    enum ImageName: String {
        case clock = "clock"
        case umbrella = "umbrella"
        case clouds = "clouds"
        case wind = "wind"
        case condition = "temp"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    init(imageName: ImageName) {
        super.init(frame: .zero)
        image = UIImage(named: imageName.rawValue)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure() {
        contentMode = .scaleAspectFit
        tintColor = .label
    }
}
