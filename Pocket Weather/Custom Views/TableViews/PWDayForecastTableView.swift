//
//  PWDayForecastTableView.swift
//  Pocket Weather
//
//  Created by Adam Paluszewski on 28/10/2022.
//

import UIKit

class PWDayForecastTableView: UITableView {

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: .zero, style: style)
        
        register(PWDayForecastCell.self, forCellReuseIdentifier: PWDayForecastCell.cellid)
        backgroundColor = .clear
        sectionHeaderTopPadding = 0
        rowHeight = 55
        separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        isUserInteractionEnabled = false
        prepareForDynamicHeight()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
