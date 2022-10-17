//
//  PWDayForecastVC.swift
//  Pocket Weather
//
//  Created by Adam Paluszewski on 12/10/2022.
//

import UIKit
import WeatherKit

class PWDayForecastVC: UIViewController {

    @UsesAutoLayout var tableView = UITableView()
    let headerView = PWDayForecastHeaderView()
    
    var forecast: [DayWeather] = []
    
    
    init(forecast: Weather) {
        super.init(nibName: nil, bundle: nil)
        self.forecast = forecast.dailyForecast.forecast

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
        headerView.segmentedControl.addTarget(self, action: #selector(daysSegmentedControlValueChanged), for: .valueChanged)
        
        layoutUI()
    }
    
    
    func configureTableView() {
        tableView.register(PWDayForecastCell.self, forCellReuseIdentifier: PWDayForecastCell.cellid)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor(red: 38/255, green: 138/255, blue: 188/255, alpha: 0.35)
        tableView.layer.cornerRadius = 10
        tableView.sectionHeaderTopPadding = 0
        tableView.isScrollEnabled = false
        tableView.rowHeight = 55
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        tableView.prepareForDynamicHeight()
    }
    
    
    @objc func daysSegmentedControlValueChanged() {
        tableView.reloadData()
        preferredContentSize.height = tableView.contentSize.height
    }
    
    
    func layoutUI() {
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
   
}

extension PWDayForecastVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        headerView.segmentedControl.selectedSegmentIndex == 0 ? 5 : 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PWDayForecastCell.cellid, for: indexPath) as! PWDayForecastCell
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
