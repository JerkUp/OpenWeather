//
//  Place.swift
//  OpenWeather
//
//  Created by Pavel Stoma on 20.12.20.
//

import Foundation

class Place: Codable {
    let name: String
    let lat: Double
    let lon: Double
    
    init(name: String, lat: Double, lon: Double) {
        self.name = name
        self.lat = lat
        self.lon = lon
    }
}
