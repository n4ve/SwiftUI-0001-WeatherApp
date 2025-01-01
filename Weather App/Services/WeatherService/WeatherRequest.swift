//
//  WeatherRequest.swift
//  Weather App
//
//  Created by N4ve on 1/1/2568 BE.
//

import Foundation

struct WeatherRequest: APIRequest {
    typealias ResponseType = WeatherResponse
    
    var latitude: Double
    var longitude: Double
    
    var path: String {
        "/data/2.5/weather"
    }
    
    var method: String {
        return "GET"
    }
    
    var headers: [String : String]?
    
    var queryItems: [URLQueryItem]? {
        return [
            URLQueryItem(name: "lat", value: "\(latitude)"),
            URLQueryItem(name: "lon", value: "\(longitude)"),
            URLQueryItem(name: "appid", value: "YOUR_API_KEY"),
            URLQueryItem(name: "units", value: "metric")
        ]
    }
    
    func body() throws -> Data? {
        nil
    }
    
    
}

