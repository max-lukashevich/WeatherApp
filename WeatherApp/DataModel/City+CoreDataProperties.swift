//
//  City+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Max Lukashevich on 07/12/2024.
//
//

import Foundation
import CoreData


extension City {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City")
    }


    @NSManaged public var name: String?
    @NSManaged public var country: String?
    @NSManaged public var cityId: String
    @NSManaged public var weatherDetails: NSSet?

}

// MARK: Generated accessors for weatherDetails
extension City {

    @objc(addWeatherDetailsObject:)
    @NSManaged public func addToWeatherDetails(_ value: WeatherDetails)

    @objc(removeWeatherDetailsObject:)
    @NSManaged public func removeFromWeatherDetails(_ value: WeatherDetails)

    @objc(addWeatherDetails:)
    @NSManaged public func addToWeatherDetails(_ values: NSSet)

    @objc(removeWeatherDetails:)
    @NSManaged public func removeFromWeatherDetails(_ values: NSSet)

}

extension City : Identifiable {

}
