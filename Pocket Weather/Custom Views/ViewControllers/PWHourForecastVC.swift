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
    
    var forecast: [HourWeather] = []
    
    
    init(forecast: Weather) {
        super.init(nibName: nil, bundle: nil)
        let date = Date()
        self.forecast = forecast.hourlyForecast.forecast.filter{$0.date >= date}
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        preferredContentSize.height = tableView.contentSize.height
    }
    

    func configureViewController() {
        view.clipsToBounds = true
        headerView.segmentedControl.addTarget(self, action: #selector(hoursSegmentedControlValueChanged), for: .valueChanged)
        
        layoutUI()
    }
    
    
    func configureTableView() {
        tableView.register(PWHourForecastCell.self, forCellReuseIdentifier: PWHourForecastCell.cellid)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor(red: 32/255, green: 32/255, blue: 32/255, alpha: 0.15)
        tableView.layer.cornerRadius = 10
        tableView.sectionHeaderTopPadding = 0
        tableView.isScrollEnabled = false
        tableView.rowHeight = 55
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
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
        headerView.segmentedControl.selectedSegmentIndex == 0 ? 12 : 24
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
        return headerView
    }

}
