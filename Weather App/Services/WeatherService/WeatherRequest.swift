//
//  WeatherRequest.swift
//  Weather App
//
//  Created by N4ve on 1/1/2568 BE.
//

import Foundation

struct WeatherRequest: APIRequest {
    typealias ResponseType = WeatherResponse
    
    var path: String
    
    var method: String
    
    var headers: [String : String]?
    
    var queryItems: [URLQueryItem]?
    
    func body() throws -> Data? {
        nil
    }
    

}

