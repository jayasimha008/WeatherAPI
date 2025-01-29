**Weather App**

A simple and clean weather application built with SwiftUI, which fetches real-time weather data from a weather API. <br>
It provides current weather information for a searched city and displays the temperature, conditions, and other relevant data.<br>

**Features**

Real-time weather data fetched from the Weather API.<br>
Display temperature, weather condition, and location.<br>
Beautiful user interface built with SwiftUI.<br>
Followed MVVM architechture <br>
Allows users to search for different cities and view their weather.<br>

**Requirements**

Xcode 16.1 or later<br>
Swift 6 or later<br>
iOS 16.6 or later<br>

**Installation**

Clone the repository<br>
git clone https://github.com/jayasimha008/WeatherApp.git<br>
Open the project in Xcode<br>
open WeatherAPI.xcodeproj<br>
Build and run the app on a simulator or device.<br>

**Configuration**

To use the Weather API, you'll need an API key.<br>
Sign up for an API key at https://www.weatherapi.com/login.aspx<br>
Replace the placeholder YOUR_API_KEY in your project with the API key.<br>
`let apiKey = "YOUR_API_KEY"`<br>

**Usage**

- When the app is launched, it will display the last searched city if available or prompt the user to search a city.<br>
- You can search for another city by entering the name in the search bar.<br>
- The app initally will show basic details like city name, temperature and the corresponding weather icon<br>
- Tapping it will reveal the additional details view with more information like humidity, UV etc.<br>

**Here are some Screenshots**

![Simulator Screenshot - iPhone 16 Pro - 2025-01-28 at 23 49 22](https://github.com/user-attachments/assets/3160b7c9-d755-408c-911f-68b225ec32a8)

![Simulator Screenshot - iPhone 16 Pro - 2025-01-28 at 23 49 27](https://github.com/user-attachments/assets/2454ab70-866b-40a0-849a-56ecd1ba2c70)






