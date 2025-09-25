//
//  InternetUtility.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 10/09/24.
//

import Foundation

let NETWORK_ERROR_MSG : String  = R.string.localizable.noInternetConnectionMakeSureYourDeviceIsConnectedToTheInternet()

class InternetUtilClass {
    
    class var sharedInstance: InternetUtilClass {
        
        struct Static {
            static let instance: InternetUtilClass = InternetUtilClass()
            static var reachability: Reachability? = Reachability.forInternetConnection()
        }
        
        return Static.instance
    }
    
    func hasConnectivity() -> Bool {
        let reachability: Reachability = Reachability.forInternetConnection()
        let networkStatus: Int = reachability.currentReachabilityStatus().rawValue
        return networkStatus != 0
    }
}

