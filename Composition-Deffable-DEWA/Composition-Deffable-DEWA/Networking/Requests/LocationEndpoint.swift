//
//  Location.swift
//  Composition-Deffable-DEWA
//
//  Created by Maneesh M on 16/02/23.
//

import Foundation

enum LocationEndpoint: Endpoint {
    
case getAll
case getAllOffice
    
    var path: String {
        switch self {
        case .getAll:
            return "/iphone/Locations/Locations-En.xml"
        case .getAllOffice:
            return "/dev/DewaLocations.json"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .getAll, .getAllOffice:
            return .get
        }
    }
    
    var header: [String : String]? {
        switch self {
        case .getAll, .getAllOffice:
            return nil
        }
    }
    
    var body: [String : String]? {
        switch self {
        case .getAll, .getAllOffice:
            return nil
        }
    }
    
    var responseFormat: ResponseFormat {
        switch self {
        case .getAll:
            return .xml
        case .getAllOffice:
            return .json
        }
    }
    
    var host: String {
        switch self {
        case .getAll:
            return "smartapps.dewa.gov.ae"
        case .getAllOffice:
            return "smartoffice.dewa.gov.ae"
        }
        
    }
    
}
