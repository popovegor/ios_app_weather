//
//  DailyForecastCell.swift
//
//
//  Created by Egor Popov on 17.03.2026
//

import UIKit

final class DailyForecastCell: UICollectionViewCell {

    static let reuseID = "DailyForecastCell"

    private let dayLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.dailyDay
        label.textColor = AppColors.primaryText
        return label
    }()

    private let iconView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.tintColor = AppColors.primaryText
        iv.preferredSymbolConfiguration = AppIcons.dailyConfig
        return iv
    }()

    private let lowLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.dailyLow
        label.textColor = AppColors.tertiaryText
        label.textAlignment = .right
        return label
    }()

    private let highLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.dailyHigh
        label.textColor = AppColors.primaryText
        label.textAlignment = .right
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError() }

    func configure(with vm: DayViewModel) {
        dayLabel.text = vm.dayOfWeek
        iconView.image = UIImage(systemName: vm.iconName)
        lowLabel.text = vm.lowTemp
        highLabel.text = vm.highTemp
    }

    private func setupUI() {
        let tempStack = UIStackView(arrangedSubviews: [lowLabel, highLabel])
        tempStack.axis = .horizontal
        tempStack.spacing = .stackSpacing

        let mainStack = UIStackView(arrangedSubviews: [dayLabel, iconView, tempStack])
        mainStack.axis = .horizontal
        mainStack.alignment = .center
        mainStack.spacing = .stackSpacing

        dayLabel.widthAnchor.constraint(equalToConstant: .dayLabelWidth).isActive = true
        iconView.widthAnchor.constraint(equalToConstant: AppIcons.dailySize).isActive = true
        lowLabel.widthAnchor.constraint(equalToConstant: .tempLabelWidth).isActive = true
        highLabel.widthAnchor.constraint(equalToConstant: .tempLabelWidth).isActive = true

        mainStack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(mainStack)
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .verticalInset),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -.verticalInset),
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .horizontalInset),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.horizontalInset)
        ])
    }
}

private extension CGFloat {
    static let stackSpacing: CGFloat = 8
    static let dayLabelWidth: CGFloat = 110
    static let tempLabelWidth: CGFloat = 40
    static let verticalInset: CGFloat = 8
    static let horizontalInset: CGFloat = 16
}
