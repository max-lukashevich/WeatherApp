//
//  IdentifiableError.swift
//  WeatherApp
//
//  Created by Max Lukashevich on 08/12/2024.
//

import Foundation

struct IdentifiableError: Identifiable, Error {
    let id = UUID()
    let underlyingError: Error

    init(_ error: Error) {
        self.underlyingError = error
    }
}

extension IdentifiableError {
    var popUpDescriptionText: String {
        if let error = self.underlyingError as NSError? {
            if let description = error.userInfo[NSLocalizedDescriptionKey] as? String {
                return description
            } else {
                return "Please try again"
            }
        } else {
            return localizedDescription
        }
    }
}
