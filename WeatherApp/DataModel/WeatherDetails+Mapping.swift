//
//  WeatherDetails+Mapping.swift
//  WeatherApp
//
//  Created by Max Lukashevich on 07/12/2024.
//

import Foundation
import CoreData

extension WeatherDetails {
    static var entityName: String {
        return "WeatherDetails"
    }

    static func entityDescription(in context: NSManagedObjectContext) -> NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: entityName, in: context)!
    }
}

extension WeatherDetails {
    static func create(from remoteDetails: RemoteWeatherDetailsModel, in context: NSManagedObjectContext) -> WeatherDetails {
        let details = WeatherDetails(entity: entityDescription(in: context), insertInto: context)
        details.timestamp = remoteDetails.timestamp
        details.humidity = Int16(remoteDetails.humidity)
        details.temperature = remoteDetails.temp
        details.windSpeed = remoteDetails.windSpeed
        details.detailedDescription = remoteDetails.detailedDescription
        details.imageURL = remoteDetails.imageURL
        return details
    }
}
