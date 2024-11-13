//
//  SavedAddressViewModel.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 18/09/24.
//

import Foundation

class SavedAddressViewModel {
    
    var arrayUserAddress: [Res_SavedAddress] = []
    var successfulResponse:(() -> Void)?
    
    var deletedSuccessful:(() -> Void)?
    
    
    
    func requestUserAddress(vC: UIViewController)
    {
        Api.shared.requestToSavedAddress(vC) { responseData in
            if responseData.count > 0 {
                self.arrayUserAddress = responseData
            } else {
                self.arrayUserAddress = []
            }
            self.successfulResponse?()
        }
    }
    
    func requestToDeleteAddress(vC: UIViewController, address_Id: String)
    {
        var paramDict: [String : AnyObject] = [:]
        paramDict["address_id"] = address_Id as AnyObject
        
        print(paramDict)
        
        Api.shared.requestToDeletAddress(vC, paramDict) { responseData in
            if responseData.status == "1" {
                self.deletedSuccessful?()
            } else {
                print("Something went wrong!")
            }
        }
    }
    
    func navigateToAddAddressViewController(from navigation: UINavigationController?) {
        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "AddAddressVC") as! AddAddressVC
        navigation?.pushViewController(vC, animated: true)
    }
    
    func returnBack(from navigation: UINavigationController?)
    {
        navigation?.popViewController(animated: true)
    }
}
