//
//  HomeViewController.swift
//  Composition-Deffable-DEWA
//
//  Created by Maneesh M on 16/02/23.
//

import UIKit
import Combine

class LocationListViewController: BaseViewController, LocationReceiver {
    
    var viewModel: LocationListViewModel!
    typealias DataSource = UICollectionViewDiffableDataSource<HomeSection, AnyHashable>
    typealias Snapshot = NSDiffableDataSourceSnapshot<HomeSection, AnyHashable>
    var dataSource: DataSource!
    var subscriptions = Set<AnyCancellable>()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "Locations"
        createDataSource()
        bindData()
        setCollectionView()
        loadData()
        
        
    }
    
    // MARK: - Setup Collection View
    private func setCollectionView() {
        collectionView.setCollectionViewLayout(generateLayout(), animated: true)
        registerCells()
        collectionView.delegate = self
    }
    private func registerCells() {
        collectionView.register(UINib(nibName: "CustomerServiceCollectionViewCell", bundle: nil),
                                forCellWithReuseIdentifier: CustomerServiceCollectionViewCell.cellId)
    }
    
    private func createDataSource() {
        self.dataSource = DataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomerServiceCollectionViewCell.cellId,
                                                          for: indexPath)
            guard let detailCell = cell as? CustomerServiceCollectionViewCell else { return cell }
            if let listableItem = itemIdentifier as? Listable {
                detailCell.item = listableItem
            }
            return detailCell
        })
    }
    
    private func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] (section, _) -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            let section = self.viewModel.currentSections[section]
            // create different layouts for different sections
            return self.listLayout()
        }
        return layout
    }
    
    private func listLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .absolute(120))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let padding: CGFloat = 8
        item.contentInsets = .init(top: 0, leading: padding, bottom: 0, trailing: padding)
        let grpSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(120))
        let grpItem = NSCollectionLayoutGroup.vertical(layoutSize: grpSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: grpItem)
        return section
    }

    // MARK:- Bindig and Fetching
    private func loadData() {
        Task {
            await viewModel.getAllLocation()
        }

    }
    
    private func bindData() {
        viewModel.$customerServiceLocations
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] items in
                guard let self = self else { return }
                self.addItems(items, in: .customerService)
            }
            .store(in: &subscriptions)
        
        let locationObserver = self.receiveLocationUpdates()
        locationObserver
            .compactMap({$0})
            .sink { [weak self] location in
                guard let self = self else { return }
                self.viewModel.userLocation = location
                print("MM location ", location.coordinate)

            }.store(in: &subscriptions)
    }
    
    private func addItems(_ items: [AnyHashable], in section: HomeSection) {
        var snapshot = Snapshot()
        snapshot.appendSections([section])
        snapshot.appendItems(items, toSection: section)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension LocationListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         let item = viewModel.customerServiceLocations[indexPath.item] 
            let mapDetaisl = ViewControllerFactory.getMapDetails(item: item)
            self.show(mapDetaisl, sender: nil)
        
    }
}
