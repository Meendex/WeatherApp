//
//  AddLocationViewModel.swift
//  WeatherApp
//
//  Created by Mindaugas Balakauskas on 12/10/2022.
//

import Foundation
import Combine

class AddLocationViewModel {
    
        
    func saveLocation(locationName: String) {
        if !locationName.isEmpty {
            Location.addLocation(moc: CoreDataManager.shared.persistentContainer.viewContext, locationName: locationName)
        }
    }
    private var locations: [Location] = []
    
    var locationsCount: Int { return locations.count}
    var locationItem: String = ""
    func getLocations() {
        locations = Location.getAllLocations(moc: CoreDataManager.shared.persistentContainer.viewContext)
    }
    func getLocationName(index: Int)-> String {
        return locations[index].locationName ?? ""
    }
//    func deleteLocationName() {
//        locations = Location.deleteLocationName(locationName:Location, moc: CoreDataManager.shared.persistentContainer.viewContext)
//    }
    func getLocationItem(locationItem: String?) {
        let locationItem = locationItem
        print(locationItem ?? "")
        
        
        let weathetViewModel = WeatherViewModel(weatherService: WeatherService())
        weathetViewModel.refresh()
        
    }
}
