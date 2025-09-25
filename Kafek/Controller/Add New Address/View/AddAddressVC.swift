//
//  AddAddressVC.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 19/09/24.
//

import UIKit

class AddAddressVC: UIViewController {

    @IBOutlet weak var txt_Address: UITextView!
    @IBOutlet weak var txt_VillaNum: UITextField!
    @IBOutlet weak var txt_OtherAddressType: UITextField!
    @IBOutlet weak var otherAddressVw: UIView!
    
    @IBOutlet weak var btn_HomeImg: UIImageView!
    @IBOutlet weak var btn_WorkImg: UIImageView!
    @IBOutlet weak var btn_OtherImg: UIImageView!
    
    @IBOutlet weak var lbl_Headline: UILabel!
        
    let viewModel = AddAddressViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lbl_Headline.text = R.string.localizable.addAddress()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectAddress))
        txt_Address.addGestureRecognizer(tapGesture)
        txt_Address.isUserInteractionEnabled = true
        setUpAddressBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
    }
   
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    deinit {
        print("Add Address Screen Deinit")
    }
    
    @objc func selectAddress()
    {
        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "AddressPickerVC") as! AddressPickerVC
        vC.locationPickedBlock = { [weak self] cordinationVal, latVal, lonVal, addressVal in
            guard let self = self else { return }
            self.txt_Address.text = addressVal
            self.viewModel.address = addressVal
            self.viewModel.addressLat = latVal
            self.viewModel.addressLon = lonVal
        }
        self.present(vC, animated: true, completion: nil)
    }
    
    @IBAction func btn_Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_AddressType(_ sender: UIButton) {
        if sender.tag == 0 {
            btn_HomeImg.image = R.image.ic_CheckedCircle_Black()
            btn_WorkImg.image = R.image.ic_Circle_Black()
            btn_OtherImg.image = R.image.ic_Circle_Black()
            viewModel.addressType = "Home"
            otherAddressVw.isHidden = true
            
        } else if sender.tag == 1 {
            btn_WorkImg.image = R.image.ic_CheckedCircle_Black()
            btn_HomeImg.image = R.image.ic_Circle_Black()
            btn_OtherImg.image = R.image.ic_Circle_Black()
            viewModel.addressType = "Work"
            otherAddressVw.isHidden = true
        } else {
            btn_OtherImg.image = R.image.ic_CheckedCircle_Black()
            btn_HomeImg.image = R.image.ic_Circle_Black()
            btn_WorkImg.image = R.image.ic_Circle_Black()
            otherAddressVw.isHidden = false
        }
    }
    
    @IBAction func btn_SaveAddress(_ sender: UIButton) {
        if !otherAddressVw.isHidden {
            viewModel.addressType = self.txt_OtherAddressType.text ?? ""
            viewModel.requestAddress(vC: self, isHidden: otherAddressVw.isHidden)
        } else {
            viewModel.requestAddress(vC: self, isHidden: otherAddressVw.isHidden)
        }
    }
    
    private func setUpAddressBinding()
    {
        viewModel.showErrorMessage = { [weak self] in
            guard let self = self else { return }
            
            if let errorMessage = self.viewModel.errorMessage {
                Utility.showAlertMessage(withTitle: k.appName, message: errorMessage, delegate: nil, parentViewController: self)
            }
        }

        viewModel.successResponse = { [weak self] in
            guard let self = self else { return }
            
            Utility.showAlertWithAction(withTitle: k.appName, message: R.string.localizable.addressAddedSuccessfully(), delegate: nil, parentViewController: self) { [weak self] bool in
                guard let self = self else { return }
                
                self.viewModel.returnBack(from: self.navigationController)
            }
        }
    }
}
