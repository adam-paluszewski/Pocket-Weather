//
//  PWBodyLabel.swift
//  Pocket Weather
//
//  Created by Adam Paluszewski on 09/10/2022.
//

import UIKit

class PWBodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(textAlignment: NSTextAlignment, fontWeight: UIFont.Weight = .regular) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = .systemFont(ofSize: 16, weight: fontWeight)
        configure()
    }
    
    
    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    

}
