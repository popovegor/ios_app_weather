//
//  AppFonts.swift
//
//
//  Created by Egor Popov on 17.03.2026
//

import UIKit

enum AppFonts {
    static let cityName = UIFont.systemFont(ofSize: .cityNameSize, weight: .medium)
    static let largeTemperature = UIFont.systemFont(ofSize: .largeTemperatureSize, weight: .thin)
    static let weatherDescription = UIFont.systemFont(ofSize: .descriptionSize, weight: .medium)
    static let highLow = UIFont.systemFont(ofSize: .descriptionSize, weight: .medium)
    static let hourlyTime = UIFont.systemFont(ofSize: .hourlyTimeSize, weight: .semibold)
    static let hourlyTemp = UIFont.systemFont(ofSize: .bodySize, weight: .semibold)
    static let dailyDay = UIFont.systemFont(ofSize: .descriptionSize, weight: .medium)
    static let dailyLow = UIFont.systemFont(ofSize: .dailyTempSize, weight: .regular)
    static let dailyHigh = UIFont.systemFont(ofSize: .dailyTempSize, weight: .medium)
    static let errorText = UIFont.systemFont(ofSize: .bodySize)
    static let retryButton = UIFont.systemFont(ofSize: .bodySize, weight: .semibold)
}

private extension CGFloat {
    static let cityNameSize: CGFloat = 34
    static let largeTemperatureSize: CGFloat = 96
    static let descriptionSize: CGFloat = 20
    static let hourlyTimeSize: CGFloat = 15
    static let bodySize: CGFloat = 17
    static let dailyTempSize: CGFloat = 18
}
