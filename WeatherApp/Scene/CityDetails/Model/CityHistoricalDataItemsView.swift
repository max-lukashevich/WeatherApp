//
//  CityHistoricalDataView.swift
//  WeatherApp
//
//  Created by Max Lukashevich on 08/12/2024.
//

import Foundation

struct CityHistoricalDataItemsView {
    let city: City
    let items: [CityHistoricalDataModel]

    init(uiModel: CityUIModel) {
        self.city = uiModel.city
        self.items = CityHistoricalDataItemsView.transformDetails(uiModel.city.weatherDetails as? Set<WeatherDetails>)
    }

    private static func transformDetails(_ details: Set<WeatherDetails>?) -> [CityHistoricalDataModel] {
        guard let weatherDetailsSet = details else {
            return []
        }
        return weatherDetailsSet
            .sorted(by: { $0.timestamp ?? Date() > $1.timestamp ?? Date() })
            .map(CityHistoricalDataModel.init)
    }
}

struct CityHistoricalDataModel: Hashable {
    let cityName: String
    let countryName: String
    let timestamp: Date
    let date: String
    let description: String
    let temperature: String
    let humidity: String
    let windSpeed: String
    let imageURL: URL?

    init(details: WeatherDetails) {
        self.timestamp = details.timestamp ?? Date()
        self.cityName = details.city?.name ?? ""
        self.countryName = details.city?.country ?? ""
        self.date = details.dateString
        self.description = details.detailsDescription
        self.temperature = details.temperatureString
        self.humidity = details.humidityString
        self.windSpeed = String(format: "%.0f km/h", details.windSpeed)

        if let url = details.imageURL, !url.isEmpty{
            let imageUrlString = Constants.baseImageURL.appending("\(url).png")
            self.imageURL = URL(string: imageUrlString)
        } else {
            self.imageURL = nil
        }
    }
}

extension WeatherDetails {
    var dateString: String {
        if let date = timestamp {
            return date.toDateString()
        } else {
            return "Unknown date"
        }
    }

    var detailsDescription: String {
        return detailedDescription ?? "Not description available"
    }

    var temperatureString: String {
        return temperature.toCelsiusString()
    }

    var humidityString: String {
        return "\(humidity)%"
    }

    var windSpeedString: String {
        return "\(windSpeed) km/h"
    }
}
