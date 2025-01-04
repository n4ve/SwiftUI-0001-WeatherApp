//
//  WeatherResponse.swift
//  Weather App
//
//  Created by N4ve on 1/1/2568 BE.
//

import Foundation

struct WeatherResponse: Decodable {
    let coord: Coordinates
    let weather: [Weather]
    let base: String
    let main: MainWeatherData
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: SystemData
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int

    // Map JSON keys to Swift property names
    enum CodingKeys: String, CodingKey {
        case coord
        case weather
        case base
        case main
        case visibility
        case wind
        case clouds
        case dt
        case sys
        case timezone
        case id
        case name
        case cod
    }
}

// Define the nested structures
struct Coordinates: Decodable {
    let lon: Double
    let lat: Double
    
    enum CodingKeys: String, CodingKey {
        case lon
        case lat
    }
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case main
        case description
        case icon
    }
}

struct MainWeatherData: Decodable {
    let temp: Double?
    let feelsLike: Double?
    let tempMin: Double?
    let tempMax: Double?
    let pressure: Double?
    let humidity: Double?
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case humidity
    }
}

struct Wind: Decodable {
    let speed: Double?
    let deg: Int?
    let gust: Double?
    
    enum CodingKeys: String, CodingKey {
        case speed
        case deg
        case gust
    }
}

struct Clouds: Decodable {
    let all: Int
    
    enum CodingKeys: String, CodingKey {
        case all
    }
}

struct SystemData: Decodable {
    let type: Int
    let id: Int
    let country: String
    let sunrise: Int
    let sunset: Int
    
    enum CodingKeys: String, CodingKey {
        case type
        case id
        case country
        case sunrise
        case sunset
    }
}
