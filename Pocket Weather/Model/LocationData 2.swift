//
//  LocationData.swift
//  Pocket Weather
//
//  Created by Adam Paluszewski on 13/10/2022.
//

import Foundation
import WeatherKit
import CoreLocation

struct LocationData: Codable, Equatable {
    
    var lat: Double = 0
    var lon: Double = 0
    
    var coordinates: CLLocation {
        CLLocation(latitude: lat, longitude: lon)
    }
    
    var city: String = "Unknown location"
    var country: String = "Unknown country"
    
    var weather: Weather?
    

}
