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
        if locationManager.locationsReady {
            VStack(spacing: -10) {
                Text("Hello, world!")
                    .padding()
                Text("Hello, world!")
                    .padding()
                Text("Hello, world!")
                    .padding()
                Text("Hello, world!")
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
