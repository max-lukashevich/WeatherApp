//
//  CitiesView.swift
//  WeatherApp
//
//  Created by Max Lukashevich on 08/12/2024.
//

import SwiftUI

struct CitiesView: View {

    @StateObject var viewModel: CitiesViewModel = .init()

    @State private var showSearchView = false

    var body: some View {
        BaseContentView(title: "Cities",
                        trailingHeaderButton: AddButton(),
                        contentView: {
            ContentView()
        })
        .sheet(isPresented:  $showSearchView) {
            SearchView()
        }
        .stateHandling(state: $viewModel.state)
    }

    @ViewBuilder
    func AddButton() -> some View {
        HeaderAddButton(action: {
            showSearchView = true
        })
    }

    @ViewBuilder
    func SearchView() -> some View {
        SearchCityView()
    }

    @ViewBuilder
    func ContentView() -> some View {
        if viewModel.items.isEmpty {
            EmptyListPlaceholderView(title: "No cities added yet")
        } else {
            ItemsList()
        }
    }

    @ViewBuilder
    func ItemsList() -> some View {
        List {
            ForEach($viewModel.items, id: \.self) { item in
                ItemView(item: item.wrappedValue)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets())
            }
            .onDelete(perform: delete)
        }
        .listStyle(PlainListStyle())
        .scrollContentBackground(.hidden)
    }

    func delete(at offsets: IndexSet) {
        withAnimation {
            viewModel.deleteItem(at: offsets)
        }
    }

    @ViewBuilder
    func ItemView(item: CityUIModel) -> some View {
        ZStack {
            NavigationLink(destination: CityHistoricalDataView(cityModel: item)) {
                EmptyView()
            }.opacity(0.0)
            VStack(spacing: 0) {
                HStack {
                    HStack {
                        Text(item.listTitle.uppercased())
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(.baseTextColor)
                        Spacer()
                    }
                    .padding(.vertical, 15)
                    .padding(.horizontal, 16)

                    Spacer()

                    Image(systemName: "chevron.right")
                        .foregroundColor(.darkBlueColor)
                        .frame(width: 16, height: 22)
                        .padding(.trailing, 16)
                }
                SeparatorView()
                    .padding(.leading, 16)
            }
        }
    }
}

#Preview {
    CitiesView()
}
