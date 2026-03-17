//
//  WeatherConfigurator.swift
//
//
//  Created by Egor Popov on 17.03.2026
//

import UIKit

enum WeatherConfigurator {

    static func configure() -> WeatherViewController {
        let viewController = WeatherViewController()
        let interactor = WeatherInteractor(
            weatherService: WeatherService.shared,
            locationService: LocationService.shared,
            cacheService: CacheService.shared
        )
        let presenter = WeatherPresenter()

        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.view = viewController

        return viewController
    }
}
