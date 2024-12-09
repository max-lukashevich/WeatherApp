//
//  EmptyListPlaceholderView.swift
//  WeatherApp
//
//  Created by Max Lukashevich on 08/12/2024.
//

import SwiftUI

struct EmptyListPlaceholderView: View {
    var title: String
    
    var body: some View {
        VStack {
            Spacer()
            Text(title)
                .font(.system(size: 15, weight: .bold))
                .foregroundColor(.baseTextColor)
            Spacer()
        }
    }
}

#Preview {
    EmptyListPlaceholderView(title: "Empty")
}
