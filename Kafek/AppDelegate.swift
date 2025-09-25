//
//  AppDelegate.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 08/08/24.
//

import UIKit
import CoreLocation
import IQKeyboardManagerSwift
import FirebaseMessaging
import FirebaseCore

let kAppDelegate = UIApplication.shared.delegate as! AppDelegate

@main
class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate {
    
    var window: UIWindow?
    var coordinate1 = CLLocation(latitude: 0.0, longitude: 0.0)
    var coordinate2 = CLLocation(latitude: 0.0, longitude: 0.0)
    var CURRENT_LAT = ""
    var CURRENT_LON = ""
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        LocationManager.sharedInstance.delegate = kAppDelegate
        LocationManager.sharedInstance.startUpdatingLocation()
        
        IQKeyboardManager.shared.enable = true
        
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        notificationCenter.delegate = self
        configureNotification()
        
        for family in UIFont.familyNames {
            print("Font family: \(family)")
            for name in UIFont.fontNames(forFamilyName: family) {
                print("    \(name)")
            }
        }
        
        if k.userDefault.value(forKey: k.session.language) == nil {
            print("language not set")
            k.userDefault.set(emLang.ar.rawValue, forKey: k.session.language)
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            L102Language.setAppleLAnguageTo(lang: "ar")
            print(L102Language.currentAppleLanguage())
            L102Localizer.DoTheMagic()
        } else {
            print(L102Language.currentAppleLanguage())
            L102Localizer.DoTheMagic()
        }
        
        if #available(iOS 13.0, *) {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            tabBarAppearance.backgroundEffect = .none
            tabBarAppearance.shadowColor = .clear
            tabBarAppearance.backgroundColor = UIColor.white
            UITabBar.appearance().standardAppearance = tabBarAppearance
            if #available(iOS 15.0, *) {
                UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            }
        }
        
        UINavigationBar.appearance().isHidden = true
        Switcher.updateRootVC()
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
    }
    
    func configureNotification() {
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options:[.badge, .alert, .sound]){ (granted, error) in }
        }
        UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        Messaging.messaging().token { token, error in
            if let error = error {
                print("Error While fetching the registration token \(error)")
            } else if let token = token {
                k.iosRegisterId = token
                print("Firebase registration token is \(k.iosRegisterId)")
            }
        }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        k.iosRegisterId = deviceTokenString
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: any Error) {
        print("APNs registration failed: \(error)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        Messaging.messaging().appDidReceiveMessage(userInfo)
        print(userInfo)
        if let info = userInfo["aps"] as? Dictionary<String, AnyObject> {
            print(info)
        }
        completionHandler(.newData)
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    // MARK: WHEN USER RECEIVE THE NOTIFICATION
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let userInfo = notification.request.content.userInfo
        Messaging.messaging().appDidReceiveMessage(userInfo)
        
        print(userInfo)
        
        if let keyMessage = userInfo["key"] as? String {
            handlePresentNotification(for: keyMessage)
        }
        
        completionHandler([[.alert, .sound, .badge]])
    }
    
    // MARK: HANDLE WHEN USER RECEIVE THE NOTIFICATION
    func handlePresentNotification(for keyMessage: String) {
        
        if UIApplication.topViewController() != nil {
            DispatchQueue.main.async {
                switch keyMessage {
                case "You have a new message":
                    if let rVC = UIApplication.topViewController(), rVC is UserChatVC {
                        let rootVC = rVC as! UserChatVC
                        rootVC.getChat()
                    }
                    
                case "Request accept", "Request complete", "Request picked", "Request delivered":
                    if let rVC = UIApplication.topViewController(), rVC is UserTabBarVC {
                        let rootVC = rVC as! UserTabBarVC
                        rootVC.selectedIndex = 2
                    }
                    
                case "Message from help center":
                    print("===========\nCompiler read this message \nThis should be printed on console\n=============")
                    if let rVC = UIApplication.topViewController(), rVC is AdminChatVC {
                        let rootVC = rVC as! AdminChatVC
                        rootVC.fetchAdminChat()
                    }
                    
                case "Submitted rating review":
                    if let rVC = UIApplication.topViewController(), rVC is RatingReviewVC {
                        let rootVC = rVC as! RatingReviewVC
                        rootVC.fetchRatings()
                    }
                    
                case "Request reject", "New bid", "New bid admin", "Update bid":
                    if let rVC = UIApplication.topViewController(), rVC is ServiceOrderWaitingVC {
                        let rootVC = rVC as! ServiceOrderWaitingVC
                        if rootVC.reqViewModel.directDellivery == "Yes" {
                            rootVC.fetchBookingDetails()
                        } else {
                            rootVC.fetchBidDetails()
                        }
                    }
                    
                case "Driver change order status", "Request arrived":
                    if let rVC = UIApplication.topViewController(), rVC is ServiceOrderWaitingVC {
                        let rootVC = rVC as! ServiceOrderWaitingVC
                        rootVC.fetchBookingDetails()
                    }
                    
                default:
                    print("Key is not working")
                }
            }
        }
    }
    
    // MARK: WHEN USER CLICK ON THE NOTIFICATION
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let userInfo = response.notification.request.content.userInfo
        
        print("Tapped Notification: \(userInfo)")
        
        if let keyMessage = userInfo["key"] as? String {
            handleNotification(for: keyMessage, userInfo: userInfo)
        }
        
        completionHandler()
    }

    // MARK: HANDLE WHEN USER CLICK ON THE NOTIFICATION
    func handleNotification(for keyMessage: String, userInfo: [AnyHashable: Any]) {
        
        guard let info = userInfo as? [String: Any] else {
            print("Invalid userInfo received")
            return
        }
        
        var senderName = ""
        var message = ""
        var requestID = ""
        var notiType = ""
        var senderiD = ""
        
        // Forecast (parse) 'message' safely
        if let messageRaw = info["message"] as? String {
            let cleanedString = messageRaw.replacingOccurrences(of: "'", with: "\"")
            
            if let jsonData = cleanedString.data(using: .utf8) {
                do {
                    if let messageJSON = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                        senderName = messageJSON["noti_sender_name"] as? String ?? ""
                        message = messageJSON["noti_message"] as? String ?? ""
                        requestID = messageJSON["noti_request_id"] as? String ?? ""
                        notiType = messageJSON["noti_type"] as? String ?? ""
                        senderiD = messageJSON["noti_sender_id"] as? String ?? ""
                        
                        print("Parsed notification: \(keyMessage) | \(message) by \(senderName)")
                    } else {
                        print("Failed to cast JSON to [String: Any]")
                    }
                } catch {
                    print("JSON parsing error: \(error.localizedDescription)")
                }
            } else {
                print("Failed to convert cleaned message string to Data")
            }
        } else {
            print("message key not found or not a string")
        }
        
        // Now handle the navigation based on parsed values
        DispatchQueue.main.async {
            
            guard let topVC = UIApplication.topViewController() else {
                print("No visible view controller to navigate from.")
                return
            }
            
            switch keyMessage {
            case "You have a new message":
                if Utility.isUserLogin() {
                    let visibleVC = UIApplication.topViewController()
                    let vC = R.storyboard.main().instantiateViewController(withIdentifier: "UserChatVC") as! UserChatVC
                    vC.viewModel.receiver_Id = senderiD
                    vC.strUserName = senderName
                    vC.viewModel.request_Id = requestID
                    visibleVC?.navigationController?.pushViewController(vC, animated: true)
                } else {
                    Switcher.updateRootVC()
                }
                
            case "Request accept", "Request complete", "Request picked", "Request delivered":
                if Utility.isUserLogin() {
                    let visibleVC = UIApplication.topViewController()
                    let vC = R.storyboard.main().instantiateViewController(withIdentifier: "UserTabBarVC") as! UserTabBarVC
                    vC.selectedIndex = 1
                    visibleVC?.navigationController?.pushViewController(vC, animated: true)
                } else {
                    Switcher.updateRootVC()
                }
                
            case "Message from help center":
                print("===========\nCompiler read this message \nThis should be printed on console\n=============")
                if Utility.isUserLogin() {
                    let visibleVC = UIApplication.topViewController()
                    let vC = R.storyboard.main().instantiateViewController(withIdentifier: "AdminChatVC") as! AdminChatVC
                    visibleVC?.navigationController?.pushViewController(vC, animated: true)
                } else {
                    Switcher.updateRootVC()
                }
                
            case "Submitted rating review":
                if Utility.isUserLogin() {
                    let visibleVC = UIApplication.topViewController()
                    let vC = R.storyboard.main().instantiateViewController(withIdentifier: "RatingReviewVC") as! RatingReviewVC
                    visibleVC?.navigationController?.pushViewController(vC, animated: true)
                } else {
                    Switcher.updateRootVC()
                }
                
            case "Request reject", "Driver change order status", "Request arrived":
                if Utility.isUserLogin() {
                    if notiType == "Service" {
                        let visibleVC = UIApplication.topViewController()
                        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "ServiceOrderWaitingVC") as! ServiceOrderWaitingVC
                        vC.viewModel.orderiD = requestID
                        visibleVC?.navigationController?.pushViewController(vC, animated: true)
                        
                    } else {
                        let visibleVC = UIApplication.topViewController()
                        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "ProductOrderWaitingVC") as! ProductOrderWaitingVC
                        vC.viewModel.orderiD = requestID
                        visibleVC?.navigationController?.pushViewController(vC, animated: true)
                    }
                } else {
                    Switcher.updateRootVC()
                }
            case "New bid", "New bid admin", "Update bid":
                if Utility.isUserLogin() {
                    if notiType == "Service" {
                        let visibleVC = UIApplication.topViewController()
                        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "ServiceOrderWaitingVC") as! ServiceOrderWaitingVC
                        vC.viewModel.orderiD = requestID
                        visibleVC?.navigationController?.pushViewController(vC, animated: true)
                    } else {
                        let visibleVC = UIApplication.topViewController()
                        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "ProductOrderWaitingVC") as! ProductOrderWaitingVC
                        vC.viewModel.orderiD = requestID
                        visibleVC?.navigationController?.pushViewController(vC, animated: true)
                    }
                } else {
                    Switcher.updateRootVC()
                }
                
            default:
                print("Unhandled notification key: \(keyMessage)")
            }
        }
    }
}

extension AppDelegate: LocationManagerDelegate {
    
    func didEnterInCircularArea() {
        print("")
    }
    
    func didExitCircularArea() {
        print("")
    }
    
    func tracingLocation(currentLocation: CLLocation) {
        coordinate2 = currentLocation
        print(coordinate2)
        let distanceInMeters = coordinate1.distance(from: coordinate2) // result is in meters
        if distanceInMeters > 250 {
            CURRENT_LAT = String(currentLocation.coordinate.latitude)
            print(CURRENT_LAT)
            CURRENT_LON = String(currentLocation.coordinate.longitude)
            coordinate1 = currentLocation
            if let _ = UserDefaults.standard.value(forKey: "user_id") {
                //self.updateLatLon()
            }
        }
    }
    
    func tracingLocationDidFailWithError(error: NSError) {
        print("tracing Location Error : \(error.description)")
    }
}

