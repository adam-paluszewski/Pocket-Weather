//
//  PWHourForecastHeaderView.swift
//  Pocket Weather
//
//  Created by Adam Paluszewski on 10/10/2022.
//

import UIKit


protocol HourForecastSegmentedControlDelegate: AnyObject {
    func segmentedControlValueChanged(to index: Int)
}


class PWHourForecastHeaderView: PWForecastHeaderView {

    weak var delegate: HourForecastSegmentedControlDelegate?
    
    var segmentedControl = UISegmentedControl(items: ["6h", "12h", "24h"])
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func configure() {
        super.configure()
        titleLabel.text = Localization.hourly
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 0
    }
    
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        delegate?.segmentedControlValueChanged(to: sender.selectedSegmentIndex)
    }
    
    
    override func addSubviews() {
        super.addSubviews()
        addSubview(segmentedControl)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            segmentedControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            segmentedControl.widthAnchor.constraint(equalToConstant: 170),
            segmentedControl.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
}
