//
//  WeatherForecastService.swift
//  WeatherApp
//
//  Created by Max Lukashevich on 07/12/2024.
//

import Foundation
import Combine

protocol WeatherForecastServiceProtocol {
    func fetchForecastFor(city cityName: String) -> AnyPublisher<RemoteCityModel, Error>
    func saveToLocalStorage(city: RemoteCityModel) async throws -> City
    func updateDataFor(cityName: String) async throws -> City
}

class WeatherForecastService: WeatherForecastServiceProtocol {

    private let apiService: WeatherApiServiceProtocol
    private let storage: WeatherStorageServiceProtocol

    init(apiService: WeatherApiServiceProtocol, storage: WeatherStorageServiceProtocol) {
        self.apiService = apiService
        self.storage = storage
    }

    func fetchForecastFor(city cityName: String) -> AnyPublisher<RemoteCityModel, Error> {
        return Future { promise in
            Task {
                do {
                    let remoteModel = try await self.apiService.fetchWeather(forCity: cityName)
                    promise(.success(remoteModel))
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }

    func saveToLocalStorage(city: RemoteCityModel) async throws -> City {
        return try await self.storage.saveToLocalStorage(city: city)
    }

    func updateDataFor(cityName: String) async throws -> City {
        let remoteModel = try await self.apiService.fetchWeather(forCity: cityName)
        return try await self.saveToLocalStorage(city: remoteModel)
    }
}
