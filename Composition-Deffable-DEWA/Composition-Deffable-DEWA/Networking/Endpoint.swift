//
//  Endpoint.swift
//  Composition-Deffable-DEWA
//
//  Created by Maneesh M on 16/02/23.
//

import Foundation

enum ResponseFormat {
    case json
    case xml
}

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
    var responseFormat: ResponseFormat { get }
}

extension Endpoint {
    var scheme: String {
        return "https"
    }

    var host: String {
        return "smartapps.dewa.gov.ae"
    }
}
