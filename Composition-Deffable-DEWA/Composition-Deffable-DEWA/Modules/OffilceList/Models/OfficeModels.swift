//
//  OfficeModels.swift
//  Composition-Deffable-DEWA
//
//  Created by Maneesh M on 17/02/23.
//

import Foundation

// MARK: - Welcome
struct OfficeLocation: Codable {
    let locationsApp: LocationsApp?

    enum CodingKeys: String, CodingKey {
        case locationsApp = "LocationsApp"
    }

    func getOfficeCoordinates() -> [CordinateItem] {
        return self.locationsApp?.cordinate?.item ?? []
    }
}

// MARK: - LocationsApp
struct LocationsApp: Codable {
    let fileVer, dist: String?
    let cordinate: Cordinate?

    enum CodingKeys: String, CodingKey {
        case fileVer = "FileVer"
        case dist = "Dist"
        case cordinate = "Cordinate"
    }
}

// MARK: - Cordinate
struct Cordinate: Codable {
    let item: [CordinateItem]
}

// MARK: - Item
struct CordinateItem: Codable, Hashable {
    let id, office, lat, lon: String?
    let loc: String?

    static func == (lhs: CordinateItem, rhs: CordinateItem) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension CordinateItem: Listable {
    var titleValue: String {
        return self.office ?? "-"
    }

    var addressValue: String {
        return ""
    }

    var distance: String {
        if let lat = self.lat, let lon = self.lon {
            return "Lat: \(lat), Lon \(lon)"
        }
        return "-"

    }


}
