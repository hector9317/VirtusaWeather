//
//  WeatherViewModel.swift
//  VirtusaWeather
//
//  Created by Hector Bautista on 16/08/23.
//

import Combine
import Foundation

final class WeatherViewModel: ObservableObject {
    @Published var dataModel = WeatherDataViewModel()
    @Published var dataRows = [WeatherRowViewModel]()
    private var repository: RepositoryContract
    private var cancellable: AnyCancellable?
    
    init(repository: RepositoryContract) {
        self.repository = repository
    }
    
    func fetch() {
        cancellable = repository.fetch("San Francisco")
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
            }, receiveValue: { [weak self] (response: WeatherResponse) in
                self?.buildModel(weather: response)
                self?.buildRows(weather: response)
            })
    }
    
    func buildModel(weather: WeatherResponse) {
        let iconEndPoint = weather.weather.first?.icon ?? ""
        dataModel = WeatherDataViewModel(icon: String(format: EndPoints.icons, iconEndPoint),
                                         temperature: String(format: "%.2f", weather.main.temp) + "°",
                                         city: weather.name,
                                         main: weather.weather.first?.main ?? "")
    }
    
    func buildRows(weather: WeatherResponse) {
        self.dataRows = []
        dataRows.append(WeatherRowViewModel(key: "Feels like", value: "\(weather.main.feelsLike)°"))
        dataRows.append(WeatherRowViewModel(key: "Maximum Temperature", value: "\(weather.main.tempMax)°"))
        dataRows.append(WeatherRowViewModel(key: "Minimum Temperature", value: "\(weather.main.tempMin)°"))
        dataRows.append(WeatherRowViewModel(key: "Wind", value: "\(weather.wind.speed) m/s \(weather.wind.deg.getDirection())"))
        dataRows.append(WeatherRowViewModel(key: "Pressure", value: "\(weather.main.pressure) hPa"))
        dataRows.append(WeatherRowViewModel(key: "Humidity", value: "\(weather.main.humidity)%"))
        dataRows.append(WeatherRowViewModel(key: "Sunrise", value: "\(weather.sys.sunrise.getDateHHMM())"))
        dataRows.append(WeatherRowViewModel(key: "Sunset", value: "\(weather.sys.sunset.getDateHHMM())"))
    }
}
