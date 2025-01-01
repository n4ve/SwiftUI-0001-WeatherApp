//
//  WeatherView.swift
//  Weather App
//
//  Created by N4ve on 1/1/2568 BE.
//

import SwiftUI
import CoreLocationUI

struct WeatherView: View {
    
    @ObservedObject private(set) var viewModel: WeatherViewViewModel
    
    var body: some View {
        switch viewModel.state {
        case .idle:
            VStack {
                VStack(spacing: 20) {
                    Text("Welcome to the Weather App")
                        .bold()
                        .font(.title)
                    
                    Text("Please share your current location to get the weather in your area")
                        .padding()
                }
                .multilineTextAlignment(.center)
                .padding()
                LocationButton(.shareCurrentLocation) {
                    self.viewModel.requestLocation()
                }
                .cornerRadius(30)
                .symbolVariant(.fill)
                .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        case .loading:
            LoadingView()
        case .failed(_):
            LoadingView()
        case .loaded:
            Text(viewModel.weather?.name ?? "")
        }
    }
}

#Preview {
    WeatherView(viewModel: WeatherView.WeatherViewViewModel())
}
