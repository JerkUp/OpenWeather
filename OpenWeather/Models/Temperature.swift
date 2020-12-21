//
//  MeasureUnit.swift
//  OpenWeather
//
//  Created by Pavel Stoma on 22.12.20.
//

import Foundation

struct Temperature: Codable {
    var value: Double
    
    var kelvinValue: Int {
        return Int(value)
    }
    
    var celsiusValue: Int {
        return Int(value - 273.15)
    }
    
    var farengheitValue: Int {
        return Int((value * 9 / 5) - 459.67)
    }
}
