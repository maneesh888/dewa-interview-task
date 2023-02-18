//
//  CustomerServiceCollectionViewCell.swift
//  Composition-Deffable-DEWA
//
//  Created by Maneesh M on 16/02/23.
//

import UIKit
import CoreLocation

protocol Listable {
    var titleValue: String { get }
    var addressValue: String { get }
    var distance: String { get }
    var latitude: Double? { get }
    var longitude: Double? { get }
}

extension Listable {
    var location: CLLocation? {
        guard let longitude = longitude, let latitude = latitude else { return nil }
        return CLLocation(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude))
    }
    
    var distance: String {
        
        guard let userLocation = CoreLocationManager.shared.currentLocation.value, let entityLocation = self.location else {return "-"}
        
        let distanceInKM = userLocation.distance(to: entityLocation).rounded()/1000
        
        
        return "\(distanceInKM) KM"

    }
}

class CustomerServiceCollectionViewCell: UICollectionViewCell {

    static let cellId = "detailsCellIdentifier"

    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!

    var item: Listable? {
        didSet {
            guard let item = self.item else { return }
            setValue(item)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    private func setValue(_ item: Listable) {
        titleLabel.text = item.titleValue
        addressLabel.text = item.addressValue
        distanceLabel.text = item.distance
    }
}
