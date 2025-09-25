//
//  ChangePasswordVC.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 14/08/24.
//

import UIKit

class ChangePasswordVC: UIViewController {
    
    @IBOutlet weak var txt_OldPassword: UITextField!
    @IBOutlet weak var txt_NewPassword: UITextField!
    @IBOutlet weak var txt_ConfirmPassword: UITextField!
    @IBOutlet weak var lbl_Headline: UILabel!
    
    @IBOutlet weak var currentPasswordVw: UIView!
    let viewModel = ChangePasswordViewModel()
    
    var userPassword = ""
    var decodedString = ""
    var isComingFrom: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(userPassword)
        self.txt_OldPassword.delegate = self
        self.txt_NewPassword.delegate = self
        self.txt_ConfirmPassword.delegate = self
        self.convertIntoString()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        self.lbl_Headline.text = R.string.localizable.resetPassword()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
        
    @IBAction func btn_back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func convertIntoString()
    {
        if let data = Data(base64Encoded: userPassword),
           let decodedString = String(data: data, encoding: .utf8) {
            print("Decoded String: \(decodedString)")
            self.decodedString = decodedString
        } else {
            print("Invalid Base64 string")
        }
    }
        
    @IBAction func btn_Submit(_ sender: UIButton) {
        if isValidInputs() {
          requestToChangePassword()
        }
    }
}

extension ChangePasswordVC {
    
    func requestToChangePassword()
    {
        var paramDict: [String : AnyObject] = [:]
        paramDict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        paramDict["old_password"] = txt_OldPassword.text  as AnyObject
        paramDict["password"] = txt_NewPassword.text as AnyObject
        
        print(paramDict)
        
        Api.shared.requestToChangePassword(self, paramDict) { [weak self] responseData in
            guard let self else { return }
            
            if responseData.status == "1" {
                Utility.showAlertWithAction(withTitle: k.appName, message: R.string.localizable.yourPasswordHasBeenSuccessfullyChanged(), delegate: nil, parentViewController: self) { bool in
                    isLogout = true
                    Switcher.updateRootVC()
                }
            } else {
                print("Something went wrong")
            }
        }
    }
    
    
    //                if isComingFrom == "ForgetPassword" {
    //                } else {
    //                    Utility.showAlertWithAction(withTitle: k.appName, message: R.string.localizable.yourPasswordHasBeenSuccessfullyChanged(), delegate: nil, parentViewController: self) { bool in
    //                        self.navigationController?.popViewController(animated: true)
    //                    }
    //                }

    
//    func isValidInputs() -> Bool {
//        if (txt_OldPassword.text?.isEmpty)! {
//            self.alert(alertmessage: R.string.localizable.pleaseEnterTheCorrectPassword())
//            return false
//        } else if decodedString != txt_OldPassword.text {
//            self.alert(alertmessage: R.string.localizable.pleaseEnterTheCorrectPassword())
//            return false
//        } else if (txt_NewPassword.text?.isEmpty)! {
//            self.alert(alertmessage: R.string.localizable.pleaseEnterTheNewPassword())
//            return false
//        } else if decodedString == txt_NewPassword.text {
//            self.alert(alertmessage: R.string.localizable.pleaseEnterTheNewPassword())
//            return false
//        } else if (txt_ConfirmPassword.text?.isEmpty)! {
//            self.alert(alertmessage: R.string.localizable.pleaseEnterTheConfirmPassword())
//            return false
//        } else if txt_NewPassword.text != txt_ConfirmPassword.text {
//            self.alert(alertmessage: R.string.localizable.passwordMismatchedPleaseEnterTheSamePassword())
//            return false
//        }
//        return true
//    }
    
    func isValidInputs() -> Bool {
        let lang = L102Language.currentAppleLanguage() // Assuming your language helper
        
//        if (txt_OldPassword.text?.isEmpty ?? true) {
//            self.alert(alertmessage: lang == "ar" ? "الرجاء إدخال كلمة المرور القديمة" : "Please enter the old password")
//            return false
//        } else
//        
//        if decodedString != txt_OldPassword.text || userPassword != txt_OldPassword.text {
//            self.alert(alertmessage: lang == "ar" ? "كلمة المرور القديمة غير صحيحة" : "Old password is incorrect")
//            return false
//        } else
        
        if (txt_NewPassword.text?.isEmpty ?? true) {
            self.alert(alertmessage: lang == "ar" ? "الرجاء إدخال كلمة المرور الجديدة" : "Please enter the new password")
            return false
        } else if decodedString == txt_NewPassword.text || userPassword == txt_NewPassword.text {
            self.alert(alertmessage: lang == "ar" ? "كلمة المرور الجديدة يجب أن تكون مختلفة عن القديمة" : "New password must be different from old password")
            return false
        } else if (txt_ConfirmPassword.text?.isEmpty ?? true) {
            self.alert(alertmessage: lang == "ar" ? "الرجاء تأكيد كلمة المرور" : "Please confirm the password")
            return false
        } else if txt_NewPassword.text != txt_ConfirmPassword.text {
            self.alert(alertmessage: lang == "ar" ? "كلمتا المرور غير متطابقتين. الرجاء إدخال نفس كلمة المرور" : "Passwords do not match. Please enter the same password")
            return false
        }
        return true
    }
}

extension ChangePasswordVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        if textField == txt_OldPassword {
            // Workaround for iOS secureTextEntry cursor reset issue
            if textField.isSecureTextEntry {
                // Capture current text
                if let currentText = textField.text as NSString? {
                    let updatedText = currentText.replacingCharacters(in: range, with: string)
                    textField.text = updatedText
                    
                    // Manually move cursor to end
                    let endPosition = textField.endOfDocument
                    textField.selectedTextRange = textField.textRange(from: endPosition, to: endPosition)
                    
                    return false // We already updated text manually
                }
            }
        } else if textField == txt_NewPassword {
            if textField.isSecureTextEntry {
                // Capture current text
                if let currentText = textField.text as NSString? {
                    let updatedText = currentText.replacingCharacters(in: range, with: string)
                    textField.text = updatedText
                    
                    // Manually move cursor to end
                    let endPosition = textField.endOfDocument
                    textField.selectedTextRange = textField.textRange(from: endPosition, to: endPosition)
                    
                    return false // We already updated text manually
                }
            }
        } else if textField == txt_ConfirmPassword {
            if textField.isSecureTextEntry {
                // Capture current text
                if let currentText = textField.text as NSString? {
                    let updatedText = currentText.replacingCharacters(in: range, with: string)
                    textField.text = updatedText
                    
                    // Manually move cursor to end
                    let endPosition = textField.endOfDocument
                    textField.selectedTextRange = textField.textRange(from: endPosition, to: endPosition)
                    
                    return false // We already updated text manually
                }
            }
        }
        return true
    }
}

