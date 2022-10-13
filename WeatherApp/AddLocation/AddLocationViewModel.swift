//
//  AddLocationViewModel.swift
//  WeatherApp
//
//  Created by Mindaugas Balakauskas on 12/10/2022.
//

import Foundation

class AddLocationViewModel {
    
                                           
    func saveLocation(locationName: String) {
        if !locationName.isEmpty {
            Location.addLocation(moc: CoreDataManager.shared.persistentContainer.viewContext, locationName: locationName)
        }
    }
    private var locations: [Location] = []
    
    var locationsCount: Int { return locations.count}
    
    func getLocations() {
        locations = Location.getAllLocations(moc: CoreDataManager.shared.persistentContainer.viewContext)
    }
    func getLocationName(index: Int)-> String {
        return locations[index].locationName ?? ""
    }
//    func deleteLocationName() {
//        locations = Location.deleteLocationName(locationName:<#Location#>, moc: CoreDataManager.shared.persistentContainer.viewContext)
//    }
    
}
