//
//  LocationManager.swift
//  Composition-Deffable-DEWA
//
//  Created by Maneesh M on 16/02/23.
//

import Foundation
import CoreLocation
import Combine

protocol LocationManager {
    var currentLocation: CurrentValueSubject<CLLocation?, Never> { get }
}


class CoreLocationManager: NSObject, LocationManager, ObservableObject {
    
    private let locationManager = CLLocationManager()
    @Published var currentLocation = CurrentValueSubject<CLLocation?, Never>(nil)

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func requestLocationAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
}

extension CoreLocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        currentLocation.value = location
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to retrieve user location: \(error.localizedDescription)")
    }
}

