//
//  AutoLayoutWrapper.swift
//  Pocket Weather
//
//  Created by Adam Paluszewski on 10/10/2022.
//

import UIKit

@propertyWrapper
struct UsesAutoLayout<T: UIView> {
    
    var wrappedValue: T
    
    
    init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
        wrappedValue.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func setTranslatesAutoresizingMaskIntoConstraints() {
        wrappedValue.translatesAutoresizingMaskIntoConstraints = false
    }
}
