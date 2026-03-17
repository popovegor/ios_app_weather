//
//  SceneDelegate.swift
//
//
//  Created by Egor Popov on 17.03.2026
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = WeatherConfigurator.configure()
        window.makeKeyAndVisible()
        self.window = window
    }
}
