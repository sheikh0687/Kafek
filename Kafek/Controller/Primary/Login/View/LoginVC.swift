//
//  LoginVC.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 08/08/24.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var txt_Email: UITextField!
    @IBOutlet weak var txt_Password: UITextField!
    @IBOutlet weak var lbl_Language: UILabel!
    @IBOutlet weak var btn_SignupNowOt: UIButton!
    @IBOutlet weak var btn_EyeOt: UIButton!
    @IBOutlet weak var btn_CountryPickerOt: UIButton!
    @IBOutlet weak var txt_MobileNum: UITextField!
    
    let viewModel = LoginViewModel()
    var iconClick = true
    
    var strCCode:String! = "966"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBinding()
        self.txt_Password.delegate = self
        self.txt_MobileNum.delegate = self
        let fullText = R.string.localizable.donTHaveAnAccountSignupNow()
        let range = (fullText as NSString).range(of: R.string.localizable.signUp())
        
        let attributedString = NSMutableAttributedString(string: fullText)
        attributedString.addAttribute(.foregroundColor, value: R.color.darkBlue()!, range: range)
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 14), range: range)
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
        
        btn_SignupNowOt.setAttributedTitle(attributedString, for: .normal)
        
        if L102Language.currentAppleLanguage() == "en" {
            self.lbl_Language.text = "English"
            self.lbl_Language.textAlignment = .left
        } else {
            self.lbl_Language.text = "الإنجليزية"
            self.lbl_Language.textAlignment = .right
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("LoginVC did disappear")
    }
    
    deinit {
        print("LoginVC did disappear")
    }
    
    @IBAction func btn_Login(_ sender: UIButton) {
        viewModel.requestToLoginUser (
            vC: self,
            mobile: txt_MobileNum.text ?? "",
            password: txt_Password.text ?? "",
            strPhoneKey: strCCode
        )
    }
    
    @IBAction func btn_PasswordToggle(_ sender: UIButton) {
        if(iconClick == true) {
            txt_Password.isSecureTextEntry = false
            btn_EyeOt.setImage(R.image.view(), for: .normal)
        } else {
            txt_Password.isSecureTextEntry = true
            btn_EyeOt.setImage(R.image.view_eye(), for: .normal)
        }
        iconClick = !iconClick
    }
    
    @IBAction func btn_ForgotPassword(_ sender: UIButton) {
        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "ForgotPasswordVC") as! ForgotPasswordVC
        self.navigationController?.pushViewController(vC, animated: true)
    }
    
    @IBAction func btn_Signup(_ sender: UIButton) {
        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "SignupVC") as! SignupVC
        self.navigationController?.pushViewController(vC, animated: true)
    }
    
    @IBAction func btn_CountryPicker(_ sender: UIButton) {
        print("Country Picker Tapped!!")
        let countryListVC = CountryList()
        countryListVC.delegate = self
        let navController = UINavigationController(rootViewController: countryListVC)
        self.present(navController, animated: true, completion: nil)
    }
    
    private func setUpBinding()
    {
        viewModel.showErrorMessage = { [weak self] in
            guard let self = self else { return }
            if let errorMessage = self.viewModel.errorMessage {
                Utility.showAlertMessage(withTitle: k.appName, message: errorMessage, delegate: nil, parentViewController: self)
            }
        }
        
        viewModel.loginSuccess = { [weak self] in
            guard let self = self else { return }
            
            self.viewModel.updateLanguage(vC: self, appLan: L102Language.currentAppleLanguage())
            self.viewModel.cloUpdateLanguage = { [weak self] in
                guard let self = self else { return }
                Switcher.updateRootVC()
            }
        }
    }
    
    @IBAction func btn_DropLanguage(_ sender: UIButton) {
        viewModel.configureDropDown(sender: sender, vC: self)
    }
}

extension LoginVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        let currentText = txt_MobileNum.text ?? ""
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        // 1. Block if first character is "0"
        if updatedText.count == 1 && updatedText == "0" {
            print("You cannot start with 0")
            return false
        }

        if textField == txt_Password {
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
        }
        
        return true
    }
}

extension LoginVC: CountryListDelegate {
    func selectedCountry(country: Country) {
        strCCode = "\(country.phoneExtension)"
        print(strCCode!)
        
        let displayName = country.name ?? country.countryCode
        btn_CountryPickerOt.setTitle("+\(strCCode!)", for: .normal)
        k.userDefault.set(strCCode!, forKey: k.session.MobileCode)
        print("Selected country:", displayName, strCCode!)
    }
}
