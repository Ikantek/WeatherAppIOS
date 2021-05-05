//
//  WeatherAppMZApp.swift
//  WeatherAppMZ
//
//  Created by Użytkownik Gość on 05/05/2021.
//

import SwiftUI

@main
struct WeatherAppMZApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: WeatherViewModel())
        }
    }
}
