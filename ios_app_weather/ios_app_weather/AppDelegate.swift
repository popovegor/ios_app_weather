//
//  AppDelegate.swift
//
//
//  Created by Egor Popov on 17.03.2026
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: .defaultConfiguration, sessionRole: connectingSceneSession.role)
    }
}

private extension String {
    static let defaultConfiguration = "Default Configuration"
}
