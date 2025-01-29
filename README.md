Weather App

A simple and clean weather application built with SwiftUI, which fetches real-time weather data from a weather API. It provides current weather information for a searched city and displays the temperature, conditions, and other relevant data.

Features
Real-time weather data fetched from the Weather API.
Display temperature, weather condition, and location.
Beautiful user interface built with SwiftUI.
Followed MVVM architechture 
Allows users to search for different cities and view their weather.

Requirements
Xcode 16.1 or later
Swift 6 or later
iOS 16.6 or later

Installation:
Clone the repository:
git clone https://github.com/jayasimha008/WeatherApp.git

Open the project in Xcode:
open WeatherAPI.xcodeproj

Build and run the app on a simulator or device.

Configuration:
To use the Weather API, you'll need an API key.
Sign up for an API key at https://www.weatherapi.com/login.aspx
Replace the placeholder YOUR_API_KEY in your project with the API key.
let apiKey = "YOUR_API_KEY"

Usage:
- When the app is launched, it will display the last searched city if available or prompt the user to search a city.
- You can search for another city by entering the name in the search bar.
- The app initally will show basic details like city name, temperature and the corresponding weather icon
- Tapping it will reveal the additional details view with more information like humidity, UV etc.

Here are some Screenshots:

![Simulator Screenshot - iPhone 16 Pro - 2025-01-28 at 23 49 22](https://github.com/user-attachments/assets/3160b7c9-d755-408c-911f-68b225ec32a8)

![Simulator Screenshot - iPhone 16 Pro - 2025-01-28 at 23 49 27](https://github.com/user-attachments/assets/2454ab70-866b-40a0-849a-56ecd1ba2c70)






