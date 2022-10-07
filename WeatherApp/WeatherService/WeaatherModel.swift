//
//  WeaatherModel.swift
//  WeatherApp
//
//  Created by Mindaugas Balakauskas on 05/10/2022.
//

import Foundation

public struct WeatherModel {
    let locationName: String
    let curentTemperature: String
    let feelsLike: String
    let tempMin: String
    let tempMax: String
    let pressure: String
    let weatherDescription: String
    let weatherIcon: String
    
    init(response: APIResponse) {
        locationName = response.name
        curentTemperature = "\(Int(response.main.temp))"
        feelsLike = "\(Int(response.main.feelsLike))"
        tempMin = "\(Int(response.main.tempMin))"
        tempMax = "\(Int(response.main.tempMax))"
        pressure = "\(Int(response.main.pressure))"
        weatherDescription = response.weather.first?.description ?? ""
        weatherIcon = response.weather.first?.iconName ?? ""
    }
}
