//
//  OfficeListViewController.swift
//  Composition-Deffable-DEWA
//
//  Created by Maneesh M on 17/02/23.
//

import UIKit
import Combine

class OfficeListViewController: BaseViewController, LocationReceiver {

    var viewModel: OfficeListViewModel = OfficeListViewModel()
    typealias DataSource = UICollectionViewDiffableDataSource<HomeSection, AnyHashable>
    typealias Snapshot = NSDiffableDataSourceSnapshot<HomeSection, AnyHashable>
    var dataSource: DataSource!
    var subscriptions = Set<AnyCancellable>()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Office locations"
        createDataSource()
        bindData()
        setCollectionView()
        loadData()
        // Do any additional setup after loading the view.
    }

    // MARK: - Setup Collection View
    private func setCollectionView() {
        collectionView.setCollectionViewLayout(generateLayout(), animated: true)
        registerCells()
        collectionView.delegate = self
    }

    private func createDataSource() {
        self.dataSource = DataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OfficeLocationCollectionViewCell.cellId,
                                                          for: indexPath)
            guard let officeCell = cell as? OfficeLocationCollectionViewCell else { return cell }
            if let listableItem = itemIdentifier as? Listable {
                officeCell.item = listableItem
                officeCell.contentView.backgroundColor = ColorUtil.cellColor
            }
            return officeCell
        })
    }

    private func addItems(_ items: [AnyHashable], in section: HomeSection) {
        var snapshot = Snapshot()
        snapshot.appendSections([section])
        snapshot.appendItems(items, toSection: section)
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    private func registerCells() {
        collectionView.register(UINib(nibName: "OfficeLocationCollectionViewCell", bundle: nil),
                                forCellWithReuseIdentifier: OfficeLocationCollectionViewCell.cellId)
    }

    private func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] (section, _) -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            let _ = self.viewModel.currentSections[section]
            // create different layouts for different sections
            return self.listLayout()
        }
        return layout
    }


    func listLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2),
                                              heightDimension: .absolute(120))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let padding: CGFloat = 8
        item.contentInsets = .init(top: 4, leading: padding/2, bottom: 4, trailing: padding/2)
        let grpSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(120))
        let grpItem = NSCollectionLayoutGroup.horizontal(layoutSize: grpSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: grpItem)
        return section
    }

    // MARK: - Setup Data
    private func bindData() {
        viewModel.$officeLocations
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] items in
                guard let self = self else { return }
                self.addItems(items, in: .officeLocations)
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

    private func loadData() {
        Task {
            await viewModel.getAllOffices()
        }
    }


}

extension OfficeListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         let item = viewModel.officeLocations[indexPath.item]
            let mapDetaisl = ViewControllerFactory.getMapDetails(item: item)
            self.show(mapDetaisl, sender: nil)
        
    }
}
