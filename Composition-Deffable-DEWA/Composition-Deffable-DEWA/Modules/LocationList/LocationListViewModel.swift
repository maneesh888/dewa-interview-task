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


class LocationListViewModel: NSObject, HTTPClient, LocationServiceable {
    
    @Published var customerServiceLocations: [CustomerServiceItem] = []
    var userLocation: CLLocation? {
        didSet {
            performSelector(inBackground: #selector(sort), with: nil)
        }
    }
    
    var currentSections: [HomeSection] = [.customerService]
    func getAllLocation() async {
        let result = await sendRequest(endpoint: LocationEndpoint.getAll, responseModel: Locations.self)
        switch result {
        case .success(let locationData):
            customerServiceLocations = locationData.getCustomerServiceCenters()
            sort()
        case .failure(let error):
            print(error)
        }
    }

    @objc func sort() {
        if let userLocation = userLocation {
            customerServiceLocations.sort { item0, item1 in
                guard let loc0 = item0.location, let loc1 = item1.location else {
                    return false
                }
                return loc0.distance(to: userLocation) < loc1.distance(to: userLocation)
                
            }
        }
    }

}

