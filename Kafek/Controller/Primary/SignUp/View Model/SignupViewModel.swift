//
//  SignupViewModel.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 10/09/24.
//

import Foundation

class SignupViewModel {
    
    var userFirstName = ""
    var userLastName = ""
    var userEmail = ""
    var userMobile = ""
    var userPassword = ""
    var userAddress = ""
    var userLat = 0.0
    var userLon = 0.0
    var userConfirmPassword = ""
    var strCheck = ""
    var phoneKey:String! = "966"
    
    var showErrorMessage:(() -> Void)?
    
    var cloSuccessfullSendOtp: (() -> Void)?
    
    var errorMessage: String? {
        didSet {
            self.showErrorMessage?()
        }
    }
        
    func navigateToHomeVC(from navigationController: UINavigationController?,viewController: UIViewController) {
    }
    
    func returnBack(from navigationController: UINavigationController?) {
        navigationController?.popViewController(animated: true)
    }
}

extension SignupViewModel {
    
    func isValidInput() -> Bool {
        if userFirstName.isEmpty {
            errorMessage = R.string.localizable.pleaseEnterTheFirstName()
            return false
        } else if userLastName.isEmpty {
            errorMessage = R.string.localizable.pleaseEnterTheLastName()
            return false
        } else if !Utility.isValidEmail(userEmail) {
            errorMessage = L102Language.currentAppleLanguage() == "en" ? "Please enter the valid email address" : "الرجاء إدخال عنوان بريد إلكتروني صالح"
            return false
        } else if !Utility.isValidMobileNumber(userMobile) {
            errorMessage = L102Language.currentAppleLanguage() == "en" ? "Please enter the valid mobile number" : "الرجاء إدخال رقم جوال صالح"
            return false
        } else if userPassword.isEmpty {
            errorMessage = R.string.localizable.pleaseEnterThePassword()
            return false
        } else if userConfirmPassword.isEmpty {
            errorMessage = R.string.localizable.pleaseEnterTheConfirmPassword()
            return false
        } else if userPassword != userConfirmPassword {
            errorMessage = R.string.localizable.passwordIsNotMatched()
            return false
        } else if strCheck.isEmpty {
            errorMessage = R.string.localizable.pleaseReadTheTermsAndConditionsForProceed()
            return false
        }
        return true
    }
    
    func WebVerifyNumber(vC: UIViewController, shouldNavigate: Bool = true) {
        
        guard self.isValidInput() else { return }
        
        var param: [String : AnyObject] = [:]
        param["mobile"] = userMobile as AnyObject
        param["mobile_with_code"] = "\(phoneKey ?? "")\(userMobile)" as AnyObject
        param["type"] = "USER" as AnyObject
        
        print(param)
        
        Api.shared.requestToSendOtp(vC, param) { [weak self] responseData in
            guard let self else { return }
            collectParamDetails()
            print(collectParamDetails())
            print("The Verification code is: === \(responseData.code ?? "")")
            k.userDefault.set(responseData.code ?? "", forKey: k.session.verificationCode)
            print(k.userDefault.set(responseData.code ?? "", forKey: k.session.verificationCode))
            if shouldNavigate {
                self.cloSuccessfullSendOtp?()
            }
        }
    }
    
    func collectParamDetails()
    {
        dictSignup["first_name"] = userFirstName as AnyObject
        dictSignup["last_name"] = userLastName as AnyObject
        dictSignup["email"] = userEmail as AnyObject
        dictSignup["password"] = userPassword as AnyObject
        dictSignup["mobile"] = userMobile as AnyObject
        dictSignup["mobile_with_code"] = "\(phoneKey ?? "")\(userMobile)" as AnyObject
        dictSignup["address"] = userAddress as AnyObject
        dictSignup["lat"] = userLat as AnyObject
        dictSignup["lon"] = userLon as AnyObject
        dictSignup["type"] = "USER" as AnyObject
        dictSignup["register_id"] = k.emptyString as AnyObject
        dictSignup["date_time"] = Utility.getCurrentTime() as AnyObject
        dictSignup["ios_register_id"] = k.iosRegisterId as AnyObject
    }
}

