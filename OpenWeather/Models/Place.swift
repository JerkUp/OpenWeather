//
//  Place.swift
//  OpenWeather
//
//  Created by Pavel Stoma on 20.12.20.
//

import Foundation

struct Place: Codable {
    let name: String
    let lat: Double
    let lon: Double
    let currentLocation: Bool
    
    init(name: String, lat: Double, lon: Double, currentLocation: Bool = false) {
        self.name = name
        self.lat = lat
        self.lon = lon
        self.currentLocation = currentLocation
    }
}
