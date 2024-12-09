//
//  CitiesViewModel.swift
//  WeatherApp
//
//  Created by Max Lukashevich on 08/12/2024.
//

import Foundation
import CoreData
import Factory
import Combine


class CitiesViewModel: BaseViewModel {

    private let fetchService: CoreDataFetchService<City>
    private var cancellables: Set<AnyCancellable> = []

    @Published var items: [CityUIModel] = []
    @Published var error: IdentifiableError?

    init(managedObjectContext: NSManagedObjectContext = Container.shared.storage().viewContext) {

        self.fetchService = CoreDataFetchService(
            context: managedObjectContext,
            fetchRequest: City.fetchRequest(),
            sortDescriptors: [NSSortDescriptor(keyPath: \City.name, ascending: true)]
        )

        super.init()

        subscribeToChanges()
        fetchData()
    }

    private func subscribeToChanges() {
        self.fetchService.$items
            .map({ $0.map({ .init(city: $0) }) })
            .sink(receiveValue: { [weak self] in
                self?.items = $0
            })
            .store(in: &cancellables)

        self.fetchService.$error
            .compactMap({ $0 })
            .map({ IdentifiableError.init($0) })
            .removeDuplicates(by: { $0.id == $1.id })
            .sink(receiveValue: { [weak self] in
                self?.error = $0
            })
            .store(in: &cancellables)
    }

    private func fetchData() {
        self.fetchService.fetch()
    }

    func deleteItem(at offsets: IndexSet) {
        fetchService.deleteItem(at: offsets.first!)
    }
}
