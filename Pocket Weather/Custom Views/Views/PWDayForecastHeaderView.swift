//
//  PWDayForecastHeaderView.swift
//  Pocket Weather
//
//  Created by Adam Paluszewski on 12/10/2022.
//

import UIKit

class PWDayForecastHeaderView: UIView {

    @UsesAutoLayout var stackView = UIStackView()
    @UsesAutoLayout var hLine = UIView()
    @UsesAutoLayout var titleLabel = PWSectionHeaderLabel()
    @UsesAutoLayout var hourImageView = UIImageView()
    @UsesAutoLayout var precipitationImageView = UIImageView()
    @UsesAutoLayout var windImageView = UIImageView()
    @UsesAutoLayout var conditionImageView = UIImageView()
    @UsesAutoLayout var minTempImageView = UIImageView()
    
    
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
        
        titleLabel.text = Localization.daily
        hourImageView.image = UIImage(named: "clock")
        conditionImageView.image = UIImage(named: "temp")
        minTempImageView.image = UIImage(named: "temp-min")
        precipitationImageView.image = UIImage(named: "umbrella")
        windImageView.image = UIImage(named: "wind")
        
        hourImageView.contentMode = .scaleAspectFit
        conditionImageView.contentMode = .scaleAspectFit
        minTempImageView.contentMode = .scaleAspectFit
        precipitationImageView.contentMode = .scaleAspectFit
        windImageView.contentMode = .scaleAspectFit
        
        hourImageView.tintColor = .label
        conditionImageView.tintColor = .label
        minTempImageView.tintColor = .label
        precipitationImageView.tintColor = .label
        windImageView.tintColor = .label
        
        hLine.backgroundColor = .lightGray
        
        
        addSubviews()
    }
    
    
    func addSubviews() {
        addSubview(stackView)
        addSubview(hLine)
        addSubview(titleLabel)
        stackView.addArrangedSubview(hourImageView)
        stackView.addArrangedSubview(conditionImageView)
        stackView.addArrangedSubview(minTempImageView)
        stackView.addArrangedSubview(precipitationImageView)
        stackView.addArrangedSubview(windImageView)
        

        
        let imageHeight: CGFloat = 20
        let imageViewWidth: CGFloat = 60
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            
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
            
            minTempImageView.heightAnchor.constraint(equalToConstant: imageHeight),
            minTempImageView.widthAnchor.constraint(equalToConstant: imageViewWidth),

            precipitationImageView.heightAnchor.constraint(equalToConstant: imageHeight),
            precipitationImageView.widthAnchor.constraint(equalToConstant: imageViewWidth),

            windImageView.heightAnchor.constraint(equalToConstant: imageHeight),
            windImageView.widthAnchor.constraint(equalToConstant: imageViewWidth),
        ])
    }
}
