//
//  SearchResultsVC.swift
//  Pocket Weather
//
//  Created by Adam Paluszewski on 13/10/2022.
//

import UIKit
import CoreLocation
import MapKit



protocol SearchResultsDelegate {
    func locationWasTapped(location: LocationData)
}


class SearchResultsVC: UIViewController {
    
    @UsesAutoLayout var containerView = UIView()
    @UsesAutoLayout var tableView = UITableView()
    
    var results: [SearchResult] = [] {
        didSet {
            tableView.reloadDataOnMainThread()
        }
    }
    
    var delegate: SearchResultsDelegate?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        gradient.colors = [UIColor(red: 53/255, green: 92/255, blue: 125/255, alpha: 1).cgColor,
                           UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1).cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)

        containerView.layer.insertSublayer(gradient, at: 0)
    }
    
    
    func configureViewController() {
        view.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.8)
        layoutUI()
    }
    
    
    func configureTableView() {
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 55
        tableView.register(PWSearchResultCell.self, forCellReuseIdentifier: PWSearchResultCell.cellid)
    }
    
    
    func layoutUI() {
        view.addSubview(containerView)
        containerView.addSubview(tableView)
        
        containerView.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            containerView.topAnchor.constraint(equalTo: view.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: tableView.bottomAnchor),
        ])
    }
}


extension SearchResultsVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PWSearchResultCell.cellid, for: indexPath) as! PWSearchResultCell
        let result = results[indexPath.row]
        cell.set(city: result.city, country: result.country)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        showLoadingView(in: view)
        
        var location = LocationData()
        location.city = results[indexPath.row].city
        location.country = results[indexPath.row].country
        
        location.coordinates.fetchCoordinates(city: results[indexPath.row].city) { coordinate, error in
            guard let coordinate = coordinate else { return }
            location.lat = coordinate.latitude
            location.lon = coordinate.longitude
            
            WeatherManager.shared.fetchWeather(for: location.coordinates) { result in
                switch result {
                    case .success(let weather):
                        location.weather = weather
                        self.delegate?.locationWasTapped(location: location)
                        DispatchQueue.main.async {
                            self.dismissLoadingView(in: self.view)
                            self.dismiss(animated: true)
                        }
                    case .failure(let error):
                        print(error)
                }
            }
        }
    }
}


