//
//  PWHourForecastHeaderView.swift
//  Pocket Weather
//
//  Created by Adam Paluszewski on 10/10/2022.
//

import UIKit

class PWHourForecastHeaderView: UIView {

    @UsesAutoLayout var stackView = UIStackView()
    @UsesAutoLayout var hLine = UIView()
    @UsesAutoLayout var titleLabel = PWSectionHeaderLabel()
    @UsesAutoLayout var hourImageView = UIImageView()
    @UsesAutoLayout var precipitationImageView = UIImageView()
    @UsesAutoLayout var cloudCoverImageView = UIImageView()
    @UsesAutoLayout var windImageView = UIImageView()
    @UsesAutoLayout var conditionImageView = UIImageView()
    @UsesAutoLayout var segmentedControl = UISegmentedControl(items: ["6h", "12h", "24h"])
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure() {
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        titleLabel.text = "Hourly"
        hourImageView.image = UIImage(named: "clock")
        conditionImageView.image = UIImage(named: "temp")
        precipitationImageView.image = UIImage(named: "umbrella")
        cloudCoverImageView.image = UIImage(named: "clouds")
        windImageView.image = UIImage(named: "wind")
        
        hourImageView.contentMode = .scaleAspectFit
        conditionImageView.contentMode = .scaleAspectFit
        precipitationImageView.contentMode = .scaleAspectFit
        cloudCoverImageView.contentMode = .scaleAspectFit
        windImageView.contentMode = .scaleAspectFit
        
        hourImageView.tintColor = .label
        conditionImageView.tintColor = .label
        precipitationImageView.tintColor = .label
        cloudCoverImageView.tintColor = .label
        windImageView.tintColor = .label
        
        hLine.backgroundColor = .lightGray
        
        segmentedControl.selectedSegmentIndex = 0
        
        addSubviews()
    }
    
    
    func addSubviews() {
        addSubview(stackView)
        addSubview(segmentedControl)
        addSubview(hLine)
        addSubview(titleLabel)
        stackView.addArrangedSubview(hourImageView)
        stackView.addArrangedSubview(conditionImageView)
        stackView.addArrangedSubview(precipitationImageView)
        stackView.addArrangedSubview(cloudCoverImageView)
        stackView.addArrangedSubview(windImageView)
        

        
        let imageHeight: CGFloat = 20
        let imageViewWidth: CGFloat = 60
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            
            segmentedControl.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            segmentedControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            segmentedControl.widthAnchor.constraint(equalToConstant: 170),
            segmentedControl.heightAnchor.constraint(equalToConstant: 30),
            
            hLine.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            hLine.leadingAnchor.constraint(equalTo: leadingAnchor),
            hLine.trailingAnchor.constraint(equalTo: trailingAnchor),
            hLine.heightAnchor.constraint(equalToConstant: 0.25),
            
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            stackView.heightAnchor.constraint(equalToConstant: 20),

            hourImageView.heightAnchor.constraint(equalToConstant: imageHeight),
            hourImageView.widthAnchor.constraint(equalToConstant: imageViewWidth),

            conditionImageView.heightAnchor.constraint(equalToConstant: imageHeight),
            conditionImageView.widthAnchor.constraint(equalToConstant: imageViewWidth),

            precipitationImageView.heightAnchor.constraint(equalToConstant: imageHeight),
            precipitationImageView.widthAnchor.constraint(equalToConstant: imageViewWidth),

            windImageView.heightAnchor.constraint(equalToConstant: imageHeight),
            windImageView.widthAnchor.constraint(equalToConstant: imageViewWidth),

            cloudCoverImageView.heightAnchor.constraint(equalToConstant: imageHeight),
            cloudCoverImageView.widthAnchor.constraint(equalToConstant: imageViewWidth),
        ])
    }
}
