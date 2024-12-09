//
//  CityHistoricalData.swift
//  WeatherApp
//
//  Created by Max Lukashevich on 08/12/2024.
//

import SwiftUI

struct CityHistoricalDataView: View {

    @StateObject private var viewModel: CityHistoricalDataViewModel
    @State private var isModalPresented = false

    @Environment(\.dismiss) var dismiss

    var body: some View {
        BaseContentView(title: viewModel.screenTitle,
                        leadingHeaderButton: BackButton(),
                        contentView: {
            ContentView()
        })
        .onAppear {
            viewModel.fetchRecentData()
        }
        .stateHandling(state: $viewModel.state, customLoadingState: true)
        .navigationBarBackButtonHidden(true)
    }

    init(cityModel: CityUIModel) {
        _viewModel = StateObject(wrappedValue: CityHistoricalDataViewModel(model: cityModel))
    }

    @ViewBuilder
    func BackButton() -> some View {
        HeaderBackButton(action: {
            dismiss()
        })
    }

    @ViewBuilder
    func ContentView() -> some View {
        ScrollView {
            if viewModel.state == .loading {
                ProgressView()
            }
            VStack {
                ForEach(viewModel.dataItems.items, id: \.self) { item in
                    Button(action: {
                        isModalPresented = true
                    }) {
                        ItemView(for: item)
                    }
                    .sheet(isPresented: $isModalPresented) {
                        WeatherDetailsView(model: item)
                    }

                }
            }
        }
    }

    @ViewBuilder
    func ItemView(for item: CityHistoricalDataModel) -> some View {
        VStack(spacing: 0) {
            VStack(spacing: 4) {
                HStack {
                    Text(item.date)
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.baseTextColor)
                    Spacer()
                }
                HStack {
                    Text("\(item.description.capitalized), \(item.temperature)")
                        .foregroundColor(.darkBlueColor)
                        .font(.system(size: 17, weight: .bold))
                    Spacer()
                }
            }
            .padding(.vertical, 17)
            .padding(.horizontal, 16)

            SeparatorView()
                .padding(.leading, 16)
        }
    }
}

