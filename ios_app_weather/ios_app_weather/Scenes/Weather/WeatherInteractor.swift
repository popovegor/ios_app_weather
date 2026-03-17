//
//  WeatherInteractor.swift
//
//
//  Created by Egor Popov on 17.03.2026
//

import Foundation
import CoreLocation

final class WeatherInteractor: WeatherBusinessLogic {

    var presenter: WeatherPresentationLogic?

    private let weatherService: WeatherServiceProtocol
    private let locationService: LocationServiceProtocol
    private let cacheService: CacheServiceProtocol

    init(
        weatherService: WeatherServiceProtocol = WeatherService.shared,
        locationService: LocationServiceProtocol = LocationService.shared,
        cacheService: CacheServiceProtocol = CacheService.shared
    ) {
        self.weatherService = weatherService
        self.locationService = locationService
        self.cacheService = cacheService
    }

    func fetchWeather(_ request: Weather.FetchWeather.Request) async {
        presenter?.presentLoading()

        let coord = await locationService.requestLocation()

        do {
            async let currentResult = weatherService.fetchCurrentWeather(lat: coord.latitude, lon: coord.longitude)
            async let forecastResult = weatherService.fetchForecast(lat: coord.latitude, lon: coord.longitude, days: .forecastDays)

            let current = try await currentResult
            let forecast = try await forecastResult

            cacheService.saveCurrentWeather(current)
            cacheService.saveForecast(forecast)

            let response = Weather.FetchWeather.Response(current: current, forecast: forecast)
            presenter?.presentWeather(response)
        } catch {
            if let cachedCurrent = cacheService.loadCurrentWeather(),
               let cachedForecast = cacheService.loadForecast() {
                let response = Weather.FetchWeather.Response(current: cachedCurrent, forecast: cachedForecast)
                presenter?.presentWeather(response)
            } else {
                presenter?.presentError(.networkErrorMessage)
            }
        }
    }
}

private extension Int {
    static let forecastDays = 3
}

private extension String {
    static let networkErrorMessage = "Не удалось загрузить погоду. Проверьте подключение к интернету."
}
