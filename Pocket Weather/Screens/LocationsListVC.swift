//
//  LocationsListVC.swift
//  Pocket Weather
//
//  Created by Adam Paluszewski on 13/10/2022.
//

import UIKit
import CoreLocation
import MapKit

class LocationsListVC: UIViewController {
    
    let searchResultsVC = SearchResultsVC()
    lazy var searchController = UISearchController(searchResultsController: searchResultsVC)
    @UsesAutoLayout var tableView = UITableView()
    
    let location = CLLocation()
    
    var locationsData: [LocationData] = []
    var searchCompleter = MKLocalSearchCompleter()
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
        configureTableView()
        addObservers()
        getLocationsList()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    
    @objc func sceneDidBecomeActive() {
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
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.title = Localization.locations
        navigationController?.navigationBar.prefersLargeTitles = true
        layoutUI()
    }
    

    func configureSearchController() {
        searchController.searchBar.placeholder = Localization.searchLocations
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.returnKeyType = .done
        searchResultsVC.delegate = self
        searchCompleter.delegate = self
    }
    
    
    func configureTableView() {
        tableView.backgroundColor = .clear
        tableView.register(PWCityCell.self, forCellReuseIdentifier: PWCityCell.cellId)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 145
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.prepareForDynamicHeight()
    }
    
    
    func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(sceneDidBecomeActive), name: UIScene.didActivateNotification, object: nil)
        
        let name = Notification.Name("addToSavedLocationsList")
        NotificationCenter.default.addObserver(self, selector: #selector(fireObserver), name: name, object: nil)
    }
    
    
    @objc func fireObserver(notification: NSNotification) {
        if let location = notification.object as? LocationData {
            if locationsData.contains{$0.city == location.city} {
                presentAlertOnMainThread(title: Localization.error, message: Localization.cityAlreadyOnList, buttonTitle: "OK", buttonColor: .red, buttonSystemImage: .checkmark)
            } else {
                var locationWithoutWeather = location
                locationWithoutWeather.weather = nil
                PersistenceManager.shared.updateWith(location: locationWithoutWeather, actionType: .add) { error in
                    locationsData.append(location)
                    tableView.reloadDataOnMainThread()
                }
            }
        }
    }
    
    
    func getLocationsList() {
        PersistenceManager.shared.retrieveLocations { result in
            switch result {
                case .success(let locations):
                    self.locationsData = locations
                    tableView.reloadDataOnMainThread()
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
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    
    func layoutUI() {
        view.addSubview(tableView)
        activateConstraints()
    }
}


extension LocationsListVC: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        searchCompleter.queryFragment = text
    }
    
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchController.showsSearchResultsController = true
        return true
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchResultsVC.results = []
    }
}


extension LocationsListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        locationsData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PWCityCell.cellId, for: indexPath) as! PWCityCell
        cell.set(for: locationsData[indexPath.row])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let weatherVC = WeatherVC(location: locationsData[indexPath.row], type: .otherLocation)
        weatherVC.isModalInPresentation = true
        let navController = UINavigationController(rootViewController: weatherVC)
        navigationController?.present(navController, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        if indexPath.row == 0 {
            let info = UIContextualAction(style: .normal, title: Localization.cantDeleteCurrentLocation) { action, view, handler in
                handler(false)
            }
            info.backgroundColor = .tertiarySystemBackground
            info.image = UIImage(systemName: "xmark.circle")
            return UISwipeActionsConfiguration(actions: [info])
            
        } else {
            let delete = UIContextualAction(style: .destructive, title: Localization.delete) { action, view, handler in
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
        DispatchQueue.main.async {
            self.searchController.searchBar.text = ""
            self.searchResultsVC.results = []
            
            let weatherVC = WeatherVC(location: location, type: .searchResult)
            weatherVC.isModalInPresentation = true
            let navController = UINavigationController(rootViewController: weatherVC)
            self.navigationController?.present(navController, animated: true)
        }
    }
}


extension LocationsListVC: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        completer.resultTypes = .address
        let citiesList = CitiesList.getCityList(results: completer.results)
        searchResultsVC.results = Array(Set(citiesList))
    }
}

