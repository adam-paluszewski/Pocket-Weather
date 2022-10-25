//
//  PWMiniConditionView.swift
//  Pocket Weather
//
//  Created by Adam Paluszewski on 21/10/2022.
//

import UIKit


enum MiniConditionIcon {
    case precipitation, cloudCover, wind
}

class PWMiniConditionView: UIView {

    @UsesAutoLayout var conditionImageView = UIImageView()
    @UsesAutoLayout var conditionLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        addSubviews()
    }
    
    
    init(for condition: MiniConditionIcon) {
        super.init(frame: .zero)
        
        switch condition {
            case .precipitation:
                conditionImageView.image = UIImage(named: "umbrella")
            case .cloudCover:
                conditionImageView.image = UIImage(named: "clouds")
            case .wind:
                conditionImageView.image = UIImage(named: "wind")
        }
        
        configure()
        addSubviews()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure() {
        conditionImageView.contentMode = .scaleAspectFit
        conditionLabel.text = "-"
    }
    
    
    func set(with text: String) {
        conditionLabel.text = text
    }
    
    
    func addSubviews() {
        addSubview(conditionImageView)
        addSubview(conditionLabel)
        
        NSLayoutConstraint.activate([
            conditionImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            conditionImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            conditionImageView.widthAnchor.constraint(equalToConstant: 20),
            conditionImageView.heightAnchor.constraint(equalToConstant: 20),
            
            conditionLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            conditionLabel.leadingAnchor.constraint(equalTo: conditionImageView.trailingAnchor, constant: 5),
            conditionLabel.widthAnchor.constraint(equalToConstant: 70),
            conditionLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
}
