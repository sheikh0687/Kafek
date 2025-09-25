//
//  Switcher.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 10/09/24.
//

import Foundation

class Switcher {
    
    static func updateRootVC()
    {
        let status = k.userDefault.bool(forKey: k.session.status)
        
        if status == true {
            let mainViewController = R.storyboard.main().instantiateViewController(withIdentifier: "UserTabBarVC") as! UserTabBarVC
            let vC = UINavigationController(rootViewController: mainViewController)
            kAppDelegate.window?.rootViewController = vC
            kAppDelegate.window?.makeKeyAndVisible()
        } else {
            if isLogout {
                let mainViewController = R.storyboard.main().instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                let vC = UINavigationController(rootViewController: mainViewController)
                kAppDelegate.window?.rootViewController = vC
                kAppDelegate.window?.makeKeyAndVisible()
            } else {
                let mainViewController = R.storyboard.main().instantiateViewController(withIdentifier: "LandingVC") as! LandingVC
                let vC = UINavigationController(rootViewController: mainViewController)
                kAppDelegate.window?.rootViewController = vC
                kAppDelegate.window?.makeKeyAndVisible()
            }
        }
    }
}

//class Switcher {
//
//    static func updateRootVC() {
//        let storyboard = R.storyboard.main()
//        guard let window = kAppDelegate.window else {
//            print("⚠️ AppDelegate window is nil")
//            return
//        }
//
//        if k.userDefault.bool(forKey: k.session.status) {
//            window.rootViewController = UINavigationController(
//                rootViewController: storyboard.instantiateViewController(withIdentifier: "UserTabBarVC")
//            )
//        } else {
//            window.rootViewController = UINavigationController(
//                rootViewController: storyboard.instantiateViewController(withIdentifier: "LandingVC")
//            )
//        }
//
//        window.makeKeyAndVisible()
//
//        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil)
//        let status = k.userDefault.bool(forKey: k.session.status)
//
//        let storyboard = R.storyboard.main()
//        
//        var rootVC: UIViewController
//
//        if status {
//            // Logged in: go to UserTabBarVC
//            rootVC = storyboard.instantiateViewController(withIdentifier: "UserTabBarVC")
//        } else {
//            // Not logged in: go to LandingVC
//            rootVC = storyboard.instantiateViewController(withIdentifier: "LandingVC")
//        }
//
//        let navigationController = UINavigationController(rootViewController: rootVC)
//
//        if let window = kAppDelegate.window {
//            window.rootViewController = navigationController
//            window.makeKeyAndVisible()
//
//            // Optional: Smooth transition
//            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil)
//        } else {
//            print("⚠️ AppDelegate window is nil")
//        }
//    }
//}
