//
//  LocationExtensionForVc.swift
//  openweatherapp
//
//  Created by berat can beduk on 23.11.2022.
//

import Foundation
import CoreLocation
extension ViewController : CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationPermission()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    
        if let location = locations.first{
            
            let lat = location.coordinate.latitude
            let long = location.coordinate.longitude
            coreLocation.stopUpdatingLocation()
            getAddressFromLocation(withLocation: location)
            weatherManager.fetchWeather(lat: lat, lon: long)
        }
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        showAlert(withTitle: "Error", message: error.localizedDescription)
    }
}
