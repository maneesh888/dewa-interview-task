//
//  ViewControllerFactory.swift
//  Composition-Deffable-DEWA
//
//  Created by Maneesh M on 16/02/23.
//

import Foundation

struct ViewControllerFactory {
    static func getLocationList()-> LocationListViewController {
        let vc = LocationListViewController(nibName: "LocationListViewController", bundle: nil)
        vc.viewModel = LocationListViewModel()
        return vc
    }
    
    static func getOfficeList()-> OfficeListViewController {
        let vc = OfficeListViewController(nibName: "OfficeListViewController", bundle: nil)
        vc.viewModel = OfficeListViewModel()
        return vc
    }
    
    static func getTabBar()-> AppTabBarViewController {
        let vc = AppTabBarViewController()
        return vc
    }
    
    static func getMapDetails(item:Listable)-> MapDetailsViewController {
        let vc = MapDetailsViewController(nibName: "MapDetailsViewController", bundle: nil)
        vc.item = item
        return vc
    }
}


