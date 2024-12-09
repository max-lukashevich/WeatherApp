//
//  WeatherStorageService.swift
//  WeatherApp
//
//  Created by Max Lukashevich on 07/12/2024.
//

import Foundation
import CoreData

protocol WeatherStorageServiceProtocol {
    func saveToLocalStorage(city: RemoteCityModel) async throws -> City
    var viewContext: NSManagedObjectContext { get }
}
