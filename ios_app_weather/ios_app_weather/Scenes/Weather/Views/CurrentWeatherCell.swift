//
//  CurrentWeatherCell.swift
//
//
//  Created by Egor Popov on 17.03.2026
//

import UIKit

final class CurrentWeatherCell: UICollectionViewCell {

    static let reuseID = "CurrentWeatherCell"

    private let cityLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.cityName
        label.textColor = AppColors.primaryText
        label.textAlignment = .center
        return label
    }()

    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.largeTemperature
        label.textColor = AppColors.primaryText
        label.textAlignment = .center
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.weatherDescription
        label.textColor = AppColors.secondaryText
        label.textAlignment = .center
        return label
    }()

    private let highLowLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.highLow
        label.textColor = AppColors.primaryText
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError() }

    func configure(with vm: CurrentWeatherViewModel) {
        cityLabel.text = vm.city
        temperatureLabel.text = vm.temperature
        descriptionLabel.text = vm.description
        highLowLabel.text = vm.highLow
    }

    private func setupUI() {
        let stack = UIStackView(arrangedSubviews: [cityLabel, temperatureLabel, descriptionLabel, highLowLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = .stackSpacing
        stack.setCustomSpacing(.zero, after: cityLabel)

        stack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .topInset),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .horizontalInset),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.horizontalInset),
            stack.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -.horizontalInset)
        ])
    }
}

private extension CGFloat {
    static let stackSpacing: CGFloat = 4
    static let topInset: CGFloat = 40
    static let horizontalInset: CGFloat = 16
}
