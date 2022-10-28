//
//  WeatherExt.swift
//  Pocket Weather
//
//  Created by Adam Paluszewski on 27/10/2022.
//

import Foundation
import WeatherKit


protocol WeatherProtocol {
    func symbolNameAndCondition() -> (symbol: String, condition: String)
}


extension CurrentWeather: WeatherProtocol {
    func symbolNameAndCondition() -> (symbol: String, condition: String) {
        return (symbol: self.symbolName, condition: self.condition.rawValue.codingKey.description)
    }
}


extension HourWeather: WeatherProtocol {
    func symbolNameAndCondition() -> (symbol: String, condition: String) {
        return (symbol: self.symbolName, condition: self.condition.rawValue.codingKey.description)
    }
}


extension DayWeather: WeatherProtocol {
    func symbolNameAndCondition() -> (symbol: String, condition: String) {
        return (symbol: self.symbolName, condition: self.condition.rawValue.codingKey.description)
    }
}
