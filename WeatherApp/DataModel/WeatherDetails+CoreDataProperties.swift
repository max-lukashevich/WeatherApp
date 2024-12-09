//
//  WeatherDetails+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Max Lukashevich on 07/12/2024.
//
//

import Foundation
import CoreData


extension WeatherDetails {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherDetails> {
        return NSFetchRequest<WeatherDetails>(entityName: "WeatherDetails")
    }

    @NSManaged public var detailedDescription: String?
    @NSManaged public var humidity: Int16
    @NSManaged public var imageURL: String?
    @NSManaged public var temperature: Double
    @NSManaged public var timestamp: Date?
    @NSManaged public var windSpeed: Double
    @NSManaged public var city: City?

}
