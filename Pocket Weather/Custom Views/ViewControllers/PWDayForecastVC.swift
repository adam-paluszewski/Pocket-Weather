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
    
    var forecast: [DayWeather] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.preferredContentSize.height = self.tableView.contentSize.height
            }
        }
    }
    
    
//    init(forecast: Weather) {
//        super.init(nibName: nil, bundle: nil)
//        self.forecast = forecast.dailyForecast.forecast
//        self.weatherSymbol = forecast.currentWeather.symbolName
//    }
//
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        preferredContentSize.height = tableView.contentSize.height
    }
    

    func configureViewController() {
        view.clipsToBounds = true
        view.backgroundColor = UIColor(red: 71/255, green: 139/255, blue: 174/255, alpha: 0.65)
//        view.backgroundColor = UIHelper.getImagesAndColors(for: weatherSymbol).sectionColor
        view.layer.cornerRadius = 20
        
        layoutUI()
    }
    
    
    func configureTableView() {
        tableView.register(PWDayForecastCell.self, forCellReuseIdentifier: PWDayForecastCell.cellid)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.sectionHeaderTopPadding = 0
        tableView.rowHeight = 55
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        tableView.isUserInteractionEnabled = false
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
        forecast.count
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
        return !forecast.isEmpty ? headerView : nil
    }


}
