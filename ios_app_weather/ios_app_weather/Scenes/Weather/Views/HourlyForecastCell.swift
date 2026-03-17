//
//  HourlyForecastCell.swift
//
//
//  Created by Egor Popov on 17.03.2026
//

import UIKit

final class HourlyForecastCell: UICollectionViewCell {

    static let reuseID = "HourlyForecastCell"

    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.hourlyTime
        label.textColor = AppColors.primaryText
        label.textAlignment = .center
        return label
    }()

    private let iconView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.tintColor = AppColors.primaryText
        iv.preferredSymbolConfiguration = AppIcons.hourlyConfig
        return iv
    }()

    private let tempLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.hourlyTemp
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

    func configure(with vm: HourViewModel) {
        timeLabel.text = vm.time
        iconView.image = UIImage(systemName: vm.iconName)
        tempLabel.text = vm.temperature
    }

    private func setupUI() {
        let stack = UIStackView(arrangedSubviews: [timeLabel, iconView, tempLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = .stackSpacing

        iconView.heightAnchor.constraint(equalToConstant: AppIcons.hourlySize).isActive = true
        iconView.widthAnchor.constraint(equalToConstant: AppIcons.hourlySize).isActive = true

        stack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .verticalInset),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -.verticalInset),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .horizontalInset),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.horizontalInset)
        ])
    }
}

private extension CGFloat {
    static let stackSpacing: CGFloat = 8
    static let verticalInset: CGFloat = 12
    static let horizontalInset: CGFloat = 4
}
