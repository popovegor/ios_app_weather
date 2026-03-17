//
//  WeatherModels.swift
//
//
//  Created by Egor Popov on 17.03.2026
//

import Foundation

enum Weather {
    enum FetchWeather {
        struct Request {}

        struct Response {
            let current: CurrentWeatherResponse
            let forecast: ForecastResponse
        }

        struct ViewModel {
            let currentWeather: CurrentWeatherViewModel
            let hourlyForecast: [HourViewModel]
            let dailyForecast: [DayViewModel]
        }
    }
}

// MARK: - CurrentWeatherVM
struct CurrentWeatherViewModel: Hashable, Sendable {
    let city: String
    let temperature: String
    let description: String
    let iconName: String
    let highLow: String
}

// MARK: - HourVM
struct HourViewModel: Hashable, Sendable {
    let id: String
    let time: String
    let temperature: String
    let iconName: String
}

// MARK: - DayVM
struct DayViewModel: Hashable, Sendable {
    let dayOfWeek: String
    let iconName: String
    let lowTemp: String
    let highTemp: String
}
