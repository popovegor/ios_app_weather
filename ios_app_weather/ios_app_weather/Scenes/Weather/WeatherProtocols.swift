//
//  WeatherProtocols.swift
//
//
//  Created by Egor Popov on 17.03.2026
//

import Foundation

// MARK: - WeatherBusinessLogic
protocol WeatherBusinessLogic {
    func fetchWeather(_ request: Weather.FetchWeather.Request) async
}

// MARK: - WeatherPresentationLogic
protocol WeatherPresentationLogic {
    func presentWeather(_ response: Weather.FetchWeather.Response)
    func presentError(_ message: String)
    func presentLoading()
}

// MARK: - WeatherDisplayLogic
protocol WeatherDisplayLogic: AnyObject {
    func displayWeather(_ viewModel: Weather.FetchWeather.ViewModel)
    func displayError(_ message: String)
    func displayLoading()
}
