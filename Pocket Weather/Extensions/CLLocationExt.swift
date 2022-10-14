//
//  CLLocationExt.swift
//  Pocket Weather
//
//  Created by Adam Paluszewski on 07/10/2022.
//

import CoreLocation


extension CLLocation {
    
    func fetchCityAndCountry(location: CLLocation, completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { completion($0?.first?.locality, $0?.first?.country, $1) }
    }
    
    
    func fetchCoordinates(city: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> () ) {
        CLGeocoder().geocodeAddressString(city) { completion($0?.first?.location?.coordinate, $1) }
    }
}
