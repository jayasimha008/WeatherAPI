//
//  WeatherViewModel.swift
//  NooroWeather
//
//  Created by Jaya Siva Bhaskar Karlapalem on 1/25/25.
//

import SwiftUI

final class WeatherViewModel: ObservableObject {
    
    // Published properties to notify SwiftUI views about changes
    @Published var isError: Bool = false
    @Published var weathers: [WeatherResponseBody] = []
    @Published var imageCache = [String: UIImage]()
    @Published var lastSearchedCity: String = ""

    private let manager: APIManagerService
    private let cacheManager = CacheManager()
    
    private let lastSearchedCityKey = "lastSearchedCity" // Key for UserDefaults

    init(manager: APIManagerService = APIManager()) {
        self.manager = manager
        loadLastSearchedCity()
    }
    
    // Fetches weather data for a given city
    func fetchWeather(for city: String) {
        guard !city.isEmpty else { return }
        
        Task {
            do {
                // Make an API request to fetch weather data
                let weather: WeatherResponseBody = try await manager.request(type: WeatherEndPoint.fetchWeatherByCity(city))
                
                // Update UI-related properties on the main thread
                DispatchQueue.main.async {
                    self.weathers = [weather] // Replace old data with the new one
                    self.loadIcon(for: weather)
                    self.isError = false
                    self.lastSearchedCity = city
                    self.saveLastSearchedCity(city)
                }
            } catch {
                // Handle error and update the isError property on the main thread
                DispatchQueue.main.async {
                    self.isError = true
                    print("API Error: \(error)")
                }
            }
        }
    }
    
    // Loads weather icon and updates image cache
    private func loadIcon(for weather: WeatherResponseBody) {
        guard !weather.current.condition.icon.isEmpty else { return }
        let iconCode = weather.current.condition.icon
        
        // Check if the icon is already cached
        if let cachedImage = cacheManager.getCachedImage(forKey: iconCode) {
            DispatchQueue.main.async {
                self.imageCache[iconCode] = cachedImage
            }
            return
        }
        
        // Fetch icon data if not cached
        Task {
            do {
                let data: Data = try await manager.request(type: WeatherEndPoint.fetchWeatherIcon(iconCode))
                guard let image = UIImage(data: data) else { return }
                
                DispatchQueue.main.async {
                    self.cacheManager.cacheImage(image, forKey: iconCode)
                    self.imageCache[iconCode] = image
                }
                
            } catch {
                print("Icon Fetch Error: \(error)")
            }
        }
    }
    
    // Saves last searched city to UserDefaults
    private func saveLastSearchedCity(_ city: String) {
        UserDefaults.standard.set(city, forKey: lastSearchedCityKey)
    }
    
    // Loads last searched city from UserDefaults
    private func loadLastSearchedCity() {
        if let savedCity = UserDefaults.standard.string(forKey: lastSearchedCityKey) {
            lastSearchedCity = savedCity
        }
    }
}
