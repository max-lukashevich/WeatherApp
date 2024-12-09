//
//  Date.swift
//  WeatherApp
//
//  Created by Max Lukashevich on 08/12/2024.
//

import Foundation

extension Double {
    func toCelsiusString() -> String {
        let celsius = self - 273.15
        let roundedCelsius = Int(celsius.rounded())
        return "\(roundedCelsius)°C"
    }
}
