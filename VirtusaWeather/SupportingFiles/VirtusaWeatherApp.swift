//
//  VirtusaWeatherApp.swift
//  VirtusaWeather
//
//  Created by Hector Bautista on 16/08/23.
//

import SwiftUI

@main
struct VirtusaWeatherApp: App {
    var body: some Scene {
        WindowGroup {
            let repository = RepositoryMock()
            let viewModel = WeatherViewModel(repository: repository)
            WeatherView(viewModel: viewModel)
        }
    }
}
