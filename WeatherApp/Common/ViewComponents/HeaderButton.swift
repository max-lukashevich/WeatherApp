//
//  HeaderButton.swift
//  WeatherApp
//
//  Created by Max Lukashevich on 08/12/2024.
//

import SwiftUI

struct HeaderBackButton: View {

    let action: (() -> Void)

    var body: some View {
        Button(action: {
            action()
        }) {
            ZStack(alignment: .center) {
                Image("Button_left")
                Image(systemName: "arrow.backward")
                    .foregroundColor(.white)
                    .padding(.leading, -28)
                    .padding(.bottom, 38)
            }
        }
    }
}

struct HeaderAddButton: View {

    let action: (() -> Void)

    var body: some View {
        Button(action: {
            action()
        }) {
            ZStack(alignment: .center) {
                Image("Button_right")
                Image(systemName: "plus")
                    .foregroundColor(.white)
                    .padding(.leading, 35)
                    .padding(.bottom, 38)
            }
        }
    }
}

struct HeaderCloseButton: View {

    let action: (() -> Void)

    var body: some View {
        Button(action: {
            action()
        }) {
            ZStack(alignment: .center) {
                Image("Button_modal")
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .padding(.leading, -25)
                    .padding(.bottom, 38)
            }
        }
    }
}

#Preview {
    HeaderBackButton(action: {})
}

#Preview {
    HeaderAddButton(action: {})
}

#Preview {
    HeaderCloseButton(action: {})
}
