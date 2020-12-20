//
//  LocationManager.swift
//  OpenWeather
//
//  Created by Pavel Stoma on 20.12.20.
//

import UIKit
import MapKit

class LocationManager: NSObject, ObservableObject {
    @Published var locationsReady: Bool = false
    
    private var locationAuthorised: Bool = false
    private let locationManager = CLLocationManager()
    var places: [Place] = []
    
    override init() {
        super.init()
        
        locationManager.delegate = self
        locationAuthorised = locationManager.authorizationStatus == .authorizedWhenInUse
        
        if !locationAuthorised {
            locationManager.requestWhenInUseAuthorization()
        }
        
        locationManager.startUpdatingLocation()
    }
    
    private func addPlace(place: Place) {
        places.append(place)
        
        updatePlacesWeather()
    }
    
    private func reverse(location: CLLocation) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            guard let placemark = placemarks?.first else { return }
            
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            let name = placemark.locality ?? placemark.name ?? String(format: "%.3f:%.3f", lat, lon)
            let place = Place(name: name, lat: lat, lon: lon)
            
            if !self.places.contains(where: { $0.name == place.name }) {
                self.addPlace(place: place)
            }
        }
    }
    
    private func updatePlacesWeather() {
        // TODO: - Update Location
        locationsReady = true
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        reverse(location: location)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        locationAuthorised = locationManager.authorizationStatus == .authorizedWhenInUse
        
        if locationAuthorised {
            locationManager.requestWhenInUseAuthorization()
        } else if places.count == 0 {
            let defaultPlace = Place(name: "Riga", lat: 56.949, lon: 24.106)
            addPlace(place: defaultPlace)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        guard let clError = error as? CLError, clError.code != .denied else {
            print("[LocationManager] Error: \(error)")
            return
        }
        
        locationManager.stopMonitoringSignificantLocationChanges()
    }
}
