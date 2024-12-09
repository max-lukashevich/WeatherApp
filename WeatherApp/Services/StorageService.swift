//
//  CoreDataStorageService.swift
//  WeatherApp
//
//  Created by Max Lukashevich on 07/12/2024.
//

import Foundation
import CoreData

class StorageService: WeatherStorageServiceProtocol {

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "WeatherApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    lazy var viewContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()

    init() {
        setupNotificationHandling()
    }

    private func setupNotificationHandling() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self,
                                       selector: #selector(mergeChangesFromNotification(_:)),
                                       name: .NSManagedObjectContextDidSave,
                                       object: nil)
    }

    @objc
    private func mergeChangesFromNotification(_ notification: Notification) {
        guard let sender = notification.object as? NSManagedObjectContext,
              sender !== viewContext,
              sender.concurrencyType == .privateQueueConcurrencyType
        else { return }

        viewContext.perform { [weak self] in
            self?.viewContext.mergeChanges(fromContextDidSave: notification)
        }
    }

    func saveToLocalStorage(city: RemoteCityModel) async throws -> City {
        let backgroundContext = persistentContainer.newBackgroundContext()
        var cityID: NSManagedObjectID?

        try await backgroundContext.perform {
            let cityObject = City.mapFromRemoteModel(city, in: backgroundContext)
            do {
                try backgroundContext.save()
                cityID = cityObject?.objectID
            } catch let error {
                print("Failed to save city: \(error)")
                throw error
            }
        }

        guard let id = cityID else {
            throw NSErrorHelper.weatherAppError(code: 0, description: "Failed to save city")
        }

        guard let savedCity = viewContext.object(with: id) as? City else {
            throw NSErrorHelper.weatherAppError(code: 0, description: "failed to retrieve city")
        }

        return savedCity
    }

}
