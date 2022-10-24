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
    @UsesAutoLayout var cityLabel = PWBodyLabel(textAlignment: .left)
    @UsesAutoLayout var countryLabel = PWBodyLabel(textAlignment: .left)

    
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
        countryLabel.textColor = .secondaryLabel
        countryLabel.font = .systemFont(ofSize: 16, weight: .light)
        addSubviews()
    }
    
    
    func set(city: String, country: String) {
        cityLabel.text = city + ","
        countryLabel.text = country
    }
    
    
    func addSubviews() {
        addSubview(cityLabel)
        addSubview(countryLabel)
        
        NSLayoutConstraint.activate([
            cityLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            cityLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            
            countryLabel.firstBaselineAnchor.constraint(equalTo: cityLabel.firstBaselineAnchor),
            countryLabel.leadingAnchor.constraint(equalTo: cityLabel.trailingAnchor, constant: 5)
        ])
    }
}
