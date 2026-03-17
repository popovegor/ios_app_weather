//
//  WeatherViewController.swift
//
//
//  Created by Egor Popov on 17.03.2026
//

import UIKit

// MARK: - WeatherViewController
final class WeatherViewController: UIViewController {

    var interactor: WeatherBusinessLogic?

    private var viewModel: Weather.FetchWeather.ViewModel?

    // MARK: - UI
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        cv.backgroundColor = .clear
        cv.showsVerticalScrollIndicator = false
        cv.dataSource = self
        cv.register(CurrentWeatherCell.self, forCellWithReuseIdentifier: CurrentWeatherCell.reuseID)
        cv.register(HourlyForecastCell.self, forCellWithReuseIdentifier: HourlyForecastCell.reuseID)
        cv.register(DailyForecastCell.self, forCellWithReuseIdentifier: DailyForecastCell.reuseID)
        return cv
    }()

    private let activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(style: .large)
        ai.color = AppColors.primaryText
        ai.hidesWhenStopped = true
        return ai
    }()

    private let errorLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.errorText
        label.textColor = AppColors.primaryText
        label.textAlignment = .center
        label.numberOfLines = .zero
        label.isHidden = true
        return label
    }()

    private let retryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(.retryTitle, for: .normal)
        button.titleLabel?.font = AppFonts.retryButton
        button.setTitleColor(AppColors.primaryText, for: .normal)
        button.backgroundColor = AppColors.buttonBackground
        button.layer.cornerRadius = .buttonCornerRadius
        button.isHidden = true
        return button
    }()

    private let gradientLayer = CAGradientLayer()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradient()
        setupUI()
        retryButton.addTarget(self, action: #selector(retryTapped), for: .touchUpInside)

        Task { [weak self] in
            await self?.interactor?.fetchWeather(Weather.FetchWeather.Request())
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = view.bounds
    }

    // MARK: - Private
    @objc private func retryTapped() {
        Task { [weak self] in
            await self?.interactor?.fetchWeather(Weather.FetchWeather.Request())
        }
    }

    private func setupGradient() {
        gradientLayer.colors = [
            AppColors.gradientTop.cgColor,
            AppColors.gradientBottom.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: .gradientCenter, y: .zero)
        gradientLayer.endPoint = CGPoint(x: .gradientCenter, y: .gradientEnd)
        view.layer.insertSublayer(gradientLayer, at: 0)
    }

    private func setupUI() {
        for v in [collectionView, activityIndicator, errorLabel, retryButton] as [UIView] {
            v.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(v)
        }

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: .errorLabelOffset),
            errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .errorLabelPadding),
            errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.errorLabelPadding),

            retryButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: .retryButtonTopSpacing),
            retryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            retryButton.widthAnchor.constraint(equalToConstant: .retryButtonWidth),
            retryButton.heightAnchor.constraint(equalToConstant: .retryButtonHeight)
        ])
    }

    // MARK: - Layout
    private enum SectionIndex: Int, CaseIterable {
        case current, hourly, daily
    }

    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { sectionIndex, _ in
            guard let section = SectionIndex(rawValue: sectionIndex) else { return nil }
            switch section {
            case .current:
                return Self.currentSection()
            case .hourly:
                return Self.hourlySection()
            case .daily:
                return Self.dailySection()
            }
        }
    }

    private static func currentSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(.currentSectionHeight)
        ))
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(.currentSectionHeight)),
            subitems: [item]
        )
        return NSCollectionLayoutSection(group: group)
    }

    private static func hourlySection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .absolute(.hourlyItemWidth),
            heightDimension: .estimated(.hourlyItemHeight)
        ))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(.hourlyItemWidth), heightDimension: .estimated(.hourlyItemHeight)),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: .sectionVerticalInset, leading: .sectionHorizontalInset, bottom: .sectionVerticalInset, trailing: .sectionHorizontalInset)
        section.interGroupSpacing = .hourlyGroupSpacing
        return section
    }

    private static func dailySection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(.dailyItemHeight)
        ))
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(.dailyItemHeight)),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: .sectionVerticalInset, leading: .sectionHorizontalInset, bottom: .sectionHorizontalInset, trailing: .sectionHorizontalInset)
        return section
    }
}

// MARK: - UICollectionViewDataSource
extension WeatherViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        SectionIndex.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let vm = viewModel, let s = SectionIndex(rawValue: section) else { return .zero }
        switch s {
        case .current: return 1
        case .hourly:  return vm.hourlyForecast.count
        case .daily:   return vm.dailyForecast.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let vm = viewModel, let s = SectionIndex(rawValue: indexPath.section) else {
            return UICollectionViewCell()
        }
        switch s {
        case .current:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrentWeatherCell.reuseID, for: indexPath) as! CurrentWeatherCell
            cell.configure(with: vm.currentWeather)
            return cell
        case .hourly:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyForecastCell.reuseID, for: indexPath) as! HourlyForecastCell
            cell.configure(with: vm.hourlyForecast[indexPath.item])
            return cell
        case .daily:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DailyForecastCell.reuseID, for: indexPath) as! DailyForecastCell
            cell.configure(with: vm.dailyForecast[indexPath.item])
            return cell
        }
    }
}

// MARK: - WeatherDisplayLogic
extension WeatherViewController: WeatherDisplayLogic {

    func displayWeather(_ viewModel: Weather.FetchWeather.ViewModel) {
        activityIndicator.stopAnimating()
        errorLabel.isHidden = true
        retryButton.isHidden = true
        collectionView.isHidden = false

        self.viewModel = viewModel
        collectionView.reloadData()
    }

    func displayError(_ message: String) {
        activityIndicator.stopAnimating()
        collectionView.isHidden = true
        errorLabel.text = message
        errorLabel.isHidden = false
        retryButton.isHidden = false
    }

    func displayLoading() {
        collectionView.isHidden = true
        errorLabel.isHidden = true
        retryButton.isHidden = true
        activityIndicator.startAnimating()
    }
}

private extension CGFloat {
    static let buttonCornerRadius: CGFloat = 12
    static let errorLabelOffset: CGFloat = -30
    static let errorLabelPadding: CGFloat = 32
    static let retryButtonTopSpacing: CGFloat = 16
    static let retryButtonWidth: CGFloat = 120
    static let retryButtonHeight: CGFloat = 44
    static let currentSectionHeight: CGFloat = 220
    static let hourlyItemWidth: CGFloat = 64
    static let hourlyItemHeight: CGFloat = 100
    static let dailyItemHeight: CGFloat = 50
    static let sectionVerticalInset: CGFloat = 8
    static let sectionHorizontalInset: CGFloat = 16
    static let hourlyGroupSpacing: CGFloat = 4
    static let gradientCenter: CGFloat = 0.5
    static let gradientEnd: CGFloat = 1
}

private extension String {
    static let retryTitle = "Повторить"
}
