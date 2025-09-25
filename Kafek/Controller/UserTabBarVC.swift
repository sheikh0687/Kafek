//
//  UserTabBarVC.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 08/08/24.
//

import UIKit

class UserTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
//        updateTabBarTitles()
    }
    
//    private func updateTabBarTitles() {
//        // Assuming tab at index 1 is the one you want to update
//        if let viewControllers = self.viewControllers {
//            let vC0 = viewControllers[0]
//            let vC1 = viewControllers[1]
//            let vC2 = viewControllers[2]
////            let vC3 = viewControllers[3]
//            if LanguageManager.shared.currentLanguage == .en {
//                print("English Tab")
//                vC0.tabBarItem.title = "Home"
//                vC1.tabBarItem.title = "Bookings"
//                vC2.tabBarItem.title = "Settings"
////                            vC3.tabBarItem.title = "Settings".localiz()
//            } else {
//                print("Arabic Tab")
//                vC0.tabBarItem.title = "أخرى"
//                vC1.tabBarItem.title = "الحجوزات"
//                vC2.tabBarItem.title = "الإعدادات"
//            }
//
//            // Check the current language and update the title accordingly
//        }
//    }
}
//vC1.tabBarItem.title = "Shops".localiz()
