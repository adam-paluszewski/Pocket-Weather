//
//  SearchResultsVC.swift
//  Pocket Weather
//
//  Created by Adam Paluszewski on 13/10/2022.
//

import UIKit
import CoreLocation


protocol SearchResultsDelegate {
    func locationWasTapped(location: LocationData)
}


class SearchResultsVC: UIViewController {
    
    @UsesAutoLayout var containerView = UIView()
    @UsesAutoLayout var tableView = UITableView()
    
    var locationData: LocationData? {
        didSet {
            tableView.reloadDataOnMainThread()
        }
    }
    
    var isFetchingData = false {
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
        gradient.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 400)
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
        
        tableView.rowHeight = 100
        
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
            tableView.heightAnchor.constraint(equalToConstant: 100),
            
            containerView.topAnchor.constraint(equalTo: view.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: tableView.bottomAnchor),
        ])
    }
}


extension SearchResultsVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PWSearchResultCell.cellid, for: indexPath) as! PWSearchResultCell
        cell.set(isFetching: isFetchingData, city: locationData?.city)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if isFetchingData || locationData?.city == "Unknown city" {
            
        } else {
            let location = CLLocation(latitude: locationData!.lat, longitude: locationData!.lon)
            showLoadingView(in: containerView)
            WeatherManager.shared.fetchWeather(for: location) { result in
                switch result {
                    case .success(let weather):
                        self.delegate?.locationWasTapped(location: self.locationData!)
                        DispatchQueue.main.async {
                            self.dismiss(animated: true)
                            self.dismissLoadingView(in: self.containerView)
                        }
                    case .failure(let error):
                        print(error)
                }
            }
        }
    }
}
