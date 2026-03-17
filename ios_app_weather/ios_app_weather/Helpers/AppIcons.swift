//
//  AppIcons.swift
//
//
//  Created by Egor Popov on 17.03.2026
//

import UIKit

enum AppIcons {
    static let hourlyConfig = UIImage.SymbolConfiguration(pointSize: .hourlyPointSize)
    static let dailyConfig = UIImage.SymbolConfiguration(pointSize: .dailyPointSize)
    static let hourlySize: CGFloat = .iconSize
    static let dailySize: CGFloat = .iconSize
}

private extension CGFloat {
    static let hourlyPointSize: CGFloat = 22
    static let dailyPointSize: CGFloat = 20
    static let iconSize: CGFloat = 28
}
