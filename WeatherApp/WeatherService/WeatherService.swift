//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Mindaugas Balakauskas on 05/10/2022.
//

import Foundation
import CoreLocation

public final class WeatherService: NSObject {
    
    private let addLocationViewModel = AddLocationViewModel()
    private let locationManager = CLLocationManager()
    private let APIKey = "0603f06f5336bb4554604ac1fd9d6e48"
    private let locationKey = "Hitchin"//"Milton Keynes"
    private var completionHandler: ((WeatherModel) -> Void)?
//    let coordinatesAPI = "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=\(APIKey)&units=metric".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
//    let locationAPI = "https://api.openweathermap.org/data/2.5/weather?q=\(String(describing: locationKey))&appid=\(APIKey)&units=metric".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    
    public override init(){
        super .init()
        locationManager.delegate = self
        
    }
    public func loadWeatherData(_ completionHandler: @escaping((WeatherModel) -> Void)) {
        self.completionHandler = completionHandler
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    private func makeDataRequestWithCoordinates(forCoordinates coordinates: CLLocationCoordinate2D) {
        guard let urlString =  "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=\(APIKey)&units=metric".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return }
        guard let url = URL(string: urlString) else {return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil, let data = data else { return}
            if let response = try? JSONDecoder().decode(APIResponse.self, from: data){
                self.completionHandler?(WeatherModel(response: response))
            }
        } .resume()
    }
    private func makeDataRequestWithLocation() {
        guard let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(String(describing: locationKey))&appid=\(APIKey)&units=metric".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return }
        guard let url = URL(string: urlString) else {return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil, let data = data else { return}
            if let response = try? JSONDecoder().decode(APIResponse.self, from: data){
                self.completionHandler?(WeatherModel(response: response))
            }
        } .resume()
    }
   
}

extension WeatherService: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]
    ) {
        
        guard let location = locations.first else { return }
        makeDataRequestWithCoordinates(forCoordinates: location.coordinate)
        
        if locationKey != nil {
            makeDataRequestWithLocation()
        }
    }
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Something went wrong: \(error.localizedDescription)")
    }
}

struct APIResponse: Decodable {
    let name: String
    let main: APIMain
    let weather: [APIWeater]
}

struct APIMain: Decodable {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Int
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
    }
}

struct APIWeater: Decodable {
    let description: String
    let iconName: String
    
    enum CodingKeys: String, CodingKey {
        case description
        case iconName = "main"        
    }
}

//https://api.openweathermap.org/data/2.5/weather?q=London&appid=0603f06f5336bb4554604ac1fd9d6e48&units=metric
