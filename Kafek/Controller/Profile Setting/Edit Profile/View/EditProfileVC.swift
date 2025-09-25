//
//  EditProfileVC.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 14/08/24.
//

import UIKit

class EditProfileVC: UIViewController {

    @IBOutlet weak var lbl_Name: UILabel!
    @IBOutlet weak var txt_Name: UITextField!
    @IBOutlet weak var txt_LastName: UITextField!
    @IBOutlet weak var txt_MobileText: UITextField!
    @IBOutlet weak var txt_Email: UITextField!
    @IBOutlet weak var btnCountryPickOt: UIButton!
    
    @IBOutlet weak var btn_UpdateProfileOt: UIButton!
    @IBOutlet weak var lbl_Headline: UILabel!

    var strCCode:String! = "966"
    var countryList = CountryList()

    let viewModel = EditProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countryList.delegate = self
        
        btnCountryPickOt.setTitle("+\(k.userDefault.value(forKey: k.session.MobileCode) as? String ?? "966")", for: .normal)
        
        setUpBinding()
        setUpUpdateProfile()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        self.lbl_Headline.text = R.string.localizable.editProfile()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    deinit {
        print("Edit Profile SCreen deinited")
    }
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setUpBinding()
    {
        viewModel.requestToGetProfile(vC: self)
        viewModel.responseSuccess = { [weak self] in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                let obj = self.viewModel.arrayDataOfProfle
                self.lbl_Name.text = "\(obj?.first_name ?? "") \(obj?.last_name ?? "")"
                self.txt_Name.text = obj?.first_name ?? ""
                self.txt_LastName.text = obj?.last_name ?? ""
                self.txt_Email.text = obj?.email ?? ""
                self.txt_MobileText.text = obj?.mobile ?? ""
                self.viewModel.strFirstName = obj?.first_name ?? ""
                self.viewModel.strLastName = obj?.last_name ?? ""
                self.viewModel.strMobile = obj?.mobile ?? ""
                self.viewModel.strEmail = obj?.email ?? ""
                
                if Router.BASE_IMAGE_URL != obj?.image {
                    Utility.setImageWithSDWebImageOnButton(obj?.image ?? "", self.btn_UpdateProfileOt)
                } else {
                    self.btn_UpdateProfileOt.setImage(R.image.profile_ic(), for: .normal)
                }
            }
        }
    }
    
    @IBAction func btn_UploadImg(_ sender: UIButton) {
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { [weak self] image in
            guard let self = self else { return }
            
            self.viewModel.imageProfile = image
            sender.contentMode = .scaleToFill
            sender.setImage(image, for: .normal)
        }
    }
    
    @IBAction func btn_CountryPicker(_ sender: UIButton) {
        let navController = UINavigationController(rootViewController: countryList)
        self.present(navController, animated: true, completion: nil)
    }
        
    @IBAction func btn_Update(_ sender: UIButton) {
        self.viewModel.phoneKey = self.strCCode
        self.viewModel.strFirstName = self.txt_Name.text ?? ""
        self.viewModel.strLastName = self.txt_LastName.text ?? ""
        self.viewModel.strEmail = self.txt_Email.text ?? ""
        self.viewModel.strMobile = self.txt_MobileText.text ?? ""
        self.viewModel.requestToUpdateProfile(vC: self)
    }
    
    private func setUpUpdateProfile()
    {
        viewModel.showErrorMessage = { [weak self] in
            guard let self = self else { return }
            
            if let errorMessage = self.viewModel.errorMessage {
                Utility.showAlertMessage(withTitle: k.appName, message: errorMessage, delegate: nil, parentViewController: self)
            }
        }
        
        viewModel.cloUpdateProfileSuccessful = { [weak self] in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                Utility.showAlertWithAction(withTitle: k.appName, message: R.string.localizable.profileUpdatedSuccessfully(), delegate: nil, parentViewController: self) { [weak self] bool in
                    guard let self = self else { return }
                    
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
}

extension EditProfileVC: CountryListDelegate {
    func selectedCountry(country: Country) {
        strCCode = "\(country.phoneExtension)"
        btnCountryPickOt.setTitle("+\(strCCode!)", for: .normal)
        print(strCCode!)
        
        k.userDefault.set(strCCode!, forKey: k.session.MobileCode)
        print(k.userDefault.set(strCCode!, forKey: k.session.MobileCode))
    }
}

