//
//  Location+Extension.swift
//  WeatherApp
//
//  Created by Mindaugas Balakauskas on 12/10/2022.
//

import Foundation
import CoreData

extension Location {
    static func addLocation(moc: NSManagedObjectContext, locationName: String) {
        let locationEntity = NSEntityDescription.insertNewObject(forEntityName: "Location", into: moc) as? Location
        locationEntity?.locationName = locationName
        CoreDataManager.shared.saveContext()
    }
    static func getAllLocations(moc: NSManagedObjectContext)-> [Location] {
        let fr = Location.fetchRequest()
        do {
            let locations = try moc.fetch(fr)
            return locations
        } catch {
            return []
        }
    }
    static func deleteLocationName (locationName: Location, moc: NSManagedObjectContext) {
        moc.delete(locationName)
    }
}
