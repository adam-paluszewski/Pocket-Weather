//
//  UINavigationBarAppearanceExt.swift
//  Pocket Weather
//
//  Created by Adam Paluszewski on 13/10/2022.
//

import UIKit

extension UINavigationBarAppearance {
    
    static func setupNavBarAppearance(for navBar: UINavigationBar, color: UIColor = UIColor(red: 0/255, green: 76/255, blue: 153/255, alpha: 0.65)) {
//        UINavigationBar.appearance().tintColor = UIColor(named: "FNNavigationTint")
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = color
        navBar.standardAppearance = appearance
//        navBar.scrollEdgeAppearance = appearance
//        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        navBar.layer.shadowColor = UIColor.black.cgColor
        navBar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        navBar.layer.shadowRadius = 2.0
        navBar.layer.shadowOpacity = 0.4
        navBar.layer.masksToBounds = false
    }
}
