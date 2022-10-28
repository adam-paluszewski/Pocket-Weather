//
//  PWForecastHeaderView.swift
//  Pocket Weather
//
//  Created by Adam Paluszewski on 28/10/2022.
//

import UIKit

class PWForecastHeaderView: UIView {

    @UsesAutoLayout var hLine = UIView()
    @UsesAutoLayout var titleLabel = PWSectionHeaderLabel()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure() {
        hLine.backgroundColor = .lightGray
        
        addSubviews()
    }
    
    
    func addSubviews() {
        addSubview(hLine)
        addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),

            hLine.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            hLine.leadingAnchor.constraint(equalTo: leadingAnchor),
            hLine.trailingAnchor.constraint(equalTo: trailingAnchor),
            hLine.heightAnchor.constraint(equalToConstant: 0.25),
        ])
    }

}
