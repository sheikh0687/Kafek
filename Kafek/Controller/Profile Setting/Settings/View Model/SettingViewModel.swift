//
//  SettingViewModel.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 12/03/25.
//

import Foundation

class SettingViewModel {
    
    var userName:String = ""
    var userImg:String = ""
    var strUserPassword:String = ""
    var cloSuccess:(()->Void)?
    
    func getUserDetails(vC: UIViewController) {
        Api.shared.requestTopUserProfile(vC) { [weak self] responseData in
            guard let self = self else { return }
            
            let obj = responseData.result!
            
            self.userName = obj.first_name ?? ""
            self.userImg = obj.image ?? ""
            self.strUserPassword = obj.password ?? ""
            print(obj.password ?? "")
            self.cloSuccess?()
        }
    }
    
    var cloDeleted:(() -> Void)?
    
    func deleteAccount(vC: UIViewController) {
        Api.shared.requestToDeleteUserAccount(vC) { [weak self] responseData in
            guard let self = self else { return }
            
            if responseData.status == "1" {
                self.cloDeleted?()
            } else {
                print("This Api is not working")
            }
        }
    }
}
