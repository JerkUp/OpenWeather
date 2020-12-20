//
//  ActivityIndicator.swift
//  OpenWeather
//
//  Created by Pavel Stoma on 20.12.20.
//

import SwiftUI

struct ActivityIndicator: View {
    var text = "Loading..."
    
    init(text:String ) {
        self.text = text
    }
    var body: some View {
        VStack(content: {
            ProgressView(self.text)
        })
    }
}

struct ActivityIndicator_Previews: PreviewProvider {
    static var previews: some View {
        ActivityIndicator(text: "Getting your geolocation...")
    }
}
