//
//  EndPointType.swift
//  NooroWeather
//
//  Created by Jaya Siva Bhaskar Karlapalem on 1/25/25.
//

import Foundation

//https://api.weatherapi.com/v1/current.json?key=3d87b0977d5d46f79bd213118252501&q=Hillsboro&aqi=no

// Enum representing the HTTP methods used in network requests
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case delete = "DELETE"
}

// Protocol defining the structure of an endpoint for network requests
protocol EndPointType {
    var url: URL? { get }
    var path: String { get }
    var baseURL: String { get }
    var body: Encodable? { get }
    var headers: [String: String]? { get }
    var method: HTTPMethod { get }
}

// Enum defining different endpoints for fetching weather data
enum WeatherEndPoint {
    case fetchWeatherByCity(_ city: String)
    case fetchWeatherIcon(_ name: String)
}

// Extension to conform WeatherEndPoint to the EndPointType protocol
extension WeatherEndPoint: EndPointType {
    private var apiKey: String {
        return "3d87b0977d5d46f79bd213118252501"
    }
    
    // Building the full URL for the endpoint
    var url: URL? {
        return URL(string: baseURL + path)
    }
    
    // Return the base URL for each endpoint
    var baseURL: String {
        switch self {
        case .fetchWeatherByCity:
            return "https://api.weatherapi.com/v1/"  //https://api.weatherapi.com/v1
        case .fetchWeatherIcon:
            return "https:" // https://cdn.weatherapi.com/weather/64x64/day/116.png
        }
    }
    
    // Defining the path for each endpoint
    var path: String {
        switch self {
        case .fetchWeatherByCity(let city):
            let cityQuery = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            return"current.json?key=\(apiKey)&q=\(cityQuery)&aqi=no"
            
        case .fetchWeatherIcon(let iconName):
            return "\(iconName)"
        }
    }
    
    var body: Encodable? { nil }

    var headers: [String : String]? {
        APIManager.commonHeaders
    }

    var method: HTTPMethod {
        return .get
    }


}
