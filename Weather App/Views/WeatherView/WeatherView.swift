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
        case .initial:
            Text("Welcome to the Weather App")
                .bold()
                .font(.title)
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
                LocationButton(.currentLocation) {
                    self.viewModel.requestLocation()
                }
                .cornerRadius(30)
                .symbolVariant(.fill)
                .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        case .loading:
            LoadingView()
        case .failed(let errorMessage):
            Text(errorMessage)
        case .loaded:
            if let weather = viewModel.weather {
                WeatherDisplayView(weather: weather)
            }
        }
    }
}

struct WeatherDisplayView: View {

    var weather: WeatherResponse
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(weather.name)
                        .bold()
                        .font(.title)
                    
                    Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                        .fontWeight(.light)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                VStack {
                    HStack {
                        VStack(spacing: 20) {
                            Image(systemName: "cloud")
                                .font(.system(size: 40))
                            
                            Text("\(weather.weather[0].main)")
                        }
                        .frame(width: 150, alignment: .leading)
                        
                        Spacer()
                        
                        if let feelsLike = weather.main.feelsLike {
                            Text(feelsLike.roundDouble() + "°")
                                .font(.system(size: 100))
                                .fontWeight(.bold)
                                .padding()
                        }
                        
                    }
                    
                    Spacer()
                        .frame(height:  80)
                    
                    AsyncImage(url: URL(string: "https://cdn.pixabay.com/photo/2020/01/24/21/33/city-4791269_960_720.png")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 350)
                    } placeholder: {
                        ProgressView()
                    }
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack {
                Spacer()
                VStack(alignment: .leading, spacing: 20) {
                    Text("Weather now")
                        .bold()
                        .padding(.bottom)
                    
                    HStack {
                        if let tempMin = weather.main.tempMin {
                            WeatherRow(logo: "thermometer", name: "Min temp", value: (tempMin.roundDouble() + ("°")))
                            Spacer()
                            
                        }
                        if  let tempMax = weather.main.tempMax {
                            WeatherRow(logo: "thermometer", name: "Max temp", value: (tempMax.roundDouble() + "°"))
                        }
                        
                    }
                    
                    HStack {
                        if let speed = weather.wind.speed {
                            WeatherRow(logo: "wind", name: "Wind speed", value: (speed.roundDouble() + " m/s"))
                        }
                        Spacer()
                        if let humidity = weather.main.humidity {
                            WeatherRow(logo: "humidity", name: "Humidity", value: "\(humidity.roundDouble())%")
                        }
                       
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .padding(.bottom, 20)
                .foregroundColor(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
                .background(.white)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
        .preferredColorScheme(.dark)
    }
}

struct WeatherRow: View {
    var logo: String
    var name: String
    var value: String
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: logo)
                .font(.title2)
                .frame(width: 20, height: 20)
                .padding()
                .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.888))
                .cornerRadius(50)

            
            VStack(alignment: .leading, spacing: 8) {
                Text(name)
                    .font(.caption)
                
                Text(value)
                    .bold()
                    .font(.title)
            }
        }
    }
}

extension Double {
    func roundDouble() -> String {
        return String(format: "%.0f", self)
    }
}


#Preview {
    WeatherView(viewModel: WeatherView.WeatherViewViewModel())
}
