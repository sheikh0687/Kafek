//
//  LoginViewModel.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 10/09/24.
//

import Foundation
import DropDown

class LoginViewModel {
    
    var userEmail: String = ""
    var userPassword: String = ""
    var userMobile: String = ""
    var phoneKey:String! = "966"
    
    var showErrorMessage:(() -> Void)?
    var loginSuccess:(() -> Void)?
    var cloUpdateLanguage:(() -> Void)?
    
    var dropDown = DropDown()
    
    var errorMessage: String? {
        didSet {
            showErrorMessage?()
        }
    }
        
    func configureDropDown(sender: UIButton, vC: UIViewController)
    {
        dropDown.anchorView = sender
        dropDown.show()
        switch L102Language.currentAppleLanguage() {
        case "en":
            dropDown.dataSource = ["English","Arabic"]
            dropDown.bottomOffset = CGPoint(x: -60, y: 40)
        default:
            dropDown.dataSource = ["الإنجليزية","العربية"]
            dropDown.bottomOffset = CGPoint(x: 280, y: 40)
        }
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            
            guard let self = self else { return }
            
            if index == 0 {
                k.userDefault.set(emLang.en.rawValue, forKey: k.session.language)
                L102Language.setAppleLAnguageTo(lang: "en")
                let _: UIView.AnimationOptions = .transitionFlipFromLeft
                UIView.appearance().semanticContentAttribute = .forceLeftToRight
            } else  {
                k.userDefault.set(emLang.ar.rawValue, forKey: k.session.language)
                L102Language.setAppleLAnguageTo(lang: "ar")
                UIView.appearance().semanticContentAttribute = .forceRightToLeft
            }
            Switcher.updateRootVC()
        }
    }
}

extension LoginViewModel {
    
    func isValidInputs() -> Bool {
        if userMobile.isEmpty {
            errorMessage = R.string.localizable.pleaseEnterTheMobileNumber()
            return false
        } else if !Utility.isValidMobileNumber(userMobile) {
            errorMessage = L102Language.currentAppleLanguage() == "en" ? "Please enter the valid mobile number" : "الرجاء إدخال رقم جوال صالح"
            return false
        } else if userPassword.isEmpty {
            errorMessage = R.string.localizable.pleaseEnterThePassword()
            return false
        }
        return true
    }
    
    func requestToLoginUser(vC: UIViewController, mobile: String, password: String, strPhoneKey: String)
    {
        self.userEmail = ""
        self.userPassword = password
        self.userMobile = mobile
        self.phoneKey = strPhoneKey
        
        guard self.isValidInputs() else { return }
        
        var param: [String : AnyObject] = [:]
        param["email"] = userEmail as AnyObject
        param["mobile"] = userMobile as AnyObject
        param["mobile_with_code"] = "\(phoneKey ?? "")\(userMobile)" as AnyObject
        param["password"] = userPassword as AnyObject
        param["register_id"] = k.emptyString as AnyObject
        param["ios_register_id"] = k.iosRegisterId as AnyObject
        param["type"] = "USER" as AnyObject
        param["lat"] = k.emptyString as AnyObject
        param["lon"] = k.emptyString as AnyObject
        
        print(param)
        
        Api.shared.requestToLogin(vC, param) { [weak self] responseData in
            guard let self = self else { return }
            
            let obj = responseData
            k.userDefault.set(true, forKey: k.session.status)
            k.userDefault.set(obj.id, forKey: k.session.userId)
            k.userDefault.set(obj.email, forKey: k.session.userEmail)
            k.userDefault.set("\(obj.first_name ?? "") \(obj.last_name ?? "")", forKey: k.session.userName)
            k.userDefault.set(obj.mobile, forKey: k.session.userMobile)
            k.userDefault.set(obj.password, forKey: k.session.userPassword)
            k.userDefault.set(obj.wallet, forKey: k.session.userWallet)
            self.loginSuccess?()
        }
    }
    
    func updateLanguage(vC: UIViewController, appLan: String)
    {
        var paramDict: [String : AnyObject] = [:]
        paramDict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject
        paramDict["app_language"] = appLan as AnyObject
        
        print(paramDict)
        
        Api.shared.requestToUpdateLanguage(vC, paramDict) { [weak self] responseData in
            guard let self = self else { return }
            self.cloUpdateLanguage?()
        }
    }
}
