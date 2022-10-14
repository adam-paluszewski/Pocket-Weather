//
//  PersistenceManager.swift
//  Pocket Weather
//
//  Created by Adam Paluszewski on 14/10/2022.
//

import Foundation

enum PersistanceActionType {
    case add, remove
}

struct PersistenceManager {
 
    static let shared = PersistenceManager()
    private let defaults = UserDefaults.standard
    
    
    func saveLocations(_ locations: [LocationData]) -> PWError? {
        do {
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(locations)
            defaults.set(encodedData, forKey: "SavedLocations")
        }
        catch {
            return PWError.unableToSaveLocation
        }
        return nil
    }
    
    
    func retrieveLocations(completionHandler: (Result<[LocationData],PWError>) -> Void) {
        guard let locationsData = defaults.object(forKey: "SavedLocations") as? Data else {
            completionHandler(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let locations = try decoder.decode([LocationData].self, from: locationsData)
            completionHandler(.success(locations))
        }
        catch {
            completionHandler(.failure(PWError.unableToRetrieveLocations))
        }
    }
    
    
    func updateWith(location: LocationData, actionType: PersistanceActionType, completionHandler: (PWError?) -> Void) {
        retrieveLocations { result in
            switch result {
                case .success(var locations):
                    switch actionType {
                        case .add:
                            var filteredLocations: [String] = [] //objects have different date so they are always different, cant check 'contains'
                            for location in locations {
                                filteredLocations.append(location.city)
                            }
                            
                            guard !filteredLocations.contains(location.city) else {
                                completionHandler(PWError.locationAlreadySaved)
                                return
                            }
                            locations.append(location)
                        case .remove:
                            locations.removeAll {$0.city == location.city}
                    }
                    completionHandler(saveLocations(locations))
                    
                case .failure(let error):
                    completionHandler(error)
            }
        }
    }
}
