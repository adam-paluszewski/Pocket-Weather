//
//  WeatherVC.swift
//  Pocket Weather
//
//  Created by Adam Paluszewski on 07/10/2022.
//

import UIKit
import WeatherKit
import CoreLocation

class WeatherVC: UIViewController {
    
    @UsesAutoLayout var scrollView = UIScrollView()
    @UsesAutoLayout var headerView = PWWeatherHeaderView()
    @UsesAutoLayout var segmentedControl = UISegmentedControl(items: ["Forecast", "Sun", "Moon"])
    @UsesAutoLayout var stackView = UIStackView()
    @UsesAutoLayout var hourForecastView = UIView()
    @UsesAutoLayout var dayForecastView = UIView()
    @UsesAutoLayout var sunView = UIView()
    
    var hourForecastViewHeightConstraint = NSLayoutConstraint()
    var dayForecastViewHeightConstraint = NSLayoutConstraint()
    
    let locationManager = CLLocationManager()
    
    var location = LocationData(lat: 0, lon: 0, city: "", country: "", weather: nil)
    
    init(location: LocationData) {
        super.init(nibName: nil, bundle: nil)
        self.location = location
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSegmentedControl()

        if location.lat == 0 {
            getLocation()
        } else {
            fetchWeather(for: CLLocation(latitude: location.lat, longitude: location.lon))
        }
        
    }
    
    
    func configureViewController() {
        UINavigationBarAppearance.setupNavBarAppearance(for: navigationController!.navigationBar)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = ""
        
        // TO-DO: move in other place
        view.backgroundColor = UIColor(patternImage: UIImage(named: "clear-bg")!)

        layoutUI()
    }
    
    
    func configureSegmentedControl() {
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
    }
    
    



    @objc func segmentedControlValueChanged() {
        switch segmentedControl.selectedSegmentIndex {
            case 0:
                hourForecastView.isHidden = false
                dayForecastView.isHidden = false
                sunView.isHidden = true
            case 1:
                hourForecastView.isHidden = true
                dayForecastView.isHidden = true
                sunView.isHidden = false
            case 2:
                hourForecastView.isHidden = true
                dayForecastView.isHidden = true
                sunView.isHidden = true
            default:
                print()
        }
        
    }
    
    
    func fetchWeather(for location: CLLocation) {
        WeatherManager.shared.fetchWeather(for: location) { result in
            switch result {
                case .success(let weather):
                    DispatchQueue.main.async {
                        self.location.weather = weather
                        PersistenceManager.shared.updateWith(location: self.location, actionType: .add) { error in
                            
                        }
                      
                        self.headerView.set(for: self.location, tabBar: self.tabBarController!.tabBar, navBar: self.navigationController!.navigationBar)
                        self.add(childVC: PWHourForecastVC(forecast: (self.location.weather!)), to: self.hourForecastView)
                        self.add(childVC: PWDayForecastVC(forecast: (self.location.weather!)), to: self.dayForecastView)
                    }
                    
                case .failure(let error):
                    print()
            }
        }
    }
    
    
    
    //after location request nothing happens, have to restart app to fetch data
    func getLocation() {
        if locationManager.authorizationStatus == .authorizedWhenInUse {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
            locationManager.startUpdatingLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }


    func stopUpdatingLocation() {
        locationManager.delegate = nil
        locationManager.stopUpdatingLocation()
    }
    
    
    override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
        let newHeight = container.preferredContentSize.height
        if let _ = container as? PWHourForecastVC {
            hourForecastViewHeightConstraint.isActive = false
            hourForecastViewHeightConstraint = hourForecastView.heightAnchor.constraint(equalToConstant: newHeight)
            hourForecastViewHeightConstraint.isActive = true
        } else if let _ = container as? PWDayForecastVC {
            dayForecastViewHeightConstraint.isActive = false
            dayForecastViewHeightConstraint = dayForecastView.heightAnchor.constraint(equalToConstant: newHeight)
            dayForecastViewHeightConstraint.isActive = true
        }
    }
    
    
    func configureStackView() {
        stackView.axis = .vertical
        stackView.spacing = 20
        hourForecastView.isHidden = false
        dayForecastView.isHidden = false
        sunView.isHidden = true
    }
    
    
    func layoutUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(headerView)
        scrollView.addSubview(segmentedControl)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(hourForecastView)
        stackView.addArrangedSubview(dayForecastView)
        stackView.addArrangedSubview(sunView)

        configureStackView()
        
        hourForecastView.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            headerView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            headerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            headerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -10),
            headerView.heightAnchor.constraint(equalToConstant: 170),
            headerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -20),
            
            segmentedControl.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            segmentedControl.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            segmentedControl.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -10),
            segmentedControl.heightAnchor.constraint(equalToConstant: 40),
            
            sunView.heightAnchor.constraint(equalToConstant: 10),

            stackView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
        ])
    }
}





extension WeatherVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.stopUpdatingLocation()
        
        let lat = locations[0].coordinate.latitude
        let lon = locations[0].coordinate.longitude
        
        location.lat = lat
        location.lon = lon
        
        let location = CLLocation(latitude: lat, longitude: lon)
        self.location.city = "Unknown city"
        self.location.country = "Unknown city"
        
        location.fetchCityAndCountry(location: location) { city, country, error in
            guard let city = city, let country = country, error == nil else { return }
            self.location.city = city
            self.location.country = country
        }
        print(location)
        fetchWeather(for: location)
        
    }
}
