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
//        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}
