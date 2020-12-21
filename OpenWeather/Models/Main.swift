//
//  Main.swift
//  OpenWeather
//
//  Created by Pavel Stoma on 22.12.20.
//

import Foundation

struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double?
    let temp_max: Double?
    let sea_level: Double?
    let grnd_level: Double?
    let temp_kf: Double?
    let pressure: Int
    let humidity: Int
}
