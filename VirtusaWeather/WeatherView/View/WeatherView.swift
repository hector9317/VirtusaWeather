//
//  WeatherView.swift
//  VirtusaWeather
//
//  Created by Hector Bautista on 16/08/23.
//

import SwiftUI

struct WeatherView: View {
    @State private var searchText = ""
    @ObservedObject var viewModel: WeatherViewModel
    @Environment(\.defaultMinListRowHeight) var minRowHeight

    var body: some View {
        List {
            Section {
                ForEach(viewModel.dataRows) { data in
                    HStack {
                        Text(data.key)
                            .font(.footnote)
                        Spacer()
                        Text(data.value)
                            .font(.caption)
                    }
                }
            } header: {
                LazyVStack {
                    AsyncImage(url: URL(string: viewModel.dataModel.icon))
                        .scaledToFit()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120, height: 120, alignment: .center)
                        .background(.orange)
                        .cornerRadius(20)
                    Text(viewModel.dataModel.temperature)
                        .font(.system(size: 48, weight: .light))
                        .foregroundColor(.gray)
                    Text("\(viewModel.dataModel.city)")
                        .font(.subheadline)
                    Text("\(viewModel.dataModel.main)")
                        .font(.caption)
                        .padding(.bottom, 20)
                }
            }
        }
        .scrollDisabled(true)
        .onAppear {
            viewModel.fetch()
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        let repository = RepositoryMock()
        let viewModel = WeatherViewModel(repository: repository)
        WeatherView(viewModel: viewModel)
    }
}
