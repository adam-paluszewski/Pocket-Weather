//
//  PWSectionHeaderLabel.swift
//  Pocket Weather
//
//  Created by Adam Paluszewski on 10/10/2022.
//

import UIKit

class PWSectionHeaderLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(textAlignment: NSTextAlignment) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        configure()
    }
    
    
    func configure() {
        font = .systemFont(ofSize: 22, weight: .bold)
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    

}
