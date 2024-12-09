//
//  ErrorPopupModifier.swift
//  WeatherApp
//
//  Created by Max Lukashevich on 08/12/2024.
//

import SwiftUI

struct StateHandlingModifier: ViewModifier {
    @Binding var state: ViewModelState
    let customLoadingState: Bool
    func body(content: Content) -> some View {
        content
            .overlay(
                Group {
                    if case .loading = state {
                        if !customLoadingState {
                            ProgressIndicator()
                        }
                    } else if case .error(let error) = state {
                        ErrorPopup(error: error)
                    }
                }
            )
    }

    @ViewBuilder
    func ProgressIndicator() -> some View {
        ZStack {
            Color.gray.opacity(0.3).ignoresSafeArea()
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .scaleEffect(1.5)
        }
    }

    @ViewBuilder
    func ErrorPopup(error: IdentifiableError) -> some View {
        VStack(spacing: 16) {
            Text("Ups, something went wrong")
                .font(.headline)
                .foregroundColor(.red)
            Text(error.popUpDescriptionText)
                .multilineTextAlignment(.center)
                .padding()
            Button("OK") {
                if case .error = state {
                    state = .idle
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 10)
        .frame(maxWidth: 300)
    }
}

extension View {
    func stateHandling(state: Binding<ViewModelState>, customLoadingState: Bool = false) -> some View {
        modifier(StateHandlingModifier(state: state, customLoadingState: customLoadingState))
    }
}
