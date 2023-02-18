//
//  LocationManager.swift
//  Composition-Deffable-DEWA
//
//  Created by Maneesh M on 16/02/23.
//

import UIKit
import CoreLocation
import Combine


protocol LocationReceiver {
//    var currentLocation: CurrentValueSubject<CLLocation?, Never> { get }
    func receiveLocationUpdates() -> CurrentValueSubject<CLLocation?, Never>
}

extension LocationReceiver where Self: UIViewController {
    func receiveLocationUpdates() -> CurrentValueSubject<CLLocation?, Never> {
       let manager = CoreLocationManager.shared
        CoreLocationManager.shared.startUpdatingLocation()
        return manager.currentLocation
    }
    
}

class CoreLocationManager: NSObject, ObservableObject {
    
    private let locationManager = CLLocationManager()
    
    //Singleton Instance
    static let shared: CoreLocationManager = {
        let instance = CoreLocationManager()
        // setup code
        return instance
    }()
    
    @Published var currentLocation = CurrentValueSubject<CLLocation?, Never>(nil)

    
    
    private override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }

    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
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

extension CLLocation {
    func distance(to:CLLocation)-> Double {
        let distanceInMeters = to.distance(from: self)
        return distanceInMeters.magnitude
    }
}


