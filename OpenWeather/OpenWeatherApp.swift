//
//  OpenWeatherApp.swift
//  OpenWeather
//
//  Created by Pavel Stoma on 20.12.20.
//

import SwiftUI

@main
struct OpenWeatherApp: App {
    var body: some Scene {
        WindowGroup {
            PlaceView(locationManager: LocationManager())
        }
    }
}
