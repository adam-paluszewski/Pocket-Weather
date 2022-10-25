//
//  CitiesList.swift
//  Pocket Weather
//
//  Created by Adam Paluszewski on 25/10/2022.
//

import Foundation
import MapKit


struct CitiesList {
    
    static func getCityList(results: [MKLocalSearchCompletion]) -> [SearchResult]{
        var searchResults: [SearchResult] = []
        
        for result in results {
            let titleComponents = result.title.components(separatedBy: ", ")
            let subtitleComponents = result.subtitle.components(separatedBy: ", ")
            
            buildCityTypeA(titleComponents, subtitleComponents){place in
                if place.city != "" && place.country != ""{
                    searchResults.append(SearchResult(city: place.city, country: place.country))
                }
            }
    
            buildCityTypeB(titleComponents, subtitleComponents){place in
                if place.city != "" && place.country != ""{
                    searchResults.append(SearchResult(city: place.city, country: place.country))
                }
            }
        }
        return searchResults
    }
    
    
    static private func buildCityTypeA(_ title: [String],_ subtitle: [String], _ completion: @escaping ((city: String, country: String)) -> Void){
        var city: String = ""
        var country: String = ""
        
        if title.count > 1 && subtitle.count >= 1 {
            city = title.first!
            country = subtitle.count == 1 && subtitle[0] != "" ? subtitle.first! : title.last!
        }
        completion((city, country))
    }

    static private func buildCityTypeB(_ title: [String],_ subtitle: [String], _ completion: @escaping ((city: String, country: String)) -> Void){
        var city: String = ""
        var country: String = ""
        
        if title.count >= 1 && subtitle.count == 1 {
            city = title.first!
            country = subtitle.last!
        }
        completion((city, country))
    }
}
