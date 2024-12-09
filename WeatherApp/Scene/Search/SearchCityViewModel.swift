//
//  SearchViewModel.swift
//  WeatherApp
//
//  Created by Max Lukashevich on 08/12/2024.
//

import Foundation
import Combine
import Factory
import CoreData

class SearchCityViewModel: BaseViewModel {

    var completionHandler: (() -> Void)?

    @Published var searchText = ""
    @Published var isItemAlreadySaved: Bool = false
    @Published var city: SearchCityUIModel?

    private let weatherService: WeatherForecastServiceProtocol
    private var cancellables: Set<AnyCancellable> = []
    private let coreDataService: CoreDataFetchService<City>

    internal init(
        weatherService: any WeatherForecastServiceProtocol = Container.shared.forecastService(),
        managedObjectContext: NSManagedObjectContext = Container.shared.storage().viewContext) {

            self.coreDataService = CoreDataFetchService(
                context: managedObjectContext,
                fetchRequest: City.fetchRequest(),
                sortDescriptors: [NSSortDescriptor(keyPath: \City.name, ascending: true)]
            )

            self.weatherService = weatherService
        }

    func startSearch() {
        self.city = nil
        self.state = .loading
        weatherService.fetchForecastFor(city: searchText)
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in

                guard let self = self else { return }

                switch completion {
                case .failure(let error):
                    self.handleError(error)
                default:
                    break
                }
            } receiveValue: { [weak self] remoteModel in
                self?.handleItemUpdated(.init(remoteModel: remoteModel))
            }
            .store(in: &cancellables)
    }

    func handleError(_ error: Error) {
        if (error as NSError).code != 404 {
            state = .error(.init(error))
        } else {
            state = .loaded
        }
    }

    func handleItemUpdated(_ item: SearchCityUIModel) {
        checkIfItemIsAlreadySaved(item)
        city = item
        state = .loaded
    }

    func addCityToFavorites() {
        guard let city = city else { return }

        self.state = .loading

        Task { [weak self] in
            guard let self = self else { return }
            do {
                _ = try await self.weatherService.saveToLocalStorage(city: city.remoteModel)
                self.completionHandler?()
            } catch {
                self.state = .error(.init(error))
            }
        }
    }

    func checkIfItemIsAlreadySaved(_ city: SearchCityUIModel?) {
        guard let cityId = city?.cityId else { return }
        isItemAlreadySaved = coreDataService.checkInItemAlreadyExists(searchKey: "cityId", valueKey: "\(cityId)")
    }
}
