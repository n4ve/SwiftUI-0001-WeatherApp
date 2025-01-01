//
//  Weather_AppApp.swift
//  Weather App
//
//  Created by N4ve on 9/11/2567 BE.
//

import SwiftUI

@main
struct WeatherApp: App {
    var body: some Scene {
        WindowGroup {
            WeatherView(viewModel: WeatherView.WeatherViewViewModel())
        }
    }
}
