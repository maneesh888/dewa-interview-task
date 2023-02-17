//
//  LocationListViewModel.swift
//  Composition-Deffable-DEWA
//
//  Created by Maneesh M on 16/02/23.
//

import Foundation
import Combine
import CoreLocation

enum HomeSection: CaseIterable {
    case customerService
    case paymentLocations
    case waterSupply
    case evCharging
    case officeLocations
}

protocol LocationServiceable {
    var currentSections: [HomeSection] { get set }
    func getAllLocation() async
}


class LocationListViewModel: HTTPClient, LocationServiceable {
    
    @Published var customerServiceLocations: [CustomerServiceItem] = []
    @Published var userLocation: CLLocation? {
        didSet {
            sort()
        }
    }
    
    private let locationManager:CoreLocationManager
    init(locationManager:CoreLocationManager) {
        self.locationManager = locationManager
    }
    
    var currentSections: [HomeSection] = [.customerService]
    func getAllLocation() async {
        let result = await sendRequest(endpoint: LocationEndpoint.getAll, responseModel: Locations.self)
        switch result {
        case .success(let locationData):
            customerServiceLocations = locationData.getCustomerServiceCenters()
        case .failure(let error):
            print(error)
        }
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
        locationManager.requestLocationAuthorization()
    }

    func sort() {
        
    }

}

