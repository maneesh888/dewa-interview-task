//
//  OfficeListViewModel.swift
//  Composition-Deffable-DEWA
//
//  Created by Maneesh M on 17/02/23.
//

import Foundation
import Combine
import CoreLocation


protocol OfficeServiceable {
    func getAllOffices() async
}


class OfficeListViewModel:NSObject, HTTPClient, OfficeServiceable {
   @Published var officeLocations: [CordinateItem] = []
    var currentSections: [HomeSection] = [.officeLocations]
    
    var userLocation: CLLocation? {
        didSet {
            performSelector(inBackground: #selector(sort), with: nil)
        }
    }
    
    func getAllOffices() async {
        let result = await sendRequest(endpoint: LocationEndpoint.getAllOffice, responseModel: OfficeLocation.self)
        switch result {
        case .success(let location):
            officeLocations = location.getOfficeCoordinates()
            sort()
        case .failure(let failure):
            print(failure.localizedDescription)
        }
    }

    @objc func sort() {
        if let userLocation = userLocation {
            
            let sorted = officeLocations.sorted { item0, item1 in
                guard let loc0 = item0.location, let loc1 = item1.location else {
                    return false
                }
                return loc0.distance(to: userLocation) < loc1.distance(to: userLocation)
                
            }
            officeLocations = [] // TODO: - Need to find a better solution to avoid rendering collection view 3 times instead of two
            officeLocations = sorted
        }
    }
    
}
