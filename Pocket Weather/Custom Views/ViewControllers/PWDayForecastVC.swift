//
//  PWDayForecastVC.swift
//  Pocket Weather
//
//  Created by Adam Paluszewski on 12/10/2022.
//

import UIKit
import WeatherKit

class PWDayForecastVC: UIViewController {

    @UsesAutoLayout var tableView = PWDayForecastTableView()
    @UsesAutoLayout var headerView = PWDayForecastHeaderView()
    
    var dataSource: PWDayForecastDataSource!
    var delegate: PWForecastDelegate!
    
    var forecast: [DayWeather] = [] {
        didSet {
            DispatchQueue.main.async {
                self.configureTableView()
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        print(forecast.count)
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    

    func configureViewController() {
        view.clipsToBounds = true
        view.backgroundColor = UIColor(red: 71/255, green: 139/255, blue: 174/255, alpha: 0.65)
        view.layer.cornerRadius = 16
        layoutUI()
    }
    
    
    func configureTableView() {
        dataSource = PWDayForecastDataSource(forecast: forecast, vc: self)
        tableView.dataSource = dataSource
        
        delegate = PWForecastDelegate()
        tableView.delegate = delegate
        
        tableView.reloadData()
        self.preferredContentSize.height = self.tableView.contentSize.height
    }
    
    
    @objc func daysSegmentedControlValueChanged() {
        tableView.reloadData()
        preferredContentSize.height = tableView.contentSize.height
    }
    
    
    func layoutUI() {
        view.addSubview(headerView)
        view.addSubview(tableView)
        activateConstraints()
    }
}
