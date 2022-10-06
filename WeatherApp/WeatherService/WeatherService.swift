//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Mindaugas Balakauskas on 05/10/2022.
//

import Foundation
import CoreLocation

public final class WeatherService: NSObject {
    
    //APICoordinatesRequest: https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}&units={metric}
    //APIByLocationRequest: https://api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}&units={metric}
    private let locationManager = CLLocationManager()
    private let APIKey = "0603f06f5336bb4554604ac1fd9d6e48"
    private var callback: ((WeatherModel) -> Void)?
    
    public override init(){
        super .init()
        locationManager.delegate = self
    }
    
    public func loadWeatherData(_ callback: @escaping((WeatherModel) -> Void)) {
        self.callback = callback
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    private func makeDataRequestWithCoodinates(forCoordinates coordinates: CLLocationCoordinate2D) {
        guard let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=\(APIKey)&units=metric".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return }
        guard let url = URL(string: urlString) else {return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil, let data = data else { return}
            if let response = try? JSONDecoder().decode(APIResponse.self, from: data){
                self.callback?(WeatherModel(response: response))
            }
        } .resume()
    }
   
}

extension WeatherService: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]
    ) {
        guard let location = locations.first else {return }
        makeDataRequestWithCoodinates(forCoordinates: location.coordinate)
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
}


struct APIWeater: Decodable {
    let description: String
    let iconName: String
    
    enum CodingKeys: String, CodingKey {
        case description
        case iconName = "main"        
    }
}
