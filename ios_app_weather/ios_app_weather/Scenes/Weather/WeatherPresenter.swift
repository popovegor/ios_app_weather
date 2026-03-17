//
//  WeatherPresenter.swift
//
//
//  Created by Egor Popov on 17.03.2026
//

import Foundation

final class WeatherPresenter: WeatherPresentationLogic {

    weak var view: WeatherDisplayLogic?

    func presentWeather(_ response: Weather.FetchWeather.Response) {
        let current = response.current.current
        let location = response.current.location

        let currentVM = CurrentWeatherViewModel(
            city: location.name,
            temperature: "\(Int(current.tempC.rounded()))°",
            description: current.condition.text,
            iconName: WeatherIconMapper.sfSymbol(for: current.condition.code, isDay: current.isDay == .dayValue),
            highLow: "Макс.:\(Int(response.forecast.forecast.forecastday[0].day.maxtempC.rounded()))°  Мин.:\(Int(response.forecast.forecast.forecastday[0].day.mintempC.rounded()))°"
        )

        let hourlyVMs = buildHourlyForecast(from: response.forecast)
        let dailyVMs = buildDailyForecast(from: response.forecast)

        let viewModel = Weather.FetchWeather.ViewModel(
            currentWeather: currentVM,
            hourlyForecast: hourlyVMs,
            dailyForecast: dailyVMs
        )
        view?.displayWeather(viewModel)
    }

    func presentError(_ message: String) {
        view?.displayError(message)
    }

    func presentLoading() {
        view?.displayLoading()
    }

    // MARK: - Private
    private func buildHourlyForecast(from forecast: ForecastResponse) -> [HourViewModel] {
        let now = Date()
        let calendar = Calendar.current
        let formatter = DateFormatter()
        formatter.dateFormat = .dateTimeFormat
        formatter.timeZone = TimeZone(identifier: forecast.location.tzId) ?? .current

        let hourFormatter = DateFormatter()
        hourFormatter.dateFormat = .hourFormat
        hourFormatter.timeZone = formatter.timeZone

        var hours: [HourViewModel] = []

        for forecastDay in forecast.forecast.forecastday {
            for hour in forecastDay.hour {
                guard let hourDate = formatter.date(from: hour.time) else { continue }
                if hourDate < now { continue }

                let timeStr: String
                if calendar.isDate(hourDate, equalTo: now, toGranularity: .hour) {
                    timeStr = .nowLabel
                } else {
                    timeStr = hourFormatter.string(from: hourDate)
                }

                hours.append(HourViewModel(
                    id: "\(hour.timeEpoch)",
                    time: timeStr,
                    temperature: "\(Int(hour.tempC.rounded()))°",
                    iconName: WeatherIconMapper.sfSymbol(for: hour.condition.code, isDay: hour.isDay == .dayValue)
                ))
            }
        }

        return hours
    }

    private func buildDailyForecast(from forecast: ForecastResponse) -> [DayViewModel] {
        let formatter = DateFormatter()
        formatter.dateFormat = .dateFormat
        formatter.timeZone = TimeZone(identifier: forecast.location.tzId) ?? .current

        let dayFormatter = DateFormatter()
        dayFormatter.locale = Locale(identifier: .russianLocale)
        dayFormatter.dateFormat = .dayOfWeekFormat
        dayFormatter.timeZone = formatter.timeZone

        let calendar = Calendar.current

        return forecast.forecast.forecastday.map { fd in
            let date = formatter.date(from: fd.date) ?? Date()
            let dayName: String
            if calendar.isDateInToday(date) {
                dayName = .todayLabel
            } else {
                dayName = dayFormatter.string(from: date)
            }

            return DayViewModel(
                dayOfWeek: dayName,
                iconName: WeatherIconMapper.sfSymbol(for: fd.day.condition.code),
                lowTemp: "\(Int(fd.day.mintempC.rounded()))°",
                highTemp: "\(Int(fd.day.maxtempC.rounded()))°"
            )
        }
    }
}

private extension Int {
    static let dayValue = 1
}

private extension String {
    static let dateTimeFormat = "yyyy-MM-dd HH:mm"
    static let hourFormat = "HH"
    static let dateFormat = "yyyy-MM-dd"
    static let dayOfWeekFormat = "EEEE"
    static let russianLocale = "ru_RU"
    static let nowLabel = "Сейчас"
    static let todayLabel = "Сегодня"
}
