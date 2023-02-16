//
//  ViewControllerFactory.swift
//  Composition-Deffable-DEWA
//
//  Created by Maneesh M on 16/02/23.
//

import Foundation

struct ViewControllerFactory {
    static func getHomeScreen()-> HomeViewController {
        let vc = HomeViewController(nibName: "HomeViewController", bundle: nil)
        return HomeViewController()
    }
}


