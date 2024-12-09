//
//  BaseViewModel.swift
//  WeatherApp
//
//  Created by Max Lukashevich on 08/12/2024.
//

import Foundation

enum ViewModelState: Equatable {
    case idle
    case loading
    case loaded
    case error(IdentifiableError)

    static func == (lhs: ViewModelState, rhs: ViewModelState) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle),
             (.loading, .loading),
             (.loaded, .loaded):
            return true
        case (.error(let lhsError), .error(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
}

class BaseViewModel: ObservableObject {
    @Published var state: ViewModelState = .idle
}
