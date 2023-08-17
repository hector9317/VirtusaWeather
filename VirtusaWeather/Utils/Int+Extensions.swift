//
//  Int+Extensions.swift
//  VirtusaWeather
//
//  Created by Hector Bautista on 16/08/23.
//

import Foundation

extension Int {
    func getDateHHMM() -> String {
        let timestamp = Double(self)
        let date = Date(timeIntervalSince1970: timestamp)
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:MM a"
        return formatter.string(from: date)
    }
    
    func getDirection() -> String {
        let directions = ["N", "NE", "E", "SE", "S", "SW", "W", "NW"]
        var degrees = self
        degrees = degrees * 8 / 360
        degrees = (degrees + 8) % 8
        return directions[degrees]
    }
}
