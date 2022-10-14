//
//  PWError.swift
//  Pocket Weather
//
//  Created by Adam Paluszewski on 14/10/2022.
//

import Foundation

enum PWError: String, Error {
    case unableToSaveLocation = "UNable to save location"
    case unableToRetrieveLocations = "Unable to retrieve locations"
    case unableToUpdateLocations = "Unable to update locations"
    
    case locationAlreadySaved = "You have this location on your list. Can't add it again."
    
    case unableToFetchWeather = "We couldn't get weather for this locations. Please try again."
}
