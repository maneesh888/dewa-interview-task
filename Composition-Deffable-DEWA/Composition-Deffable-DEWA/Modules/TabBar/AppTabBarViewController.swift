//
//  AppTabBarViewController.swift
//  Composition-Deffable-DEWA
//
//  Created by Maneesh M on 17/02/23.
//

import UIKit

class AppTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let locationsListVC = ViewControllerFactory.getLocationList()
        locationsListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 0)

        let officeListVC = ViewControllerFactory.getOfficeList()
            officeListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .recents, tag: 1)

            viewControllers = [locationsListVC, officeListVC ]
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
