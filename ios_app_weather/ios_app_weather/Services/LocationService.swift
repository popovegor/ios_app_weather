//
//  LocationService.swift
//
//
//  Created by Egor Popov on 17.03.2026
//

import CoreLocation

private extension Double {
    static let moscowLatitude: Double = 55.7558
    static let moscowLongitude: Double = 37.6173
}

// MARK: - LocationServiceProtocol
protocol LocationServiceProtocol {
    func requestLocation() async -> CLLocationCoordinate2D
}

// MARK: - LocationService
final class LocationService: NSObject, LocationServiceProtocol {
    static let shared = LocationService()

    private static let moscow = CLLocationCoordinate2D(
        latitude: .moscowLatitude,
        longitude: .moscowLongitude
    )

    private var continuation: CheckedContinuation<CLLocationCoordinate2D, Never>?
    private lazy var manager: CLLocationManager = {
        let m = CLLocationManager()
        m.delegate = self
        m.desiredAccuracy = kCLLocationAccuracyKilometer
        return m
    }()

    func requestLocation() async -> CLLocationCoordinate2D {
        let status = manager.authorizationStatus
        if status == .denied || status == .restricted {
            return Self.moscow
        }

        return await withCheckedContinuation { continuation in
            self.continuation = continuation
            if status == .notDetermined {
                manager.requestWhenInUseAuthorization()
            } else {
                manager.requestLocation()
            }
        }
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationService: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let coord = locations.first?.coordinate ?? Self.moscow
        continuation?.resume(returning: coord)
        continuation = nil
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        continuation?.resume(returning: Self.moscow)
        continuation = nil
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        guard continuation != nil else { return }
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.requestLocation()
        case .denied, .restricted:
            continuation?.resume(returning: Self.moscow)
            continuation = nil
        default:
            break
        }
    }
}
