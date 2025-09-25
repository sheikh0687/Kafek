//
//  SettingVC.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 09/08/24.
//

import UIKit

class SettingVC: UIViewController {

    @IBOutlet weak var profile_Img: UIImageView!
    @IBOutlet weak var lbl_UserName: UILabel!
    @IBOutlet weak var btn_ViewProfileOt: UIButton!
    
    let viewModel = SettingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let fullText = R.string.localizable.viewProfile()

        let attributedString = NSMutableAttributedString(string: fullText)
        attributedString.addAttribute(.foregroundColor, value: UIColor(cgColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), range: NSRange(location: 0, length: fullText.count))

        // Apply font size and weight
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 14), range: NSRange(location: 0, length: fullText.count))

        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: fullText.count))
        btn_ViewProfileOt.setAttributedTitle(attributedString, for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        fetchDetails()
    }
        
    func fetchDetails()
    {
        viewModel.getUserDetails(vC: self)
        viewModel.cloSuccess = { [weak self] in
            guard let self = self else { return }
            
            self.lbl_UserName.text = self.viewModel.userName
            
            if Router.BASE_IMAGE_URL != viewModel.userImg {
                Utility.setImageWithSDWebImage(viewModel.userImg, self.profile_Img)
            } else {
                self.profile_Img.image = R.image.profile_ic()
            }
        }
    }

    @IBAction func btn_EditProfile(_ sender: UIButton) {
        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
        self.navigationController?.pushViewController(vC, animated: true)
    }
    
    @IBAction func btn_History(_ sender: UIButton) {
        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "BookingVC") as! BookingVC
        vC.isNavigate = "History"
        self.navigationController?.pushViewController(vC, animated: true)
    }
    
    @IBAction func btn_Wallet(_ sender: UIButton) {
        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "WalletVC") as! WalletVC
        self.navigationController?.pushViewController(vC, animated: true)
    }
    
    @IBAction func btn_ChangeLanguage(_ sender: UIButton) {
        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "LanguageVC") as! LanguageVC
        self.navigationController?.pushViewController(vC, animated: true)
    }
    
    @IBAction func btn_ChangePassword(_ sender: UIButton) {
        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "ForgotPasswordVC") as! ForgotPasswordVC
        vC.userPassword = viewModel.strUserPassword
        self.navigationController?.pushViewController(vC, animated: true)
//        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
//        vC.userPassword = viewModel.strUserPassword
//        self.navigationController?.pushViewController(vC, animated: true)
    }
    
    @IBAction func btn_WorkWithuS(_ Sender: UIButton) {
        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "LandingVC") as! LandingVC
        vC.isFrom = "Driver"
        self.navigationController?.pushViewController(vC, animated: true)
    }
    
    @IBAction func btn_ShareApp(_ sender: UIButton) {
        let shareText = "Please install Kaffak app from app store when it will be lived"
        let shareItems: [Any] = [shareText]
        
        let activityVC = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        activityVC.excludedActivityTypes = [.airDrop, .postToFlickr, .assignToContact, .openInIBooks]
        
        self.present(activityVC, animated: true, completion: nil)
    }
    
    @IBAction func btn_AboutUs(_ sender: UIButton) {
        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "TermConditionVC") as! TermConditionVC
        vC.viewModel.strType = "AboutUs"
        self.navigationController?.pushViewController(vC, animated: true)
    }

    @IBAction func btn_PrivacyPolicy(_ sender: UIButton) {
        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "TermConditionVC") as! TermConditionVC
        self.navigationController?.pushViewController(vC, animated: true)
    }
    
    @IBAction func btn_HelpCenter(_ sender: UIButton) {
        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "AdminChatVC") as! AdminChatVC
        self.navigationController?.pushViewController(vC, animated: true)
    }
    
    @IBAction func btn_DeleteAccount(_ sender: UIButton) {
        Utility.showAlertYesNoAction(withTitle: k.appName, message: R.string.localizable.areYouSureYouWantToDeleteYourAccount(), delegate: nil, parentViewController: self) { [weak self] bool in
            guard let self = self else { return }
            if bool {
                self.viewModel.deleteAccount(vC: self)
                self.viewModel.cloDeleted = { [] in
                    isLogout = true
                    UserDefaults.standard.removeObject(forKey: k.session.status)
                    UserDefaults.standard.synchronize()
                    Switcher.updateRootVC()
                }
            } else {
                self.dismiss(animated: true)
            }
        }
    }
    
    @IBAction func btn_Logout(_ sender: UIButton) {
        isLogout = true
        UserDefaults.standard.removeObject(forKey: k.session.status)
        UserDefaults.standard.synchronize()
        Switcher.updateRootVC()
    }
}
