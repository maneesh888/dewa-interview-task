//
//  OfficeListViewModel.swift
//  Composition-Deffable-DEWA
//
//  Created by Maneesh M on 17/02/23.
//

import Foundation
import Combine


protocol OfficeServiceable {
    func getAllOffices() async
}


class OfficeListViewModel: HTTPClient, OfficeServiceable {
   @Published var officeLocations: [CordinateItem] = []
    var currentSections: [HomeSection] = [.officeLocations]
    func getAllOffices() async {
        let result = await sendRequest(endpoint: LocationEndpoint.getAllOffice, responseModel: OfficeLocation.self)
        switch result {
        case .success(let location):
            officeLocations = location.getOfficeCoordinates()
        case .failure(let failure):
            print(failure.localizedDescription)
        }
    }

    
}
