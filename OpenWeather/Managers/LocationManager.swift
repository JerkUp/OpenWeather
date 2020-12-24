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
    private var placeWeather: [String: WeatherDetails] = [:]
    
    var selectedWeather: WeatherDetails? {
        // TODO: - get selected place weather
        return placeWeather.first?.value
    }
    
    override init() {
        super.init()
        
        restorePlaces()
        
        locationManager.delegate = self
        locationAuthorised = locationManager.authorizationStatus == .authorizedWhenInUse
        
        if !locationAuthorised {
            locationManager.requestWhenInUseAuthorization()
        } else {
            locationManager.startUpdatingLocation()
        }
    }
    
    private func addPlace(place: Place, replaceCurrent: Bool = false) {
        if replaceCurrent, let firstIndex = places.firstIndex(where: { $0.currentLocation }) {
            places.remove(at: firstIndex)
        }
        
        places.append(place)
        savePlaces()
        updatePlacesWeather()
    }
    
    private func reverse(location: CLLocation) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            guard let placemark = placemarks?.first else { return }
            
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            let name = placemark.locality ?? placemark.name ?? String(format: "%.3f:%.3f", lat, lon)
            let place = Place(name: name, lat: lat, lon: lon, currentLocation: true)
            
            self.addPlace(place: place, replaceCurrent: true)
            
            self.locationManager.stopUpdatingLocation()
        }
    }
    
    private func updatePlacesWeather() {
        var parsedWeather: [String: WeatherDetails] = [:]
        
        places.forEach { (place) in
            guard let request = Router.weather(place: place).toURLRequest() else { return }
            
            RequestManager.request(request) { [weak self] (weather: WeatherDetails?, error) in
                guard let self = self else { return }
                
                if let error = error {
                    print("[LocationManager] error getting weather for place \(place.name): \(error)")
                    self.locationsReady = true
                    return
                }
                
                if let plWeather = weather {
                    parsedWeather[place.name] = plWeather
                }
                
                if parsedWeather.count == self.places.count {
                    self.placeWeather = parsedWeather
                    self.locationsReady = true
                }
            }
        }
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
            locationManager.startUpdatingLocation()
        } else if places.count == 0 {
            let defaultPlace = Place(name: "Riga", lat: 56.949, lon: 24.106, currentLocation: true)
            addPlace(place: defaultPlace, replaceCurrent: true)
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

// Save / restore saved locations
extension LocationManager {
    private func restorePlaces() {
        if let savedPlacesData = UserDefaults.standard.object(forKey: "places") as? Data {
            let decoder = JSONDecoder()
            
            if let savedPlaces = try? decoder.decode([Place].self, from: savedPlacesData) {
                places = savedPlaces
            }
        }
    }
    
    private func savePlaces() {
        let encoder = JSONEncoder()
        
        if let encoded = try? encoder.encode(places) {
            UserDefaults.standard.set(encoded, forKey: "places")
        }
        
    }
}
