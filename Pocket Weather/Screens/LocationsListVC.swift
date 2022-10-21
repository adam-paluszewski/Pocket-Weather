//
//  LocationsListVC.swift
//  Pocket Weather
//
//  Created by Adam Paluszewski on 13/10/2022.
//

import UIKit
import CoreLocation

class LocationsListVC: UIViewController {
    
    let searchResultsVC = SearchResultsVC()
    lazy var searchController = UISearchController(searchResultsController: searchResultsVC)
    @UsesAutoLayout var tableView = UITableView()
    let location = CLLocation()
    
    var locationsData: [LocationData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
        configureTableView()
        
        
        PersistenceManager.shared.retrieveLocations { result in
            switch result {
                case .success(let locations):
                    self.locationsData = locations
                    self.tableView.reloadDataOnMainThread()
                    
                    
                    
//                    self.tableView.reloadDataOnMainThread()
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        for locationData in locationsData.enumerated() {
            WeatherManager.shared.fetchWeather(for: locationData.element.coordinates) { result in
                switch result {
                    case .success(let weather):
                        self.locationsData[locationData.offset].weather = weather
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadRows(at: [IndexPath(row: locationData.offset, section: 0)], with: .fade)
                        }
                        
                    case .failure(let error):
                        print()
                }
            }
        }
    }
    

    func configureViewController() {
        navigationItem.title = "Locations"
        navigationController?.navigationBar.prefersLargeTitles = true
        layoutUI()

        
        let gradient = CAGradientLayer()
        gradient.frame = view.frame
        gradient.colors = [UIColor(red: 53/255, green: 92/255, blue: 125/255, alpha: 1).cgColor,
                           UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1).cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)

        view.layer.insertSublayer(gradient, at: 0)

    }

    
    func configureSearchController() {
        searchController.searchBar.placeholder = "Add more locations"
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.returnKeyType = .done
        searchResultsVC.delegate = self
    }
    
    
    func configureTableView() {
        tableView.backgroundColor = .clear
        tableView.register(PWCityCell.self, forCellReuseIdentifier: PWCityCell.cellId)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 145
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
    }
    
    
    func layoutUI() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
    }
}


extension LocationsListVC: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        searchResultsVC.isFetchingData = true
        location.fetchCoordinates(city: searchController.searchBar.text!, completion: { coordinate, error in
            let location = CLLocation(latitude: coordinate?.latitude ?? 0, longitude: coordinate?.longitude ?? 0)
            location.fetchCityAndCountry(location: location, completion: { city, country, error in
                self.searchResultsVC.locationData = LocationData(lat: location.coordinate.latitude, lon: location.coordinate.longitude, city: city ?? "Unknown city", country: country ?? "Unknown country", weather: nil)
                self.searchResultsVC.isFetchingData = false
            })
        })
    }
    
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchController.showsSearchResultsController = true
        return true
    }
    
    
}


extension LocationsListVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        locationsData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PWCityCell.cellId, for: indexPath) as! PWCityCell
//        cell.set(for: locationsData[indexPath.row])
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let weatherVC = WeatherVC(location: locationsData[indexPath.row], isInitialScreen: false)
        weatherVC.isModalInPresentation = true
        let navController = UINavigationController(rootViewController: weatherVC)
        navigationController?.present(navController, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        if indexPath.row == 0 {
            let info = UIContextualAction(style: .normal, title: "You can't delete current location") { action, view, handler in
                handler(false)
            }
            info.backgroundColor = .tertiarySystemBackground
            info.image = UIImage(systemName: "xmark.circle")
            return UISwipeActionsConfiguration(actions: [info])
            
        } else {
            let delete = UIContextualAction(style: .destructive, title: "Delete") { action, view, handler in
                let location = self.locationsData[indexPath.row]
                PersistenceManager.shared.updateWith(location: location, actionType: .remove) { error in
                    if let error = error {
                        print(error)
                    } else {
                        self.locationsData.remove(at: indexPath.row)
                        tableView.deleteRows(at: [indexPath], with: .left)
                        handler(true)
                    }
                }
            }
            delete.backgroundColor = .systemRed
            delete.image = UIImage(systemName: "trash")!

            let actions = UISwipeActionsConfiguration(actions: [delete])
            actions.performsFirstActionWithFullSwipe = true

            return actions
        }
    }
}


extension LocationsListVC: SearchResultsDelegate {
    func locationWasTapped(location: LocationData) {
        PersistenceManager.shared.updateWith(location: location, actionType: .add) { error in
            if let error = error {
                self.presentAlertOnMainThread(title: "Error", message: error.rawValue, buttonTitle: "OK", buttonColor: .systemRed, buttonSystemImage: UIImage(systemName: "x.circle")!)
            } else {
                locationsData.append(location)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.searchController.searchBar.text = ""
                }
                
            }
            
        }
    }
    
    
}
