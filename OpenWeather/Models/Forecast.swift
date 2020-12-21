//
//  Forecast.swift
//  OpenWeather
//
//  Created by Pavel Stoma on 22.12.20.
//

import Foundation

struct Forecast: Codable {
    let list: [ForecastDetails]
}
