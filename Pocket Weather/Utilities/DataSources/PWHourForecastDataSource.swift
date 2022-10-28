//
//  PWHourForecastDataSource.swift
//  Pocket Weather
//
//  Created by Adam Paluszewski on 28/10/2022.
//

import UIKit
import WeatherKit


class PWHourForecastDataSource: NSObject, UITableViewDataSource {
    
    let forecast: [HourWeather]!
    var hours: Int!
    
    init(forecast: [HourWeather], hours: Int) {
        self.forecast = forecast
        self.hours = hours
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hours
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PWHourForecastCell.cellid, for: indexPath) as! PWHourForecastCell
        cell.set(weather: forecast[indexPath.row])
        return cell
    }
    
    
}
