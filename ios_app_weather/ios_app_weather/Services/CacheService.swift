//
//  CacheService.swift
//
//
//  Created by Egor Popov on 17.03.2026
//

import Foundation

// MARK: - CacheServiceProtocol
protocol CacheServiceProtocol {
    func saveForecast(_ data: ForecastResponse)
    func loadForecast() -> ForecastResponse?
    func saveCurrentWeather(_ data: CurrentWeatherResponse)
    func loadCurrentWeather() -> CurrentWeatherResponse?
}

// MARK: - CacheService
final class CacheService: CacheServiceProtocol {

    static let shared = CacheService()

    private let defaults: UserDefaults

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    func saveForecast(_ data: ForecastResponse) {
        if let encoded = try? JSONEncoder().encode(data) {
            defaults.set(encoded, forKey: .forecastKey)
        }
    }

    func loadForecast() -> ForecastResponse? {
        guard let data = defaults.data(forKey: .forecastKey) else { return nil }
        return try? JSONDecoder().decode(ForecastResponse.self, from: data)
    }

    func saveCurrentWeather(_ data: CurrentWeatherResponse) {
        if let encoded = try? JSONEncoder().encode(data) {
            defaults.set(encoded, forKey: .currentKey)
        }
    }

    func loadCurrentWeather() -> CurrentWeatherResponse? {
        guard let data = defaults.data(forKey: .currentKey) else { return nil }
        return try? JSONDecoder().decode(CurrentWeatherResponse.self, from: data)
    }
}

private extension String {
    static let forecastKey = "cached_forecast"
    static let currentKey = "cached_current"
}
