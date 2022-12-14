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
        
        let appearance = UITabBarAppearance()
        //iOS13+
        appearance.stackedLayoutAppearance.selected.iconColor = .label
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.label]
        
        appearance.stackedLayoutAppearance.normal.iconColor = .secondaryLabel
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel]
        
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
    

    func createMainNC() -> UINavigationController {
        let mainVC = WeatherVC(location: nil, type: .myLocation)
        mainVC.tabBarItem = UITabBarItem(title: Localization.weather, image: UIImage(systemName: "cloud.sun"), selectedImage: UIImage(systemName: "cloud.sun.fill"))
        mainVC.tabBarItem.tag = 0
        return UINavigationController(rootViewController: mainVC)
    }
    
    
    func createLocationsListNC() -> UINavigationController {
        let locationsVC = LocationsListVC()
        locationsVC.tabBarItem = UITabBarItem(title: Localization.locations, image: UIImage(systemName: "map"), selectedImage: UIImage(systemName: "map.fill"))
        locationsVC.tabBarItem.tag = 1
        
        return UINavigationController(rootViewController: locationsVC)
    }
}
