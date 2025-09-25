//
//  EditProfileViewModel.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 12/03/25.
//

import Foundation

class EditProfileViewModel {
    
    var arrayDataOfProfle: Res_Login!
    
    var strFirstName:String = ""
    var strLastName:String = ""
    var strMobile:String = ""
    var strEmail:String = ""
    var phoneKey:String! = "966"
    
    var imageProfile = UIImage()
    
    var showErrorMessage:(() -> Void)?
    var responseSuccess: (() -> Void)?
    
    var errorMessage: String? {
        didSet {
            showErrorMessage?()
        }
    }
    
    func requestToGetProfile(vC: UIViewController)
    {
        Api.shared.requestTopUserProfile(vC) { [weak self] responseData in
            guard let self = self else { return }
            
            let obj = responseData.result!
            self.arrayDataOfProfle = obj
            self.responseSuccess?()
        }
    }
    
    var cloUpdateProfileSuccessful: (() -> Void)?
    
    func requestToUpdateProfile(vC: UIViewController) {
        
        guard isAllInputs() else { return }
        
        var paramDict: [String : String] = [:]
        paramDict["user_id"] = k.userDefault.value(forKey: k.session.userId) as? String
        paramDict["first_name"] = strFirstName
        paramDict["last_name"] = strLastName
        paramDict["mobile"] = strMobile
        paramDict["mobile_with_code"] = "\(phoneKey ?? "")\(strMobile)"
        paramDict["email"] = strEmail
        
        print(paramDict)
        
        var imageParamDict: [String : UIImage] = [:]
        imageParamDict["image"] = imageProfile
        
        print(imageParamDict)
        
        Api.shared.requestToUpdateProfile(vC, paramDict, images: imageParamDict, videos: [:]) { [weak self] responseData in
            guard let self = self else { return }
            
            self.cloUpdateProfileSuccessful?()
        }
    }
    
    func isAllInputs() -> Bool {
        if strFirstName.isEmpty || strLastName.isEmpty || strEmail.isEmpty || strMobile.isEmpty {
            errorMessage = R.string.localizable.pleaseEnterTheRequiredDetails()
            return false
        } else if !Utility.isValidEmail(strEmail) {
            errorMessage = L102Language.currentAppleLanguage() == "en" ? "Please enter the valid email address" : "الرجاء إدخال عنوان بريد إلكتروني صالح"
            return false
        } else if !Utility.isValidMobileNumber(strMobile) {
            errorMessage = L102Language.currentAppleLanguage() == "en" ? "Please enter the valid mobile number" : "الرجاء إدخال رقم جوال صالح"
            return false
        }
        return true
    }
}
