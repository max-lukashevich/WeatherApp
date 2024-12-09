//
//  BaseContentView.swift
//  WeatherApp
//
//  Created by Max Lukashevich on 08/12/2024.
//

import SwiftUI

struct BaseContentView<Content: View, LeadingButton: View, TrailingButton: View>: View {

    let title: String?
    let leadingHeaderButton: LeadingButton?
    let trailingHeaderButton: TrailingButton?
    let contentView: Content

    var body: some View {
        VStack {
            HeaderBarView(
                title: title,
                leadingButton: leadingHeaderButton,
                trailingButton: trailingHeaderButton
            )

            VStack {
                contentView
                Spacer()
            }
        }.background(
            GradientWithBackgroundView()
        )
    }

    init(
        title: String? = nil,
        leadingHeaderButton: LeadingButton? = EmptyView(),
        trailingHeaderButton: TrailingButton? = EmptyView(),
        @ViewBuilder contentView: () -> Content
    ) {
        self.title = title
        self.leadingHeaderButton = leadingHeaderButton
        self.trailingHeaderButton = trailingHeaderButton
        self.contentView = contentView()
    }

    @ViewBuilder func Background() -> some View {
        VStack {
            Spacer()
            Image("Background")
                .resizable()
                .scaledToFit()
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
}

#Preview {
    BaseContentView(title: "Title",
                    leadingHeaderButton: HeaderBackButton(action: {}),
                    trailingHeaderButton: HeaderAddButton(action: {}),
                    contentView: {
                        VStack {
                            Text("Hello")
                            Text("World")
                            Spacer()
                        }
                    })
}
