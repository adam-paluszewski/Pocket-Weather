//
//  PWTabBarController.swift
//  Pocket Weather
//
//  Created by Adam Paluszewski on 07/10/2022.
//

import UIKit

class PWTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

        viewControllers = [createMainNC(), createLocationsListNC()]
        
        UITabBarAppearance.setupTabBarAppearance(for: self.tabBar)
    }
    

    func createMainNC() -> UINavigationController {
        let mainVC = WeatherVC(location: LocationData(lat: 0, lon: 0, city: "", country: "", weather: nil))
        mainVC.tabBarItem = UITabBarItem(title: "Weather", image: UIImage(systemName: "sun.max"), selectedImage: UIImage(systemName: "sun.max"))
        mainVC.tabBarItem.tag = 0
        return UINavigationController(rootViewController: mainVC)
    }
    
    
    func createLocationsListNC() -> UINavigationController {
        let locationsVC = LocationsListVC()
        locationsVC.tabBarItem = UITabBarItem(title: "Locations", image: UIImage(systemName: "map"), selectedImage: UIImage(systemName: "map.fill"))
        locationsVC.tabBarItem.tag = 1
        
        return UINavigationController(rootViewController: locationsVC)
    }
}
