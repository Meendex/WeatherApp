//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Mindaugas Balakauskas on 05/10/2022.
//

import Foundation

private let defaultIcon = ""
private let iconMap = [
    "Drizzle": "🌧",
    "Tunderstorm": "⛈",
    "Rain":"🌧",
    "Snow": "❄️",
    "Clear": "☀️",
    "Clouds": "☁️",
    "Haze": "☁️",
    "Mist": "☁️"]

public class WeatherViewModel: ObservableObject {
    @Published var locationName: String = "Location"
    @Published var curentTemperature: String = "--"
    @Published var weatherDescription: String = "--"
    @Published var weatherIcon: String = defaultIcon
    
    public let weatherService: WeatherService
    public init(weatherService: WeatherService){
        self.weatherService = weatherService
    }
    public func refresh(){
        weatherService.loadWeatherData{[weak self] weather in DispatchQueue.main.async {
            self?.locationName = weather.locationName
            self?.curentTemperature = "\(weather.curentTemperature)°C"
            self?.weatherDescription = weather.weatherDescription.capitalized
            self?.weatherIcon = iconMap[weather.weatherIcon] ?? defaultIcon
        }}
    }
}
