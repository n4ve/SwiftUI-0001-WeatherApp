//
//  WeatherViewViewModel.swift
//  Weather App
//
//  Created by N4ve on 1/1/2568 BE.
//

import Foundation
import CoreLocation
import Combine

extension WeatherView {
    
    class WeatherViewViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
        
        enum State {
            case idle
            case loading
            case failed(Error)
            case loaded
        }
        
        @Published private(set) var state = State.idle
        @Published private(set) var weather: WeatherResponse?
        
        let weatherAPIService: WeatherAPIService
        
        let locationManager: CLLocationManager
        
        private var location: CLLocationCoordinate2D?
        
        private var cancellable: AnyCancellable?
        
        init(weatherAPIService: WeatherAPIService = WeatherAPIService(), locationManager: CLLocationManager = CLLocationManager()) {
            self.state = .idle
            self.weatherAPIService = weatherAPIService
            self.locationManager = locationManager
           
        }
        
        func requestLocation() {
            self.state = .loading
            self.locationManager.delegate = self
            locationManager.requestLocation()
        }
        
        // Set the location coordinates to the location variable
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            location = locations.first?.coordinate
            if let location = locations.first {
                print("Location: " + location.description)
                let request = WeatherRequest(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                cancellable = weatherAPIService.execute(request).sink(receiveCompletion: { completion in
                    print(completion)
                }, receiveValue: { [weak self] response in
                    self?.weather = response
                    self?.state = .loaded
                });
                
            }
        }
            

        
        // This function will be called if we run into an error
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("Error getting location", error)
            self.state = .failed(error)
        }
        
    }
}
