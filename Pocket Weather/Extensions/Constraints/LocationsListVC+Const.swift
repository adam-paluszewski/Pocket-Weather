//
//  LocationsListVCConst.swift
//  Pocket Weather
//
//  Created by Adam Paluszewski on 28/10/2022.
//

import UIKit


extension LocationsListVC {
    
    func activateConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
