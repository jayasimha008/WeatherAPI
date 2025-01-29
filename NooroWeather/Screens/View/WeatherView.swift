//
//  WeatherView.swift
//  NooroWeather
//
//  Created by Jaya Siva Bhaskar Karlapalem on 1/25/25.
//

import SwiftUI

struct WeatherView: View {
    @StateObject private var viewModel = WeatherViewModel()
    @State private var cityName: String = ""
    @State private var viewState: WeatherViewState = .idle

    var body: some View {
        NavigationStack {
            List {
                VStack(spacing: 20) {
                    // Search Bar
                    HStack {
                        TextField("Search Location", text: $cityName, onEditingChanged: { isEditing in
                            // When editing starts, hide weather details and basic view
                            viewState = isEditing ? .typing : .searched
                        }, onCommit: {
                            // When the user commits the search, fetch the weather data
                            if !cityName.isEmpty {
                                viewModel.fetchWeather(for: cityName)
                                viewState = .searched // Mark that a city has been searched
                            }
                        })
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .submitLabel(.search)
                        .overlay(
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.gray)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                                    .padding(.trailing, 15)
                            }
                        )
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    // 1. Place Holder: No city selected
                    VStack(spacing: 20) {
                        if case .idle = viewState {
                            Spacer(minLength: 130)
                            Text("No City Selected")
                                .font(.largeTitle)
                                .bold()
                                .multilineTextAlignment(.center)
                            Text("Please Search For A City")
                                .font(.subheadline)
                                .bold()
                                .multilineTextAlignment(.center)
                        }
                    }
                    
                    // 2. Basic View (City, Temp, and Icon)
                    if let weather = viewModel.weathers.first, case .searched = viewState {
                        VStack {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(weather.location.name)
                                        .font(.headline)
                                        .bold()
                                    Text("\(weather.current.tempF, specifier: "%.1f")°F")
                                        .font(.largeTitle)
                                }
                                
                                Spacer()
                                
                                if let icon = viewModel.imageCache[weather.current.condition.icon] {
                                    Image(uiImage: icon)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 80, height: 80)
                                } else {
                                    ProgressView()
                                        .frame(width: 80, height: 80)
                                }
                            }
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                            .onTapGesture {
                                // Toggle visibility of weather details
                                viewState = .weatherDetails
                            }
                        }
                    }
                    
                    // 3. Detail View (This is hidden until tapping HStack)
                    if case .weatherDetails = viewState, let weather = viewModel.weathers.first {
                        VStack(spacing: 16) {
                            // Icon, City, Temperature
                            VStack(spacing: 8) {
                                // Icon
                                if let icon = viewModel.imageCache[weather.current.condition.icon] {
                                    Image(uiImage: icon)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 150, height: 150)
                                } else {
                                    ProgressView()
                                }
                                // City Name
                                Text(weather.location.name)
                                    .font(.title)
                                    .bold()
                                // Temperature
                                Text("\(weather.current.tempF, specifier: "%.1f")°F")
                                    .font(.largeTitle)
                                    .bold()
                            }
                            
                            // Horizontal Bar with Weather Details
                            HStack {
                                WeatherDetailView(label: "Humidity", value: "\(weather.current.humidity)%")
                                Spacer()
                                WeatherDetailView(label: "UV Index", value: "\(String(format: "%.1f", weather.current.uv))")
                                Spacer()
                                WeatherDetailView(label: "Feels like", value: "\(String(format: "%.1f", weather.current.feelslikeF))°F")
                            }
                            .frame(height: 80)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                        }
                        .padding()
                    }
                    
                    Spacer()
                }
            }
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
            .navigationTitle("Weather")
            // Show last search city when the app is launched
            .onAppear {
                cityName = viewModel.lastSearchedCity
                if !cityName.isEmpty {
                    viewModel.fetchWeather(for: cityName) // Fetch weather data when the app starts
                    viewState = .searched // Mark that the city has been searched before
                }
            }
            // API error alert
            .alert(isPresented: $viewModel.isError) {
                Alert(
                    title: Text("Error"),
                    message: Text("Failed to fetch weather data. Please try again."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}

// Reusable Weather Detail View
struct WeatherDetailView: View {
    let label: String
    let value: String

    var body: some View {
        VStack {
            Text(label)
                .font(.subheadline)
                .foregroundColor(.gray)
            Text(value)
                .font(.headline)
                .bold()
        }
    }
}

#Preview {
    WeatherView()
}
