//
//  AddAddressViewModel.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 19/09/24.
//

import Foundation

class AddAddressViewModel {
    
    var address: String = ""
    var addressType:String = "Home"
    var addressLat:Double = 0.0
    var addressLon:Double = 0.0
    
    var showErrorMessage:(() -> Void)?
    var successResponse:(() -> Void)?
    
    var errorMessage: String? {
        didSet {
            showErrorMessage?()
        }
    }
    
    func requestAddress(vC: UIViewController)
    {
        guard isValidInputs() else { return }
        
        var paramDict: [String : AnyObject] = [:]
        paramDict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        paramDict["address"] = address as AnyObject
        paramDict["lat"] = addressLat as AnyObject
        paramDict["lon"] = addressLon as AnyObject
        paramDict["addresstype"] = addressType as AnyObject
        
        print(paramDict)
        
        Api.shared.requestToAddAddress(vC, paramDict) { responseData in
            self.successResponse?()
        }
    }
    
    func returnBack(from navigation: UINavigationController?) {
        navigation?.popViewController(animated: true)
    }
    
    func isValidInputs() -> Bool {
        if address.isEmpty {
            errorMessage = "Please select the address"
            return false
        }
        return true
    }
}
