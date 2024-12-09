//
//  WeatherDetailsViewModel.swift
//  WeatherApp
//
//  Created by Max Lukashevich on 08/12/2024.
//

import Foundation

class WeatherDetailsViewModel: BaseViewModel {

    let screenTitle: String
    let bottomTitle: String

    let model: CityHistoricalDataModel

    init(model: CityHistoricalDataModel) {
        self.model = model
        self.screenTitle = "\(model.cityName) \(model.countryName)"
        self.bottomTitle = "Weather information for \(model.cityName) received on \n\(model.date)".uppercased()

        super.init()
    }

}
