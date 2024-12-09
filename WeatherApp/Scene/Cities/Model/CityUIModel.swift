//
//  CityUIModel.swift
//  WeatherApp
//
//  Created by Max Lukashevich on 08/12/2024.
//

import Foundation

struct CityUIModel: Identifiable, Hashable {

    var id: ObjectIdentifier

    let city: City

    var cityName: String {
        city.name ?? "Unknown"
    }

    var countryName: String {
        city.country ?? "Unknown"
    }

    var listTitle: String {
        "\(cityName), \(countryName)"
    }

    init(city: City) {
        self.city = city
        self.id = city.id
    }
}
