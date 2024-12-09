//
//  WeatherDetailsView.swift
//  WeatherApp
//
//  Created by Max Lukashevich on 08/12/2024.
//

import SwiftUI
import Kingfisher

struct WeatherDetailsView: View {

    @StateObject var viewModel: WeatherDetailsViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        BaseContentView(
            title: viewModel.screenTitle,
            leadingHeaderButton: CloseButton(),
            contentView: {
                ContentView()
            })
    }

    init(model: CityHistoricalDataModel) {
        _viewModel = StateObject(wrappedValue: WeatherDetailsViewModel(model: model))
    }

    @ViewBuilder
    func CloseButton() -> some View {
        HeaderCloseButton(action: {
            dismiss()
        })
    }

    @ViewBuilder
    func ContentView() -> some View {
        VStack {
            DetailView()
            Spacer()
            BottomTitleView()
        }
        .ignoresSafeArea()
    }
    @ViewBuilder
    func DetailView() -> some View {
        VStack(spacing: 53) {
            IconView()
                .padding(.top, 55)

            DescriptionContent()
                .padding(.bottom, 50)
        }
        .background(
            RoundedRectangle(cornerRadius: 45)
                .foregroundColor(.white)
        )
        .padding(.horizontal, 50)
    }
    @ViewBuilder
    func DescriptionContent() -> some View {
        VStack(spacing: 17) {
            DescriptionField(title: "Description", value: viewModel.model.description)
            DescriptionField(title: "Temperature", value: viewModel.model.temperature)
            DescriptionField(title: "Humidity", value: viewModel.model.humidity)
            DescriptionField(title: "Wind speed", value: viewModel.model.windSpeed)
        }
        .padding(.horizontal, 30)
    }

    @ViewBuilder
    func DescriptionField(title: String, value: String) -> some View {
        HStack(alignment: .bottom) {
            Text(title.uppercased())
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(.baseTextColor)
            Spacer()
            Text(value)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.darkBlueColor)
        }
    }

    @ViewBuilder
    func BottomTitleView() -> some View {
        Text(viewModel.bottomTitle)
            .multilineTextAlignment(.center)
            .lineLimit(2)
            .lineSpacing(2)
            .font(.system(size: 12, weight: .regular))
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
    }

    @ViewBuilder
    func IconView() -> some View {
        if let imageURL = viewModel.model.imageURL {
            KFImage(imageURL)
                .resizable()
                .renderingMode(.template)
                .scaledToFit()
                .frame(width: 120, height: 90)
                .foregroundColor(.darkBlueColor)
        }
    }
}
