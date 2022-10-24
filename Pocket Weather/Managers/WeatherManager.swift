//
//  WeatherManager.swift
//  Pocket Weather
//
//  Created by Adam Paluszewski on 09/10/2022.
//

import Foundation
import WeatherKit
import CoreLocation

class WeatherManager {
    static let shared = WeatherManager()
    
    let weatherService = WeatherService()
    
    func fetchWeather(for location: CLLocation, completion: @escaping (Result<Weather, PWError>) -> Void) {
        Task {
            do {
                let weather = try await weatherService.weather(for: location)
                completion(.success(weather))
            } catch {
                completion(.failure(PWError.unableToFetchWeather))
                print("Couldnt get weather data answer")
            }
            
        }
    }
    
}
