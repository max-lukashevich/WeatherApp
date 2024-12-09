//
//  CoreDataFetchService.swift
//  WeatherApp
//
//  Created by Max Lukashevich on 08/12/2024.
//

import Foundation
import CoreData
import Combine

protocol CoreDataFetchServiceProtocol {
    associatedtype ObjectType: NSManagedObject
    var items: [ObjectType] { get }
    var error: Error? { get }

    func fetch()
    func deleteItem(at index: Int)
    func checkInItemAlreadyExists(searchKey: String, valueKey: String) -> Bool
}

class CoreDataFetchService<T: NSManagedObject>: NSObject, NSFetchedResultsControllerDelegate, CoreDataFetchServiceProtocol {

    @Published private(set) var items: [T] = []
    @Published private(set) var error: Error?

    private let fetchedResultsController: NSFetchedResultsController<T>
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext, fetchRequest: NSFetchRequest<T>, sortDescriptors: [NSSortDescriptor]) {
        self.context = context
        fetchRequest.sortDescriptors = sortDescriptors

        self.fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        super.init()
        self.fetchedResultsController.delegate = self

        do {
            try fetchedResultsController.performFetch()
            self.items = fetchedResultsController.fetchedObjects ?? []
        } catch {
            self.error = error
            print("Failed to fetch data: \(error)")
        }
    }

    func fetch() {
        do {
            try fetchedResultsController.performFetch()
            self.items = fetchedResultsController.fetchedObjects ?? []
        } catch {
            self.error = error
            print("Failed to fetch data: \(error)")
        }
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        if let updatedItems = controller.fetchedObjects as? [T] {
            DispatchQueue.main.async {
                self.items = updatedItems
            }
        }
    }

    func deleteItem(at index: Int) {
        let item = items[index]
        context.delete(item)
        do {
            try context.save()
        } catch {
            self.error = error
            print("Failed to delete item: \(error)")
        }
    }

    func checkInItemAlreadyExists(searchKey: String, valueKey: String) -> Bool {
        let predicate = NSPredicate(format: "%K == %@", searchKey, valueKey)
        let filteredItems = items.filter { predicate.evaluate(with: $0) }
        return !filteredItems.isEmpty
    }
}
