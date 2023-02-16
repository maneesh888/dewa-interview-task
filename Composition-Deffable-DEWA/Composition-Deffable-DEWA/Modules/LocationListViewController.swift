//
//  HomeViewController.swift
//  Composition-Deffable-DEWA
//
//  Created by Maneesh M on 16/02/23.
//

import UIKit
import Combine

class LocationListViewController: BaseViewController {
    
    var viewModel: LocationServiceable = LocationListViewModel()
    var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        loadData()
    }


    private func loadData() {
        Task {
            await viewModel.getAllLocation()
        }

    }
}
