//
//  PWSearchResultCell.swift
//  Pocket Weather
//
//  Created by Adam Paluszewski on 13/10/2022.
//

import UIKit

class PWSearchResultCell: UITableViewCell {

    static let cellid = "SearchResultCell"
    
    @UsesAutoLayout var infoLabel = PWBodyLabel(textAlignment: .left)
    @UsesAutoLayout var cityLabel = PWSectionHeaderLabel(textAlignment: .left)

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure() {
        backgroundColor = .clear
        accessoryType = .disclosureIndicator
        addSubviews()
    }
    
    
    func set(isFetching: Bool, city: String?) {
        switch isFetching {
            case true:
                accessoryType = .none
                cityLabel.isHidden = true
                infoLabel.textColor = .label
                infoLabel.text = "Searching..."
            case false:
                if city == "Unknown city" {
                    accessoryType = .none
                    cityLabel.isHidden = true
                    infoLabel.textColor = .secondaryLabel
                    infoLabel.text = "No city found. Keep typing."
                } else {
                    accessoryType = .disclosureIndicator
                    cityLabel.isHidden = false
                    cityLabel.text = city
                    infoLabel.text = "choose:"
                }
        }
    }
    
    
    func addSubviews() {
        addSubview(infoLabel)
        addSubview(cityLabel)
        
        NSLayoutConstraint.activate([
            infoLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            infoLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            cityLabel.firstBaselineAnchor.constraint(equalTo: infoLabel.firstBaselineAnchor),
            cityLabel.leadingAnchor.constraint(equalTo: infoLabel.trailingAnchor, constant: 5)
        ])
    }
}
