//
//  CustomerServiceCollectionViewCell.swift
//  Composition-Deffable-DEWA
//
//  Created by Maneesh M on 16/02/23.
//

import UIKit

protocol Listable {
    var titleValue: String { get }
    var addressValue: String { get }
    var distance: String { get }
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
