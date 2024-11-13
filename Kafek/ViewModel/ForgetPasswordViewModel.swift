//
//  ForgetPasswordViewModel.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 10/09/24.
//

import Foundation

class ForgetPasswordViewModel {
    
    var userEmail: String = ""
    
    var showErrorMessage:(() -> Void)?
    var passwordResetSuccess:(() -> Void)?
    
    var errorMessage: String? {
        didSet {
            self.showErrorMessage?()
        }
    }
    
    func isValidInputs() -> Bool {
        if userEmail.isEmpty {
            errorMessage = "Please enter the email address"
            return false
        }
        return true
    }
    
    func requestToResetPassword(vC: UIViewController)
    {
        guard isValidInputs() else { return }
        
        var param: [String : AnyObject] = [:]
        param["email"] = userEmail as AnyObject
        
        print(param)
        
        Api.shared.requestToResetPassword(vC, param) { responseData in
            if responseData.status == "1" {
                self.passwordResetSuccess?()
            } else {
                Utility.showAlertMessage(withTitle: k.appName, message: responseData.message ?? "", delegate: nil, parentViewController: vC)
            }
        }
    }
}
