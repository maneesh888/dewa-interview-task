//
//  OfficeListViewController.swift
//  Composition-Deffable-DEWA
//
//  Created by Maneesh M on 17/02/23.
//

import UIKit
import Combine

class OfficeListViewController: BaseViewController {

    var viewModel: OfficeListViewModel = OfficeListViewModel()
    typealias DataSource = UICollectionViewDiffableDataSource<HomeSection, AnyHashable>
    typealias Snapshot = NSDiffableDataSourceSnapshot<HomeSection, AnyHashable>
    var dataSource: DataSource!
    var subscriptions = Set<AnyCancellable>()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        loadData()
    }


    private func loadData() {
        Task {
            await viewModel.getAllOffices()
        }
    }

}
