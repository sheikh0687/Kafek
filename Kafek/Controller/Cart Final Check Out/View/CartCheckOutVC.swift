//
//  CartCheckOutVC.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 10/02/25.
//

import UIKit

class CartCheckOutVC: UIViewController {
    
    @IBOutlet weak var lbl_Address: UILabel!
    @IBOutlet weak var txtNotes: UITextView!
    @IBOutlet weak var lbl_Headline: UILabel!
    
    var selectedAddress:String = ""
    var arrayCartDetail: [Res_CartDetails] = []
    var totalAmt:String = ""
    var deliveryFee:String = ""
    var provideriD:String = ""
    var vehicleiD:String = ""
    
    var strAddressID:String = ""
    var strLat:String = ""
    var strLon:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectAddress))
        lbl_Address.isUserInteractionEnabled = true
        lbl_Address.addGestureRecognizer(tapGesture)
        
        self.lbl_Headline.text = R.string.localizable.orderDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
    }
    
    deinit {
        print("CartCheckOut Screen deinit")
    }
    
    @IBAction func btn_Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func selectAddress() {
        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "SaveAddressVC") as! SaveAddressVC
        vC.cloPlaceAddress = { [weak self] addressVal, valLat, valLon, striD in
            print(addressVal)
            guard let self = self else { return }
            
            self.lbl_Address.text = addressVal
            self.selectedAddress = addressVal
            self.strAddressID = striD
            self.strLat = valLat
            self.strLon = valLon
        }
        self.navigationController?.pushViewController(vC, animated: true)
    }
    
    @IBAction func btn_Next(_ sender: UIButton) {
        if selectedAddress != "" {
            let vC = R.storyboard.main().instantiateViewController(withIdentifier: "SrviceOrderFinalCheckOutVC") as! SrviceOrderFinalCheckOutVC
            vC.isFrom = "Product"
            vC.arrayCartDetails = self.arrayCartDetail
            vC.expectedAmt = self.totalAmt
            vC.viewModel.totalAmt = self.totalAmt
            vC.viewModel.strDeliveryFee = self.deliveryFee
            vC.viewModel.provideriD = self.provideriD
            vC.viewModel.vehicleiD = self.vehicleiD
            vC.viewModel.valAddress = self.selectedAddress
            vC.viewModel.valLat = self.strLat
            vC.viewModel.valLon = self.strLon
            vC.viewModel.valAddressId = self.strAddressID
            self.navigationController?.pushViewController(vC, animated: true)
        } else {
            self.alert(alertmessage: R.string.localizable.pleaseSelectTheAddress())
        }
    }
}
