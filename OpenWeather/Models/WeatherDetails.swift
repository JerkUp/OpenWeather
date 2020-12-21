//
//  WeatherDetails.swift
//  OpenWeather
//
//  Created by Pavel Stoma on 22.12.20.
//

import Foundation

struct WeatherDetails: Codable {
    let weather: [Weather]
    let main: Main
    let visibility: Int?
    let wind: Wind
    let clouds: Clouds
    let id: Int
    let name: String
}
