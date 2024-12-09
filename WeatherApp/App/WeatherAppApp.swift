//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Max Lukashevich on 07/12/2024.
//

import SwiftUI

@main
struct WeatherAppApp: App {

    var body: some Scene {
        WindowGroup {
            NavigationView {
                CitiesView()
            }
        }
    }
}
