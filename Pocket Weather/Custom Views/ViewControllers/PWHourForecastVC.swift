//
//  PWHourForecastVC.swift
//  Pocket Weather
//
//  Created by Adam Paluszewski on 09/10/2022.
//

import UIKit
import WeatherKit

class PWHourForecastVC: UIViewController {
    
    @UsesAutoLayout var tableView = UITableView()
    let headerView = PWHourForecastHeaderView()
    
    var forecast: [HourWeather] = [] {
        didSet {
            let date = Date()
            self.forecast = forecast.filter{$0.date >= date}
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.preferredContentSize.height = self.tableView.contentSize.height
            }
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        
    }


    func configureViewController() {
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        headerView.segmentedControl.addTarget(self, action: #selector(hoursSegmentedControlValueChanged), for: .valueChanged)
        layoutUI()
    }
    
    
    func configureTableView() {
        tableView.register(PWHourForecastCell.self, forCellReuseIdentifier: PWHourForecastCell.cellid)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.sectionHeaderTopPadding = 0
        tableView.rowHeight = 55
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        tableView.allowsSelection = false
        tableView.prepareForDynamicHeight()
    }
    
    
    @objc func hoursSegmentedControlValueChanged() {
        tableView.reloadData()
        preferredContentSize.height = tableView.contentSize.height
    }
    
    
    func layoutUI() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
   
}


extension PWHourForecastVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows: Int!
        switch headerView.segmentedControl.selectedSegmentIndex {
            case 0:
                numberOfRows = 6
            case 1:
                numberOfRows = 12
            case 2:
                numberOfRows = 24
            default:
                numberOfRows = 0
        }
        return min(numberOfRows, forecast.count)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PWHourForecastCell.cellid, for: indexPath) as! PWHourForecastCell
        cell.set(weather: forecast[indexPath.row])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        85
    }

    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        !forecast.isEmpty ?  headerView : nil
    }
}
