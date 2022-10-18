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
    @UsesAutoLayout var stackView = UIStackView()
    @UsesAutoLayout var hourForecastView = UIView()
    @UsesAutoLayout var dayForecastView = UIView()
    
    var headerViewHeightAnchor = NSLayoutConstraint()
    var hourForecastViewHeightConstraint = NSLayoutConstraint()
    var dayForecastViewHeightConstraint = NSLayoutConstraint()
    
    let locationManager = CLLocationManager()
    
    var location: LocationData!
    
    
    init(location: LocationData?, showNavButton: Bool = false) {
        super.init(nibName: nil, bundle: nil)
        self.location = location
        
        if showNavButton {
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
//        NotificationCenter.default.addObserver(self, selector: #selector(sceneDidBecomeActive), name: UIScene.didActivateNotification, object: nil)
        configureViewController()
        checkIfLocationIsSet()
    }
    
    
    func configureViewController() {
//        self.showLoadingView(in: view)
//        UINavigationBarAppearance.setupNavBarAppearance(for: navigationController!.navigationBar, color: .systemCyan)
        scrollView.delegate = self
        
        layoutUI()
    }
    
    
    @objc func sceneDidBecomeActive() {
        removeChildren()
        showLoadingView(in: view)
        if let location {
            fetchWeather(for: location.coordinates)
        }
    }
    
    
    func checkIfLocationIsSet() {
        if location == nil {
            getLocation()
        } else {
            fetchWeather(for: location.coordinates)
        }
    }
    
    
    @objc func doneButtonTapped() {
        dismiss(animated: true)
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
                      
                        self.headerView.set(for: self.location)
                        self.add(childVC: PWHourForecastVC(forecast: (self.location.weather!)), to: self.hourForecastView)
                        self.add(childVC: PWDayForecastVC(forecast: (self.location.weather!)), to: self.dayForecastView)
//                        self.dismissLoadingView(in: self.view)
                        
                        let colorsAndImages = UIHelper.getImagesAndColors(for: weather.currentWeather.symbolName)
                        self.view.backgroundColor = UIColor(patternImage: colorsAndImages.backgroundImage)
                    }
                    
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
            hourForecastViewHeightConstraint = hourForecastView.heightAnchor.constraint(equalToConstant: newHeight)
            hourForecastViewHeightConstraint.isActive = true
        } else if let _ = container as? PWDayForecastVC {
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
        stackView.spacing = 20
        
        hourForecastView.layer.cornerRadius = 10
        
        headerViewHeightAnchor = headerView.heightAnchor.constraint(equalToConstant: 210)
        headerViewHeightAnchor.isActive = true
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
//            headerView.heightAnchor.constraint(equalToConstant: 210),

            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 15),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -20),
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
        
        let window = UIApplication.shared.windows.first
        let topPadding = window?.safeAreaInsets.top ?? 0
        let navBarHeight = navigationController?.navigationBar.frame.height ?? 0
        
        var offset: CGFloat = 0
        
        if self.isModalInPresentation {
            offset = scrollView.contentOffset.y + navBarHeight
        } else {
            offset = scrollView.contentOffset.y + topPadding
        }

        
        headerViewHeightAnchor.isActive = false
        headerViewHeightAnchor = headerView.heightAnchor.constraint(equalToConstant: max(0, 210 - offset * 1.4))
        headerViewHeightAnchor.isActive = true
        
        headerView.scale(offset: offset)
        
        
        
        if offset > 80 {
            navigationController?.setNavigationBarHidden(false, animated: true)
            navigationItem.title = nil
            navigationItem.titleView = PWNavBarTitleView(location: location)
            UINavigationBarAppearance.setupNavBarAppearance(for: navigationController!.navigationBar, color: .clear)
        } else {
            navigationItem.title = " "
            navigationItem.titleView = nil
            UINavigationBarAppearance.setupNavBarAppearance(for: navigationController!.navigationBar, color: .clear, transparentBackground: true)
            if !self.isModalInPresentation {
                navigationController?.setNavigationBarHidden(true, animated: true)
            }
           
        }
        
        
    }
}
