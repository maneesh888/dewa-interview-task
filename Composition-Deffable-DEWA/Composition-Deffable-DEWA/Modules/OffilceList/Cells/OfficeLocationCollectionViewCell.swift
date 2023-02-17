//
//  OfficeLocationCollectionViewCell.swift
//  Composition-Deffable-DEWA
//
//  Created by Maneesh M on 17/02/23.
//

import UIKit

class OfficeLocationCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    var item: Listable? {
        didSet {
            guard let item = self.item else { return }
            setValue(item)
        }
    }
    static let cellId = "officeLocationCellIdentifier"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    private func setValue(_ item: Listable) {
        titleLabel.text = item.titleValue
        distanceLabel.text = item.distance
    }

}
