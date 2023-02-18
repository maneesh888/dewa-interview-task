//
//  AppTabbarViewModel.swift
//  Composition-Deffable-DEWA
//
//  Created by Maneesh M on 17/02/23.
//

import Foundation
import Combine
import CoreLocation

class AppTabBarViewModel {
    
    var locationManager:CoreLocationManager {
        return CoreLocationManager.shared
    }
    
    func requestForDeviceLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    
}

