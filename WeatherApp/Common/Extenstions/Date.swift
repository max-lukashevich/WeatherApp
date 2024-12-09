//
//  Double.swift
//  WeatherApp
//
//  Created by Max Lukashevich on 08/12/2024.
//

import Foundation

extension Date {
    func toDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy - HH:mm"
        return formatter.string(from: self)
    }
}

