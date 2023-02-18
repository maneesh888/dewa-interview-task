//
//  AppTabBarViewController.swift
//  Composition-Deffable-DEWA
//
//  Created by Maneesh M on 17/02/23.
//

import UIKit

class AppTabBarViewController: UITabBarController {
    
    var viewModel: AppTabBarViewModel = AppTabBarViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let locationsListVC = ViewControllerFactory.getLocationList()
        locationsListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 0)

        let officeListVC = ViewControllerFactory.getOfficeList()
            officeListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .recents, tag: 1)

            viewControllers = [locationsListVC, officeListVC ]
        
        viewModel.requestForDeviceLocation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        viewModel.stopUpdatingLocation()
    }

}
