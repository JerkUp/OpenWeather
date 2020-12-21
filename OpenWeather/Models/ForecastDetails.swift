//
//  ForecastDetails.swift
//  OpenWeather
//
//  Created by Pavel Stoma on 22.12.20.
//

import Foundation

struct ForecastDetails: Codable {
    let dt: Double
    let main: Main
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    
    func date() -> Date {
        return Date(timeIntervalSince1970: dt)
    }
}
