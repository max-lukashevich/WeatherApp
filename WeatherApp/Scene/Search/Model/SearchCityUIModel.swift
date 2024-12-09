//
//  CityViewModel.swift
//  WeatherApp
//
//  Created by Max Lukashevich on 08/12/2024.
//

import Foundation

struct SearchCityUIModel {

    var remoteModel: RemoteCityModel

    var listTitle: String {
        "\(remoteModel.cityName), \(remoteModel.countryName)"
    }

    var name: String {
        remoteModel.cityName
    }

    var cityId: Int {
        remoteModel.cityId
    }

    init(remoteModel: RemoteCityModel) {
        self.remoteModel = remoteModel
    }
}
