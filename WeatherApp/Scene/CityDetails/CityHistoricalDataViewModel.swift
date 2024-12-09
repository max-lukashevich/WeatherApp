//
//  CityHistoricalDataViewModel.swift
//  WeatherApp
//
//  Created by Max Lukashevich on 08/12/2024.
//

import Foundation
import Factory

class CityHistoricalDataViewModel: BaseViewModel {

    let screenTitle: String
    let updateDataInterval: TimeInterval = 600

    @Published var dataItems: CityHistoricalDataItemsView

    private let weatherService: WeatherForecastServiceProtocol

    init(model: CityUIModel, weatherService: WeatherForecastServiceProtocol = Container.shared.forecastService()) {
        self.screenTitle = "\(model.cityName)\n\("historical")"
        self.dataItems = CityHistoricalDataItemsView.init(uiModel: model)
        self.weatherService = weatherService
        super.init()
    }

    func fetchRecentData() {
        guard
            let cityName = dataItems.city.name,
            let date = dataItems.items.first?.timestamp,
            Date.now.timeIntervalSince(date) >= updateDataInterval
        else {
            return
        }
        state = .loading

        Task {
            do {
                let city = try await weatherService.updateDataFor(cityName: cityName)
                await updateDataItemsAndViewState(with: city)
            } catch {
                await reportError(error)
            }
        }
    }

    private func updateDataItemsAndViewState(with city: City) async {
        await MainActor.run {
            dataItems = CityHistoricalDataItemsView.init(uiModel: CityUIModel(city: city))
            state = .loaded
        }
    }

    private func reportError(_ error: Error) async {
        await MainActor.run {
            state = .error(.init(error))
        }
    }

}
