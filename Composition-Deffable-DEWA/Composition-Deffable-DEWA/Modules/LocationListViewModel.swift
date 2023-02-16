//
//  LocationListViewModel.swift
//  Composition-Deffable-DEWA
//
//  Created by Maneesh M on 16/02/23.
//

import Foundation

protocol LocationServiceable {
    func getAllLocation() async -> Result<Locations, RequestError>
}


class LocationListViewModel: HTTPClient, LocationServiceable {
    func getAllLocation() async -> Result<Locations, RequestError> {
        return await sendRequest(endpoint: LocationEndpoint.getAll, responseModel: Locations.self)
    }


}
