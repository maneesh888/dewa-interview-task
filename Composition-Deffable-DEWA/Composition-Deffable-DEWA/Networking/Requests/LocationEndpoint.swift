//
//  Location.swift
//  Composition-Deffable-DEWA
//
//  Created by Maneesh M on 16/02/23.
//

import Foundation

enum LocationEndpoint: Endpoint {
    case getAll

    var path: String {
        switch self {
        case .getAll:
            return "/iphone/Locations/Locations-En.xml"
        }
    }

    var method: RequestMethod {
        switch self {
        case .getAll:
            return .get
        }
    }

    var header: [String : String]? {
        switch self {
        case .getAll:
            return nil
        }
    }

    var body: [String : String]? {
        switch self {
        case .getAll:
            return nil
        }
    }


}
