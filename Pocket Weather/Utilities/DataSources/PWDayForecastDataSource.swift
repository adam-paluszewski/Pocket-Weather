//
//  PWDayForecastDataSource.swift
//  Pocket Weather
//
//  Created by Adam Paluszewski on 28/10/2022.
//

import Foundation
import WeatherKit
import UIKit


class PWDayForecastDataSource: NSObject, UITableViewDataSource {
    
    let forecast: [DayWeather]!
    let vc: PWDayForecastVC!
    
    init(forecast: [DayWeather], vc: PWDayForecastVC) {
        self.forecast = forecast
        self.vc = vc
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        forecast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PWDayForecastCell.cellid, for: indexPath) as! PWDayForecastCell
        cell.set(weather: forecast[indexPath.row])
        return cell
    }
    
    
}
