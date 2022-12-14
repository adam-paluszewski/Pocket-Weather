//
//  UITabBarAppearanceExt.swift
//  Pocket Weather
//
//  Created by Adam Paluszewski on 18/10/2022.
//

import UIKit

extension UITabBarAppearance {
    
    static func setupTabBarAppearance(for tabBar: UITabBar, backgroundColor: UIColor = UIColor(red: 102/255, green: 198/255, blue: 255/255, alpha: 0.65)) {
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = backgroundColor
        
        //iOS13+
        appearance.stackedLayoutAppearance.selected.iconColor = .label
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.label]
        
        appearance.stackedLayoutAppearance.normal.iconColor = .secondaryLabel
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel]
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    
    }
}
