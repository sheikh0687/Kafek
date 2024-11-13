//
//  SettingVC.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 09/08/24.
//

import UIKit

class SettingVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
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
    
    @IBAction func btn_ChangePassword(_ sender: UIButton) {
        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
        self.navigationController?.pushViewController(vC, animated: true)
    }
    
    @IBAction func btn_ShareApp(_ sender: UIButton) {
     print("Open share url")
    }
    
    @IBAction func btn_HelpCenter(_ sender: UIButton) {
        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "HelpVC") as! HelpVC
        self.navigationController?.pushViewController(vC, animated: true)
    }
    
    @IBAction func btn_DeleteAccount(_ sender: UIButton) {
        print("Call Delete Api")
    }
    
    @IBAction func btn_Logout(_ sender: UIButton) {
        UserDefaults.standard.removeObject(forKey: k.session.status)
        Switcher.updateRootVC()
    }
}
