//
//  WeatherAPIService.swift
//  Weather App
//
//  Created by N4ve on 1/1/2568 BE.
//

import Foundation
import Combine

final class WeatherAPIService: APIService {
    
    // URLSession instance for network requests
    var session: URLSession {
        return URLSession.shared
    }
    
    // DispatchQueue for background operations
    var backgroundQueue: DispatchQueue {
        return DispatchQueue.global(qos: .background)
    }
    
    // Base URL for the API
    var baseURL: String {
        return "https://api.openweathermap.org"
    }
    
}
