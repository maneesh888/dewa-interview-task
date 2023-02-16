//
//  LocationListViewModel.swift
//  Composition-Deffable-DEWA
//
//  Created by Maneesh M on 16/02/23.
//

import Foundation
import Combine

enum HomeSection: CaseIterable {
    case customerService
    case paymentLocations
    case waterSupply
    case evCharging
}

protocol LocationServiceable {
    var currentSections: [HomeSection] { get set }
    func getAllLocation() async
}


class LocationListViewModel: HTTPClient, LocationServiceable {
    @Published var customerServiceLocations: [CustomerServiceItem] = []
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


}

