//
//  WeatherVC.swift
//  Pocket Weather
//
//  Created by Adam Paluszewski on 07/10/2022.
//

import UIKit
import WeatherKit
import CoreLocation


enum WeatherVCType {
    case myLocation, otherLocation, searchResult
}

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
    var weatherAssets: CurrentWeatherAssets!
    
    
    init(location: LocationData?, type: WeatherVCType) {
        super.init(nibName: nil, bundle: nil)
        self.location = location
        
        switch type {
            case .otherLocation:
                let rightButton = UIBarButtonItem(title: Localization.ok, style: .plain, target: self, action: #selector(barButtonTapped))
                navigationItem.rightBarButtonItem = rightButton
                
                print(location?.weather?.dailyForecast.forecast[2].symbolName.description)
                print(location?.weather?.dailyForecast.forecast[7].symbolName)
                print(location?.weather?.currentWeather.symbolName)
                print(location?.weather?.currentWeather.condition.description)
            case .searchResult:
                let leftButton = UIBarButtonItem(title: Localization.cancel, style: .plain, target: self, action: #selector(barButtonTapped))
                navigationItem.leftBarButtonItem = leftButton
                let rightButton = UIBarButtonItem(title: Localization.add, style: .plain, target: self, action: #selector(barButtonTapped))
                navigationItem.rightBarButtonItem = rightButton
            default:
                print()
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(sceneDidBecomeActive), name: UIScene.didActivateNotification, object: nil)
        configureViewController()
        addChildrenViewControllers()
        checkIfLocationIsSet()
    }
    
    
    func configureViewController() {
        UIHelper.addGradientAnimation(in: view)
        scrollView.delegate = self
        layoutUI()
    }
    
    
    func addChildrenViewControllers() {
        add(childVC: hourlyForecastVC, to: self.hourForecastView)
        add(childVC: dailyForecastVC, to: self.dayForecastView)
    }
    
    
    func checkIfLocationIsSet() {
        if location == nil {
            getLocation()
        } else {
            updateUI()
        }
    }
    
    
    @objc func sceneDidBecomeActive() {
        if let location {
            fetchWeather(for: location.coordinates)
        } else {
            getLocation()
        }
    }
    
    
    @objc func barButtonTapped(_ sender: UIBarButtonItem) {
        switch sender.title {
            case Localization.ok, Localization.cancel:
                dismiss(animated: true)
            case Localization.add:
                let name = Notification.Name("addToSavedLocationsList")
                NotificationCenter.default.post(name: name, object: location)
                dismiss(animated: true)
            default:
                print()
        }

    }
    
    
    func fetchWeather(for location: CLLocation) {
        headerView.fetchingWeatherLabel.text = Localization.fetchingWeather
        WeatherManager.shared.fetchWeather(for: location) { [weak self] result in
            guard let self else { return }
            switch result {
                case .success(let weather):
                    self.location.weather = weather
                    self.updateUI()
                    print("🟡 symbol \(self.location.weather!.currentWeather.symbolName) and condition: \(self.location.weather!.currentWeather.condition.description), clouds:  \(self.location.weather!.currentWeather.cloudCover.description)")
                case .failure(let error):
                    self.presentAlertOnMainThread(title: Localization.error, message: Localization.couldntGetWeather, buttonTitle: "OK", buttonColor: .systemRed, buttonSystemImage: .checkmark)
                    self.headerView.fetchingWeatherLabel.text = Localization.couldntGetWeather
                    self.dismissLoadingView(in: self.view)
            }
        }
    }
    
    
    func getLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
        switch locationManager.authorizationStatus {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .denied:
                headerView.fetchingWeatherLabel.text = Localization.locationDisabled
            case .authorizedWhenInUse:
                locationManager.startUpdatingLocation()
            default:
                print()
        }
    }
    
    
    func stopUpdatingLocation() {
        locationManager.delegate = nil
        locationManager.stopUpdatingLocation()
    }
    
    
    func updateUI() {
        DispatchQueue.main.async {
            self.weatherAssets = CurrentWeatherAssets(weather: self.location.weather)
            self.headerView.set(for: self.location)
            UIView.animate(withDuration: Constants.animationDuration) {
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
            
            headerView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.35),
            
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
        let authorizationStatus = manager.authorizationStatus
        if authorizationStatus == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        } else if authorizationStatus == .denied {
            headerView.fetchingWeatherLabel.text = Localization.locationDisabled
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
            PersistenceManager.shared.updateWith(location: self.location, actionType: .addMyLocation) { error in
                
            }
        }
        fetchWeather(for: coordinates)
    }
}


extension WeatherVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y

        headerView.animate(offset: offset)
        
        if offset > (view.safeAreaLayoutGuide.layoutFrame.height * 0.35) {
            navigationItem.titleView = PWNavBarTitleView(location: location)
            UINavigationBarAppearance.setupNavBarAppearance(for: navigationController!.navigationBar, color: weatherAssets.sectionColor)
        } else {
            navigationItem.titleView = nil
            UINavigationBarAppearance.setupNavBarAppearance(for: navigationController!.navigationBar, color: .clear)
        }
    }
}
