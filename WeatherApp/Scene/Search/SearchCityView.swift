//
//  SearchCityView.swift
//  WeatherApp
//
//  Created by Max Lukashevich on 08/12/2024.
//

import SwiftUI

struct SearchCityView: View {

    @StateObject var viewModel: SearchCityViewModel = .init()
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            SearchField()
            ContentView()
        }.background(
            GradientView()
        )
        .stateHandling(state: $viewModel.state)
        .onAppear {
            viewModel.completionHandler = {
                dismiss()
            }
        }
    }

    @ViewBuilder
    func SearchField() -> some View {
        VStack(spacing: 20) {
            TitleView()
            SearchBar(
                text: $viewModel.searchText,
                submitAction: viewModel.startSearch,
                onCancel: {
                    dismiss()
                }
            )
            .disabled(viewModel.state == .loading)
        }
        .padding(.top, 20)
    }

    @ViewBuilder
    func TitleView() -> some View {
        Text("Enter city, postcode or airoport location")
            .fontWeight(.regular)
            .font(.system(size: 13))
            .foregroundColor(.baseTextColor)
    }

    @ViewBuilder
    func ContentView() -> some View {
        VStack {
            switch viewModel.state {
            case .loaded:
                CityView()
            default:
                EmptyView()
            }
            Spacer()
        }
    }

    @ViewBuilder
    func CityView() -> some View {
        if let city = viewModel.city {
            ScrollView {
                Section {
                    CityInfoRow(city: city, isItemAlreadySaved: viewModel.isItemAlreadySaved) {
                        viewModel.addCityToFavorites()
                    }
                } header: {
                    SearchResultsHeader()
                }
            }
            .padding(.top, 40)
        }
    }

    @ViewBuilder
    private func CityInfoRow(city: SearchCityUIModel, isItemAlreadySaved: Bool, onAddToFavorites: @escaping () -> Void) -> some View {
        HStack {
            Text(city.listTitle.uppercased())
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.baseTextColor)

            Spacer()

            if !isItemAlreadySaved {
                Button(action: onAddToFavorites) {
                    Image(systemName: "plus")
                        .font(.system(size: 15, weight: .bold))
                }
            } else {
                Image(systemName: "checkmark")
                    .font(.system(size: 15, weight: .bold))
            }
        }
        .padding(20)
        .background(Color.gray.opacity(0.1))
    }

    @ViewBuilder
    private func SearchResultsHeader() -> some View {
        HStack {
            Text("Search results")
                .foregroundColor(Color.gray)
                .font(.system(size: 13, weight: .light))
                .frame(alignment: .leading)
            Spacer()
        }
        .padding(.leading, 20)
    }

    @ViewBuilder
    func ProgressIndicator() -> some View {
        ZStack(alignment: .center) {
            Color.gray.opacity(0.3)
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .scaleEffect(1.5, anchor: .center)
        }
    }
}

#Preview {
    SearchCityView()
}
