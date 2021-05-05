//
//  WeatherViewModel.swift
//  WeatherAppMZ
//
//  Created by Użytkownik Gość on 05/05/2021.
//

import Foundation

class WeatherViewModel: ObservableObject {
    @Published private(set) var model: WeatherModel = WeatherModel(cities: ["Lubin", "Lublin", "Lublana"])
    
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
