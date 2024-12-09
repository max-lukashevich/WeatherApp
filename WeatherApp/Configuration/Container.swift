//
//  Container.swift
//  WeatherApp
//
//  Created by Max Lukashevich on 08/12/2024.
//

import Foundation
import Factory

extension Container {

    static let shared = Container()

    var weatherApiConfig: Factory<WeatherApiServiceConfiguration> {
        self { WeatherApiServiceConfiguration.init(baseURL: Constants.baseURL, apiKey: Constants.apiKey) }
    }

    var weatherApiService: Factory<WeatherApiServiceProtocol> {
        self { WeatherApiService(configuration: self.weatherApiConfig()) }
    }

    var storage: Factory<WeatherStorageServiceProtocol> {
        self { StorageService() }
            .scope(.singleton)
    }

    var forecastService: Factory<WeatherForecastServiceProtocol> {
        self { WeatherForecastService(apiService: self.weatherApiService(), storage: self.storage()) }
    }
}
