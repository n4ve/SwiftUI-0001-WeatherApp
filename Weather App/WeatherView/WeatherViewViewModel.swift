//
//  WeatherViewViewModel.swift
//  Weather App
//
//  Created by N4ve on 1/1/2568 BE.
//

import Foundation
import CoreLocation

extension WeatherView {
    
    class WeatherViewViewModel: ObservableObject {
        
        @Published var isLoading = false
        
        var location: CLLocationCoordinate2D?
        
    }
}
