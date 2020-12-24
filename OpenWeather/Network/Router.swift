//
//  Router.swift
//  OpenWeather
//
//  Created by Pavel Stoma on 21.12.20.
//

import Foundation

fileprivate struct ApiConfig {
    public static let ApiUrlString = "https://api.openweathermap.org/data/2.5/"
    public static let ApiKey = "0f057df2b7e0620c1a4ec432b1968f01"
}

enum Units: String {
    case apiDefault
    case imperial
    case metric
}

enum Router {
    case weather(place: Place)
    case hourlyForecast(place: Place)
    case forecast(place: Place)
    
    func url() -> URL? {
        let relativePath: String?
        
        switch self {
        case .weather:
            relativePath = "weather"
        case .hourlyForecast:
            relativePath = "forecast/hourly"
        case .forecast:
            relativePath = "forecast/daily"
        }
        
        guard var urlPath = URL(string: ApiConfig.ApiUrlString) else { return nil }
        
        if let path = relativePath {
            urlPath = urlPath.appendingPathComponent(path)
        }
        
        return urlPath
    }
    
    func toURLRequest(units: Units = .apiDefault) -> URLRequest? {
        guard let url = url() else {
            print("[Router] Wrong base URL")
            return nil
        }
        
        var params: [String: String] = [
            "appid" : ApiConfig.ApiKey
        ]
        
        if units != .apiDefault {
            params["units"] = units.rawValue
        }
        
        switch self {
        case .weather(let place),
             .hourlyForecast(let place),
             .forecast(let place):
            params["lat"] = String(format: "%.3f", place.lat)
            params["lon"] = String(format: "%.3f", place.lon)
        }
        
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        guard let requestUrl = urlComponents?.url else {
            print("[Router] Wrong URL \(ApiConfig.ApiUrlString) with params: \(params)")
            return nil
        }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        return request
    }
    
    
}
