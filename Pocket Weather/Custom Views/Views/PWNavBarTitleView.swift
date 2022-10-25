//
//  PWNavBarTitleView.swift
//  Pocket Weather
//
//  Created by Adam Paluszewski on 18/10/2022.
//

import UIKit

class PWNavBarTitleView: UIView {

    @UsesAutoLayout var stackView = UIStackView()
    @UsesAutoLayout var conditionView = PWConditionView()
    @UsesAutoLayout var cityLabel = PWBodyLabel(textAlignment: .center)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    init(location: LocationData) {
        super.init(frame: .zero)
        
        cityLabel.text = location.city + "   "
        
        conditionView.set(weather: location.weather?.currentWeather)
        
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure() {
        stackView.axis = .horizontal
//        stackView.distribution = .fillProportionally

        addSubviews()
    }

    
    func addSubviews() {
        addSubview(stackView)
        stackView.addArrangedSubview(cityLabel)
        stackView.addArrangedSubview(conditionView)
        
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 30),
            
            conditionView.widthAnchor.constraint(equalToConstant: 60)
        ])
    }

}
