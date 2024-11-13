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
    
    @IBOutlet weak var btn_Home: UIButton!
    @IBOutlet weak var btn_Work: UIButton!
    @IBOutlet weak var btn_Other: UIButton!
    
//    var lat:Double = 0.0
//    var lon: Double = 0.0
//    var address: String = ""
    
    let viewModel = AddAddressViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        txt_Address.addHint("Select Address")
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectAddress))
        txt_Address.isUserInteractionEnabled = true
        txt_Address.addGestureRecognizer(tapGesture)
        btn_Home.setImage(R.image.ic_CheckedCircle_Black(), for: .normal)
        setUpAddressBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = false
        setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: "Add Address", CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "#001845", BackgroundImage: "", TextColor: "#ffffff", TintColor: "#ffffff", Menu: "")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @objc func selectAddress()
    {
        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "AddressPickerVC") as! AddressPickerVC
        vC.locationPickedBlock = { cordinationVal, latVal, lonVal, addressVal in
            self.txt_Address.text = ""
            self.txt_Address.text = addressVal
            self.viewModel.address = addressVal
            self.viewModel.addressLat = latVal
            self.viewModel.addressLon = lonVal
        }
        self.present(vC, animated: true, completion: nil)
    }
    
    @IBAction func btn_AddressType(_ sender: UIButton) {
        
        if sender.tag == 0 {
            btn_Home.setImage(R.image.ic_CheckedCircle_Black(), for: .normal)
            btn_Work.setImage(R.image.ic_Circle_Black(), for: .normal)
            btn_Other.setImage(R.image.ic_Circle_Black(), for: .normal)
            viewModel.addressType = "Home"
        } else if sender.tag == 1 {
            btn_Work.setImage(R.image.ic_CheckedCircle_Black(), for: .normal)
            btn_Home.setImage(R.image.ic_Circle_Black(), for: .normal)
            btn_Other.setImage(R.image.ic_Circle_Black(), for: .normal)
            viewModel.addressType = "Work"
        } else {
            btn_Other.setImage(R.image.ic_CheckedCircle_Black(), for: .normal)
            btn_Work.setImage(R.image.ic_Circle_Black(), for: .normal)
            btn_Home.setImage(R.image.ic_Circle_Black(), for: .normal)
            viewModel.addressType = "Other"
        }
    }
    
    @IBAction func btn_SaveAddress(_ sender: UIButton) {
        viewModel.requestAddress(vC: self)
        
    }
    
    private func setUpAddressBinding()
    {
        viewModel.showErrorMessage = { [weak self] in
            if let errorMessage = self?.viewModel.errorMessage {
                Utility.showAlertMessage(withTitle: k.appName, message: errorMessage, delegate: nil, parentViewController: self!)
            }
        }
        
        viewModel.successResponse = {
            Utility.showAlertWithAction(withTitle: k.appName, message: "Address added successfully", delegate: nil, parentViewController: self) { bool in
                self.viewModel.returnBack(from: self.navigationController)
            }
        }
    }
    
}
