//
//  SearchBar.swift
//  WeatherApp
//
//  Created by Max Lukashevich on 08/12/2024.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @FocusState private var isFocused: Bool
    var submitAction: () -> Void
    var onCancel: () -> Void

    var body: some View {
        HStack {
            TextField("Search", text: $text)
                .padding(8)
                .padding(.horizontal, 24)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .focused($isFocused)
                .keyboardType(.webSearch)
                .onSubmit({
                    submitAction()
                })
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)

                        if !text.isEmpty {
                            Button(action: {
                                text = ""
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }

                )

            Button("Cancel") {
                onCancel()
            }
            .padding(.trailing, 8)
        }
        .padding(.horizontal)
    }
}

#Preview {
    SearchBar(text: .constant(""), submitAction: {}, onCancel: {})
}
