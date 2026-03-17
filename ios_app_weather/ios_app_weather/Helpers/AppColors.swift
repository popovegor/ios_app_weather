//
//  AppColors.swift
//
//
//  Created by Egor Popov on 17.03.2026
//

import UIKit

enum AppColors {
    static let primaryText = UIColor.white
    static let secondaryText = UIColor.white.withAlphaComponent(.secondaryAlpha)
    static let tertiaryText = UIColor.white.withAlphaComponent(.tertiaryAlpha)
    static let buttonBackground = UIColor.white.withAlphaComponent(.buttonAlpha)
    static let gradientTop = UIColor(red: .gradientTopRed, green: .gradientTopGreen, blue: .gradientTopBlue, alpha: 1)
    static let gradientBottom = UIColor(red: .gradientBottomRed, green: .gradientBottomGreen, blue: .gradientBottomBlue, alpha: 1)
}

private extension CGFloat {
    static let secondaryAlpha: CGFloat = 0.9
    static let tertiaryAlpha: CGFloat = 0.6
    static let buttonAlpha: CGFloat = 0.2
    static let gradientTopRed: CGFloat = 0.30
    static let gradientTopGreen: CGFloat = 0.56
    static let gradientTopBlue: CGFloat = 0.88
    static let gradientBottomRed: CGFloat = 0.18
    static let gradientBottomGreen: CGFloat = 0.37
    static let gradientBottomBlue: CGFloat = 0.72
}
