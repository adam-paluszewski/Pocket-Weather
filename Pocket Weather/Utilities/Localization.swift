//
//  Localization.swift
//  Pocket Weather
//
//  Created by Adam Paluszewski on 24/10/2022.
//

import Foundation

struct Localization {
    static let clear = NSLocalizedString("Clear", comment: "")
    static let mostlyClear = NSLocalizedString("Mostly Clear", comment: "")
    static let mostlyCloudy = NSLocalizedString("Mostly Cloudy", comment: "")
    static let cloudy = NSLocalizedString("Cloudy", comment: "")
    static let partlyCloudy = NSLocalizedString("Partly Cloudy", comment: "")
    
    static let ok = NSLocalizedString("OK", comment: "")
    static let cancel = NSLocalizedString("Cancel", comment: "")
    static let add = NSLocalizedString("Add", comment: "")
    static let delete = NSLocalizedString("Delete", comment: "")
    
    static let fetchingWeather = NSLocalizedString("Checking weather...", comment: "")
    static let couldntGetWeather = NSLocalizedString("Couldn't get weather for this location. Please try again (relaunch app)", comment: "")
    static let error = NSLocalizedString("Error", comment: "")
    static let locationDisabled = NSLocalizedString("Location services are disabled. Change it in iOS settings if you want to see weather for current location.", comment: "")
    
    static let weather = NSLocalizedString("Weather", comment: "")
    static let locations = NSLocalizedString("Locations", comment: "")
    
    static let searchLocations = NSLocalizedString("Search for locations", comment: "")
    static let cityAlreadyOnList = NSLocalizedString("You already have this city on your list", comment: "")
    static let cantDeleteCurrentLocation = NSLocalizedString("You can't delete current location", comment: "")
    
    static let hourly = NSLocalizedString("Hourly", comment: "")
    static let daily = NSLocalizedString("Daily", comment: "")
}
