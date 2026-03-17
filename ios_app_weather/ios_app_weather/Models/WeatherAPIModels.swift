//
//  WeatherAPIModels.swift
//
//
//  Created by Egor Popov on 17.03.2026
//

import Foundation

// MARK: - CurrentWeatherResponse
struct CurrentWeatherResponse: Codable {
    let location: Location
    let current: Current
}

// MARK: - ForecastResponse
struct ForecastResponse: Codable {
    let location: Location
    let current: Current
    let forecast: Forecast
}

// MARK: - Location
struct Location: Codable {
    let name: String
    let region: String
    let country: String
    let lat: Double
    let lon: Double
    let tzId: String
    let localtimeEpoch: Int
    let localtime: String

    enum CodingKeys: String, CodingKey {
        case name, region, country, lat, lon
        case tzId = "tz_id"
        case localtimeEpoch = "localtime_epoch"
        case localtime
    }
}

// MARK: - Current
struct Current: Codable {
    let tempC: Double
    let isDay: Int
    let condition: Condition
    let windKph: Double
    let humidity: Int
    let feelslikeC: Double

    enum CodingKeys: String, CodingKey {
        case tempC = "temp_c"
        case isDay = "is_day"
        case condition
        case windKph = "wind_kph"
        case humidity
        case feelslikeC = "feelslike_c"
    }
}

// MARK: - Condition
struct Condition: Codable {
    let text: String
    let icon: String
    let code: Int
}

// MARK: - Forecast
struct Forecast: Codable {
    let forecastday: [ForecastDay]
}

// MARK: - ForecastDay
struct ForecastDay: Codable {
    let date: String
    let dateEpoch: Int
    let day: Day
    let hour: [Hour]

    enum CodingKeys: String, CodingKey {
        case date
        case dateEpoch = "date_epoch"
        case day, hour
    }
}

// MARK: - Day
struct Day: Codable {
    let maxtempC: Double
    let mintempC: Double
    let avgtempC: Double
    let condition: Condition

    enum CodingKeys: String, CodingKey {
        case maxtempC = "maxtemp_c"
        case mintempC = "mintemp_c"
        case avgtempC = "avgtemp_c"
        case condition
    }
}

// MARK: - Hour
struct Hour: Codable {
    let timeEpoch: Int
    let time: String
    let tempC: Double
    let isDay: Int
    let condition: Condition

    enum CodingKeys: String, CodingKey {
        case timeEpoch = "time_epoch"
        case time
        case tempC = "temp_c"
        case isDay = "is_day"
        case condition
    }
}
