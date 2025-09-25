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
    
    func requestUserAddress(vC: UIViewController, tablevW: UITableView)
    {
        Api.shared.requestToSavedAddress(vC) { [weak self] responseData in
            guard let self = self else { return }
            
            if responseData.status == "1" {
                if let res = responseData.result {
                    if res.count > 0 {
                        self.arrayUserAddress = res
                        tablevW.backgroundView = UIView()
                        tablevW.reloadData()
                    }
                }
            } else {
                self.arrayUserAddress = []
                tablevW.backgroundView = UIView()
                tablevW.reloadData()
                Utility.noDataFound(L102Language.currentAppleLanguage() == "en" ? "No new address found" : "لا يوجد عنوان جديد", k.emptyString, tableViewOt: tablevW, parentViewController: vC, appendImg: #imageLiteral(resourceName: "empty_notification"))

            }
            self.successfulResponse?()
        }
    }
    
    func requestToDeleteAddress(vC: UIViewController, address_Id: String)
    {
        var paramDict: [String : AnyObject] = [:]
        paramDict["address_id"] = address_Id as AnyObject
        
        print(paramDict)
        
        Api.shared.requestToDeletAddress(vC, paramDict) { [weak self] responseData in
            guard let self = self else { return }
            if responseData.status == "1" {
                self.deletedSuccessful?()
            } else {
                print("Something went wrong!")
            }
        }
    }
        
    func returnBack(from navigation: UINavigationController?)
    {
        navigation?.popViewController(animated: true)
    }
}
