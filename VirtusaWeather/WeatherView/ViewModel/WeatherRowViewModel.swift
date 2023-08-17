//
//  WeatherRowViewModel.swift
//  VirtusaWeather
//
//  Created by Hector Bautista on 16/08/23.
//

import Combine
import Foundation

final class WeatherRowViewModel: Identifiable {
    let key: String
    let value: String
    
    init(key: String, value: String) {
        self.key = key
        self.value = value
    }
}
