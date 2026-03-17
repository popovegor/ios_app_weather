//
//  WeatherService.swift
//
//
//  Created by Egor Popov on 17.03.2026
//

import Foundation

// MARK: - WeatherServiceProtocol
protocol WeatherServiceProtocol {
    func fetchCurrentWeather(lat: Double, lon: Double) async throws -> CurrentWeatherResponse
    func fetchForecast(lat: Double, lon: Double, days: Int) async throws -> ForecastResponse
}

// MARK: - WeatherService
final class WeatherService: WeatherServiceProtocol {

    static let shared = WeatherService()

    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetchCurrentWeather(lat: Double, lon: Double) async throws -> CurrentWeatherResponse {
        let url = try buildURL(path: .currentPath, lat: lat, lon: lon)
        let (data, _) = try await session.data(from: url)
        return try JSONDecoder().decode(CurrentWeatherResponse.self, from: data)
    }

    func fetchForecast(lat: Double, lon: Double, days: Int) async throws -> ForecastResponse {
        var url = try buildURL(path: .forecastPath, lat: lat, lon: lon)
        url.append(queryItems: [URLQueryItem(name: .daysParam, value: "\(days)")])
        let (data, _) = try await session.data(from: url)
        return try JSONDecoder().decode(ForecastResponse.self, from: data)
    }

    private func buildURL(path: String, lat: Double, lon: Double) throws -> URL {
        guard var components = URLComponents(string: .baseURL + path) else {
            throw URLError(.badURL)
        }
        components.queryItems = [
            URLQueryItem(name: .keyParam, value: .apiKey),
            URLQueryItem(name: .queryParam, value: "\(lat),\(lon)")
        ]
        guard let url = components.url else {
            throw URLError(.badURL)
        }
        return url
    }
}

private extension String {
    static let apiKey = "fa8b3df74d4042b9aa7135114252304"
    static let baseURL = "https://api.weatherapi.com/v1"
    static let currentPath = "/current.json"
    static let forecastPath = "/forecast.json"
    static let keyParam = "key"
    static let queryParam = "q"
    static let daysParam = "days"
}
