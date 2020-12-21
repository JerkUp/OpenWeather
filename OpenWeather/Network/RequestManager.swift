//
//  RequestManager.swift
//  OpenWeather
//
//  Created by Pavel Stoma on 21.12.20.
//

import Foundation

public class RequestManager {
    static public func request<T: Codable>(_ urlRequest: URLRequest,
                               requiresAuthorization: Bool,
                               completionHandler: @escaping (T?, String?) -> Void) -> Void {
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completionHandler(nil, error.localizedDescription)
                    return
                }
                
                guard let data = data else {
                    completionHandler(nil, nil)
                    return
                }
                
                let decoder = JSONDecoder()
                
                do {
                    let item = try decoder.decode(T.self, from: data)
                    completionHandler(item, nil)
                } catch let error {
                    completionHandler(nil, error.localizedDescription)
                }
            }
        }
        
        task.resume()
    }
}


