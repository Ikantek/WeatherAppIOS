//
//  WeatherViewModel.swift
//  WeatherAppMZ
//
//  Created by Użytkownik Gość on 05/05/2021.
//

import SwiftUI
import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    @Published private(set) var model: WeatherModel = WeatherModel(cities: ["Lubin", "Lublin", "Lublana", "Lublin", "Krakow", "Katowice"])
    
    @Published var woeId: String = ""
    @Published var message: String = "(user message)"
    
    private let fetcher: MetaWeatherFetcher
    
    private var cancellables: Set<AnyCancellable> = []
    
    func fetchWeather(forId woeId: String){
        fetcher.forecast(forId: woeId)
            .sink(receiveCompletion: {completion in print(completion)}, receiveValue: {value in print(value)})
            .store(in: &cancellables)
    }
    
    init(){
        fetcher = MetaWeatherFetcher()
        $woeId
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink(receiveValue: fetchWeather(forId:))
            .store(in: &cancellables)
    }
    
    var records: Array<WeatherModel.WeatherRecord> {
        model.records
    }
    
    func refresh(record: WeatherModel.WeatherRecord) {
        model.refresh(record: record)
    }
    
    
    func getIcon(record: WeatherModel.WeatherRecord) -> String {
        switch record.weatherState {
        case "Heavy Rain":
            return "🌧"
        case "Snow":
            return "❄️"
        case "Thunderstorm":
            return "⛈"
        case "Showers":
            return "🌦"
        default:
            return "☀️"
        }
    }
}
