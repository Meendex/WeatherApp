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
    let weatherDescription: String
    let weatherIcon: String
    
    init(response: APIResponse) {
        locationName = response.name
        curentTemperature = "\(Int(response.main.temp))"
        weatherDescription = response.weather.first?.description ?? ""
        weatherIcon = response.weather.first?.iconName ?? ""
        
    }
}
