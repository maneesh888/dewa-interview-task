//
//  BaseViewController.swift
//  Composition-Deffable-DEWA
//
//  Created by Maneesh M on 16/02/23.
//

import UIKit
import NotificationCenter

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      //  registerNotifications()
    }
    

//    func registerNotifications() {
//        NotificationCenter.default.addObserver(forName:  Notification.Namein, object: nil, queue: nil) { _ in
//            let isDarkModeEnabled = UserDefaults.standard.bool(forKey: "isDarkModeEnabled")
//
//            // Update your app's views with the new theme
//            self.view.applyTheme(theme)
//        }
//
//    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
            super.traitCollectionDidChange(previousTraitCollection)
        let theme: Theme = isDarkModeEnabled ? DarkTheme() : LightTheme()
        view.applyTheme(theme)
        }
}

extension UIViewController {
    var isDarkMode: Bool {
        if #available(iOS 13.0, *) {
            return self.traitCollection.userInterfaceStyle == .dark
        }
        else {
            return false
        }
    }

}
