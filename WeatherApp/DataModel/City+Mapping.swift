//
//  City+Mapping.swift
//  WeatherApp
//
//  Created by Max Lukashevich on 07/12/2024.
//

import Foundation
import CoreData

extension City {
    static var entityName: String {
        return "City"
    }

    static func entityDescription(in context: NSManagedObjectContext) -> NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: entityName, in: context)!
    }
}

extension City {
    static func mapFromRemoteModel(_ remoteModel: RemoteCityModel, in context: NSManagedObjectContext) -> City? {
        // Fetch the city
        let fetchRequest: NSFetchRequest<City> = City.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "cityId == %d", remoteModel.cityId)

        // Attempt to fetch the city
        let cities: [City]
        do {
            cities = try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch city with ID \(remoteModel.cityId): \(error)")
            return nil
        }

        // Use the existing city, or create a new one if it doesn't exist

        let city = cities.first ?? City(entity: entityDescription(in: context), insertInto: context)
        city.cityId = String(remoteModel.cityId)
        city.name = remoteModel.cityName
        city.country = remoteModel.countryName

        // Map the weather details
        let details = WeatherDetails.create(from: remoteModel.weatherDetails, in: context)
        city.addToWeatherDetails(details)

        return city
    }
}
