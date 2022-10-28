//
//  PWHourForecastDelegate.swift
//  Pocket Weather
//
//  Created by Adam Paluszewski on 28/10/2022.
//

import Foundation
import UIKit
import WeatherKit


class PWForecastDelegate: NSObject, UITableViewDelegate {
    
    override init() {}
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        PWForecastTableViewHeader()
    }
}
