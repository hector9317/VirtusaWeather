//
//  WeatherDataViewModel.swift
//  VirtusaWeather
//
//  Created by Hector Bautista on 16/08/23.
//

import Foundation

final class WeatherDataViewModel {
    let icon: String
    let temperature: String
    let city: String
    let main: String
    
    init() {
        icon = ""
        temperature = ""
        city = ""
        main = ""
    }
    
    init(icon: String, temperature: String, city: String, main: String) {
        self.icon = icon
        self.temperature = temperature
        self.city = city
        self.main = main
    }
}
