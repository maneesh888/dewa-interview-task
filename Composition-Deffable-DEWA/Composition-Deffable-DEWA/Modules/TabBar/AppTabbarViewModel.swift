//
//  AppTabbarViewModel.swift
//  Composition-Deffable-DEWA
//
//  Created by Maneesh M on 17/02/23.
//

import Foundation
import Combine
import CoreLocation

class AppTabBarViewModel: ObservableObject {
    
    @Published var userLocation: CLLocation?
    private var subscriptions = Set<AnyCancellable>()
    
    var locationManager:CoreLocationManager
    
    init(locationManager: CoreLocationManager) {
        self.locationManager = locationManager
    }
    
    func requestForDeviceLocation() {
        locationManager.currentLocation
                    .map { location in
                        guard let location = location else {
                            return nil
                            
                        }
                        let coordinate = location
                        return coordinate
                    }
                    .assign(to: &$userLocation)
        locationManager.startUpdatingLocation()
    }
    
    
}

