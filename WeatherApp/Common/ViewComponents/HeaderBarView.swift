//
//  HeaderBarView.swift
//  WeatherApp
//
//  Created by Max Lukashevich on 08/12/2024.
//

import SwiftUI


struct HeaderBarView<LeadingButton: View, TrailingButton: View>: View {

    @Environment(\.colorScheme) var colorScheme

    let title: String?
    let leadingButton: LeadingButton?
    let trailingButton: TrailingButton?

    var body: some View {
        VStack {
            ZStack(alignment: .top) {
                if leadingButton != nil {
                    HStack {
                        leadingButton
                        Spacer()
                    }
                }
                if title != nil {
                    VStack {
                        Spacer(minLength: 0)
                        Text(title!.uppercased())
                            .font(.system(size: 17, weight: .bold))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.baseTextColor)
                            .lineLimit(2)
                        Spacer(minLength: 0)
                    }
                    .padding(.top, 16)
                    .frame(height: 60)
                    .padding(.horizontal, 80)
                }
                if trailingButton != nil {
                    HStack {
                        Spacer()
                        trailingButton
                    }
                }
            }
        }
    }

    init(title: String? = nil, leadingButton: LeadingButton? = nil, trailingButton: TrailingButton? = nil) {
        self.title = title
        self.leadingButton = leadingButton
        self.trailingButton = trailingButton
    }
}
