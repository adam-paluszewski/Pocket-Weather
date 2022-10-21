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
    
    var hourlyForecastVC = PWHourForecastVC()
    var dailyForecastVC = PWDayForecastVC()
    
    @UsesAutoLayout var scrollView = UIScrollView()
    @UsesAutoLayout var headerView = PWWeatherHeaderView()
    @UsesAutoLayout var stackView = UIStackView()
    @UsesAutoLayout var hourForecastView = UIView()
    @UsesAutoLayout var dayForecastView = UIView()
    
    var hourForecastViewHeightConstraint = NSLayoutConstraint()
    var dayForecastViewHeightConstraint = NSLayoutConstraint()
    
    let locationManager = CLLocationManager()
    let videoBackgroundManager = VideoBackgroundManager()
    
    var location: LocationData!
    var weatherAssets: WeatherAssets!
    
    var isInitialScreen = false
    
    
    init(location: LocationData?, isInitialScreen: Bool) {
        super.init(nibName: nil, bundle: nil)
        self.location = location
        
        if !isInitialScreen {
            let rightButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonTapped))
            navigationItem.rightBarButtonItem = rightButton
        }
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
        addChildrenViewControllers()
        checkIfLocationIsSet()
    }
    
    
    func configureViewController() {
//        view.backgroundColor = UIColor(patternImage: UIImage(named: "main-bg")!)
        UIHelper.addGradientAnimation(in: view)
        
        scrollView.delegate = self
        layoutUI()
    }
    
    
    func addChildrenViewControllers() {
        add(childVC: hourlyForecastVC, to: self.hourForecastView)
        add(childVC: dailyForecastVC, to: self.dayForecastView)
    }
    
    
    @objc func sceneDidBecomeActive() {
        if let location {
            fetchWeather(for: location.coordinates)
        }
    }
    
    
    func checkIfLocationIsSet() {
        if location == nil {
            getLocation()
        } else {
            updateUI()
        }
    }
    
    
    @objc func doneButtonTapped() {
        dismiss(animated: true)
    }
    
    
    func updateUI() {
        DispatchQueue.main.async {
            self.weatherAssets = WeatherAssets(symbol: self.location.weather?.currentWeather.symbolName, condition: self.location.weather?.currentWeather.condition.description)
            self.headerView.set(for: self.location)
            UIView.animate(withDuration: 2) {
                self.hourlyForecastVC.view.backgroundColor = self.weatherAssets.sectionColor
                self.dailyForecastVC.view.backgroundColor = self.weatherAssets.sectionColor
            }
            self.hourlyForecastVC.forecast = (self.location.weather?.hourlyForecast.forecast)!
            self.dailyForecastVC.forecast = (self.location.weather?.dailyForecast.forecast)!
            self.videoBackgroundManager.addPlayerLayer(in: self.view, with: self.weatherAssets.dynamicVerticalBgName)
            
            if let tabBar = self.tabBarController?.tabBar {
                UITabBarAppearance.setupTabBarAppearance(for: tabBar, backgroundColor: self.weatherAssets.sectionColor)
            }
        }
        
    }

    
    func fetchWeather(for location: CLLocation) {
        WeatherManager.shared.fetchWeather(for: location) { [weak self] result in
            guard let self else { return }
            switch result {
                case .success(let weather):
                    self.location.weather = weather
                    self.updateUI()
                    
                    print("symbol \(self.location.weather!.currentWeather.symbolName) and condition: \(self.location.weather!.currentWeather.condition.description), clouds:  \(self.location.weather!.currentWeather.cloudCover.description)")
                case .failure(let error):
                    print()
            }
        }
    }
    
    
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

    
    func layoutUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(headerView)
        stackView.addArrangedSubview(hourForecastView)
        stackView.addArrangedSubview(dayForecastView)

        stackView.axis = .vertical
        stackView.spacing = 10
        
        
        
        hourForecastViewHeightConstraint = hourForecastView.heightAnchor.constraint(equalToConstant: 660)
        dayForecastViewHeightConstraint = hourForecastView.heightAnchor.constraint(equalToConstant: 635)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            headerView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5),
            
            hourForecastViewHeightConstraint,
            

            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -15),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -15),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -30),
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


extension WeatherVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y

        headerView.animate(offset: offset)
        
        if offset > (view.safeAreaLayoutGuide.layoutFrame.height / 2) {
            navigationItem.titleView = PWNavBarTitleView(location: location)
            UINavigationBarAppearance.setupNavBarAppearance(for: navigationController!.navigationBar, color: weatherAssets.sectionColor)
        } else {
            navigationItem.titleView = nil
            UINavigationBarAppearance.setupNavBarAppearance(for: navigationController!.navigationBar, color: .clear)
        }
    }
}
