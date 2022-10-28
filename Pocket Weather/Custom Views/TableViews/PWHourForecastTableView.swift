//
//  PWHourForecastTableView.swift
//  Pocket Weather
//
//  Created by Adam Paluszewski on 28/10/2022.
//

import UIKit
import WeatherKit

class PWHourForecastTableView: UITableView, HourForecastSegmentedControlDelegate {
    
    var sizeDidChange: (() -> Void)?
    var forecast: [HourWeather] = []
    
    var strongDelegate: PWForecastDelegate! {
        didSet {
            delegate = strongDelegate
            reloadData()
        }
    }
    
    var strongDataSource: PWHourForecastDataSource! {
        didSet {
            dataSource = strongDataSource
            reloadData()
        }
    }
    
    func segmentedControlValueChanged(to index: Int) {
        var hours: Int!
        switch index {
            case 0:
                hours = 6
            case 1:
                hours = 12
            case 2:
                hours = 24
            default:
                hours = 0
        }
        strongDataSource = PWHourForecastDataSource(forecast: forecast, hours: hours)
        sizeDidChange!()
    }

    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: .zero, style: style)
        self.register(PWHourForecastCell.self, forCellReuseIdentifier: PWHourForecastCell.cellid)
        self.backgroundColor = .clear
        self.sectionHeaderTopPadding = 0
        self.rowHeight = 55
        self.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        self.allowsSelection = false
        self.prepareForDynamicHeight()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
