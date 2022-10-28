//
//  PWHourForecastVC.swift
//  Pocket Weather
//
//  Created by Adam Paluszewski on 09/10/2022.
//

import UIKit
import WeatherKit

class PWHourForecastVC: UIViewController {
    
    @UsesAutoLayout var tableView = PWHourForecastTableView()
    @UsesAutoLayout var headerView = PWHourForecastHeaderView()
    
    var forecast: [HourWeather] = [] {
        didSet {
            let date = Date()
            self.forecast = forecast.filter{$0.date >= date}
            DispatchQueue.main.async {
                self.tableView.forecast = self.forecast
                self.configureTableView()
            }
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }


    func configureViewController() {
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        headerView.delegate = tableView
        layoutUI()
    }
    
    
    func configureTableView() {
        tableView.sizeDidChange = {
            self.preferredContentSize.height = self.tableView.contentSize.height
        }
        tableView.strongDataSource = PWHourForecastDataSource(forecast: forecast, hours: 6)
        tableView.strongDelegate = PWForecastDelegate()
        
        self.preferredContentSize.height = self.tableView.contentSize.height
    }

    
    func layoutUI() {
        view.addSubview(headerView)
        view.addSubview(tableView)
        activateConstraints()
    }
}
