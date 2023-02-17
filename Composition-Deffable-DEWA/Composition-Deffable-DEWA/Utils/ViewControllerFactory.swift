//
//  ViewControllerFactory.swift
//  Composition-Deffable-DEWA
//
//  Created by Maneesh M on 16/02/23.
//

import Foundation

struct ViewControllerFactory {
    static func getLocationListVC()-> LocationListViewController {
        let vc = LocationListViewController(nibName: "LocationListViewController", bundle: nil)
        vc.viewModel = LocationListViewModel(locationManager: CoreLocationManager())
        return vc
    }
    
    static func getOfficeListVC()-> OfficeListViewController {
        let vc = OfficeListViewController(nibName: "OfficeListViewController", bundle: nil)
        vc.viewModel = OfficeListViewModel()
        return vc
    }
    
    
    
}


