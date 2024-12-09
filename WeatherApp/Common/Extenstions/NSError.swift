//
//  NSError.swift
//  WeatherApp
//
//  Created by Max Lukashevich on 09/12/2024.
//

import Foundation

@objc class NSErrorHelper: NSObject {
    @objc static func weatherAppError(code: Int, description: String) -> NSError {
        return NSError.weatherAppError(code: code, description: description)
    }
}

extension NSError {
    static func weatherAppError(code: Int, description: String) -> NSError {
        return NSError(domain: "com.test.weatherapp", code: code, userInfo: [NSLocalizedDescriptionKey: description])
    }
}
