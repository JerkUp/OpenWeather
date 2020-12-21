//
//  Weather.swift
//  OpenWeather
//
//  Created by Pavel Stoma on 22.12.20.
//

import Foundation

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
