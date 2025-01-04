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
            case initial
            case idle
            case loading
            case failed(String)
            case loaded
        }
        
        @Published private(set) var state = State.initial
        @Published private(set) var weather: WeatherResponse?
        
        let weatherAPIService: WeatherAPIService
        
        let locationManager: CLLocationManager
        
        private var location: CLLocationCoordinate2D?
        
        private var cancellable: AnyCancellable?
        
        init(weatherAPIService: WeatherAPIService = WeatherAPIService(), locationManager: CLLocationManager = CLLocationManager()) {
            self.weatherAPIService = weatherAPIService
            self.locationManager = locationManager
            self.state = .idle
           
        }
        
        func requestLocation() {
            self.state = .loading
            self.locationManager.delegate = self
            switch self.locationManager.authorizationStatus{
            case .notDetermined:
                self.locationManager.requestWhenInUseAuthorization()
            case .denied:
                self.state = .failed("Location Denied")
            case .restricted:
                self.state = .failed("Location Denied")
            case .authorizedWhenInUse:
                locationManager.requestLocation()
            case .authorizedAlways:
                locationManager.requestLocation()
            @unknown default:
                self.state = .failed("Unknown Error")
            }
            
        }
        
        // Set the location coordinates to the location variable
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            location = locations.first?.coordinate
            if let location = locations.first {
                let request = WeatherRequest(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                cancellable = weatherAPIService.execute(request).sink(receiveCompletion: { completion in
                    
                }, receiveValue: { [weak self] response in
                    self?.weather = response
                    self?.state = .loaded
                });
                
            }
        }
        
        func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
                DispatchQueue.main.async {
                    if(manager.authorizationStatus == .authorizedAlways || manager.authorizationStatus == .authorizedWhenInUse) {
                        self.locationManager.requestLocation()
                    }
                }
        }
        
        
        func locationManager(_ manager: CLLocationManager, didFinishDeferredUpdatesWithError error: (any Error)?) {
          
            self.state = .failed("Error Defer")

        }
            

        
        // This function will be called if we run into an error
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("Error getting location", error)
            self.state = .failed(error.localizedDescription)
        }
        
    }
}
