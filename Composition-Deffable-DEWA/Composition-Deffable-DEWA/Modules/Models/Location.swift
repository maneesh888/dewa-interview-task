//
//  Location.swift
//  Composition-Deffable-DEWA
//
//  Created by Maneesh M on 16/02/23.
//

import Foundation

import Foundation
import XMLParsing

// MARK: - Locations
struct Locations: Codable {
    let customerService: CustomerService?
    let paymentLocations, waterSupply: PaymentLocations?
    let evCharge: EVCharge?

    private enum CodingKeys: String, CodingKey {
        case customerService = "CustomerService"
        case paymentLocations = "PaymentLocations"
        case waterSupply = "WaterSupply"
        case evCharge = "EVCharge"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.customerService = try container.decodeIfPresent(CustomerService.self, forKey: .customerService)
        self.paymentLocations = try container.decodeIfPresent(PaymentLocations.self, forKey: .paymentLocations)
        self.waterSupply = try container.decodeIfPresent(PaymentLocations.self, forKey: .waterSupply)
        self.evCharge = try container.decodeIfPresent(EVCharge.self, forKey: .evCharge)
    }
}

// MARK: - CustomerService
struct CustomerService: Codable {
    let item: [CustomerServiceItem]
}

// MARK: - CustomerServiceItem
struct CustomerServiceItem: Codable {
    let id: Int?
    let code: String?
    let latitude, longitude: Double?
    let title, address, addressdetails, addressline1: String?
    let landmark: String?
    let city: String?
    let countrycode: String?
    let zipcode, officenumber, callcenternumber, emergencynumber: String?
    let workinghours: String?
    let website: String?
    let email: String?
    let makaninumber, contacttext, businesscardtext: String?
    let businesscardlink: String?
    let image, map: String?
  //  let services: Services?
}

// MARK: - Services
struct Services: Codable {
    let p: [String]
}

// MARK: - EVCharge
struct EVCharge: Codable {
    let item: [EVChargeItem]
}

// MARK: - EVChargeItem
struct EVChargeItem: Codable {
    let id: Int?
    let code, name, catg: String?
    let address: String?
    let lat, lon: Double?
    let city: String?
    let ccode: String?
    let status, whrs: String?
    let fimage: String?
    let pimage: String?
    let iimage: String?
    let phone: String?
    let evphone: String?
    let web: String?
    let wname: String?
    let ctype: String?
}


// MARK: - PaymentLocations
struct PaymentLocations: Codable {
    let item: [PaymentLocationsItem]
}

// MARK: - PaymentLocationsItem
struct PaymentLocationsItem: Codable {
    let id: Int?
    let catg: String?
    let lat, lon: Double?
    let name: String?
    let city: String?
    let ccode: String?
    let whrs: String?
    let fimage, pimage: String?
    let iimage: String?
    let phone: String?
    let web: String?
    let wname: String?
}
