//
//  PlaceView.swift
//  OpenWeather
//
//  Created by Pavel Stoma on 20.12.20.
//

import SwiftUI

struct PlaceView: View {
    @ObservedObject var locationManager: LocationManager
    
    var body: some View {
        if locationManager.locationsReady, let weather = locationManager.selectedWeather {
            VStack(spacing: -10) {
                Text(weather.name)
                    .font(.title)
                    .padding()
                Text("\(weather.temperature.celsiusValue)°C")
                    .font(.title2)
                    .padding()
                Text("Humidity: \(weather.main.humidity)%")
                    .padding()
                Text("Wind speed: \(String(format: "%.1f", weather.wind.speed))meter/sec")
                    .padding()
                Text("Cloudiness: \(weather.clouds.all)%")
                    .padding()
            }
        } else {
            ActivityIndicator(text: "Getting weather...")
        }
    }
}

struct PlaceView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceView(locationManager: LocationManager())
    }
}
