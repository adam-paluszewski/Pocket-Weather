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
    
    @UsesAutoLayout var backgroundImageView = UIImageView()
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
    
    var location: LocationData!
    
    
    init(location: LocationData?) {
        super.init(nibName: nil, bundle: nil)
        self.location = location
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(sceneDidBecomeActive), name: UIScene.didActivateNotification, object: nil)
        configureViewController()
        configureSegmentedControl()
        checkIfLocationIsSet()
        
        segmentedControl.isHidden = true
    }
    
    
    func configureViewController() {
        UINavigationBarAppearance.setupNavBarAppearance(for: navigationController!.navigationBar)
        navigationItem.title = ""
        
        self.stackView.isHidden = true
        self.showLoadingView(in: view)
        layoutUI()
    }
    
    
    func configureSegmentedControl() {
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        segmentedControl.backgroundColor = UIColor(red: 32/255, green: 32/255, blue: 32/255, alpha: 0.35)
    }
    
    
    @objc func sceneDidBecomeActive() {
        removeChildren()
        stackView.isHidden = true
        showLoadingView(in: view)
        fetchWeather(for: location.coordinates)
    }
    
    
    func checkIfLocationIsSet() {
        if location == nil {
            getLocation()
        } else {
            fetchWeather(for: location.coordinates)
        }
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
        WeatherManager.shared.fetchWeather(for: location) { [weak self] result in
            guard let self else { return }
            switch result {
                case .success(let weather):
                    DispatchQueue.main.async {
                        self.location.weather = weather
                        PersistenceManager.shared.updateWith(location: self.location, actionType: .add) { error in
                            
                        }
                      
                        self.headerView.set(for: self.location, tabBar: self.tabBarController!.tabBar, navBar: self.navigationController!.navigationBar, bgView: self.backgroundImageView)
                        self.add(childVC: PWHourForecastVC(forecast: (self.location.weather!)), to: self.hourForecastView)
                        self.add(childVC: PWDayForecastVC(forecast: (self.location.weather!)), to: self.dayForecastView)
                        self.stackView.isHidden = false
                        self.dismissLoadingView(in: self.view)
                    }
                    
                case .failure(let error):
                    print()
            }
        }
    }
    
    
    
    //after location request nothing happens, have to restart app to fetch data
    func getLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        
        if locationManager.authorizationStatus == .authorizedWhenInUse {
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
        view.addSubview(backgroundImageView)
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(headerView)
        stackView.addArrangedSubview(segmentedControl)
        stackView.addArrangedSubview(hourForecastView)
        stackView.addArrangedSubview(dayForecastView)
        stackView.addArrangedSubview(sunView)

        configureStackView()
        
        hourForecastView.layer.cornerRadius = 10
        
        backgroundImageView.contentMode = .scaleAspectFill
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            headerView.heightAnchor.constraint(equalToConstant: 210),
            
            segmentedControl.heightAnchor.constraint(equalToConstant: 40),
            
            sunView.heightAnchor.constraint(equalToConstant: 10),

            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -20)
        ])
    }
}





extension WeatherVC: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.stopUpdatingLocation()
        
        let lat = locations[0].coordinate.latitude
        let lon = locations[0].coordinate.longitude
        
        location = LocationData(lat: lat, lon: lon)
        
        let coordinates = location.coordinates
        
        coordinates.fetchCityAndCountry(location: location.coordinates) { city, country, error in
            guard let city = city, let country = country, error == nil else { return }
            self.location.city = city
            self.location.country = country
        }
        fetchWeather(for: coordinates)
        
    }
}
