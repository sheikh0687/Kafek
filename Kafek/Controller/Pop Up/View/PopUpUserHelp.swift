//
//  PopUpDeliveryFeeConfim.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 10/02/25.
//

import UIKit

class PopUpUserHelp: UIViewController {
    
    @IBOutlet weak var lbl_headline: UILabel!
    @IBOutlet weak var lbl_Desctiption: UILabel!
    
    var strHeadline: String?
    var strWalletAmount:String?
    var cancelByUser:String?
    
    var cloPayment:((_ walletStatus: String,_ walletAmt: String) -> Void)?
    var cloCallApi:((_ cancelReason: String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if strHeadline == "forPayment" {
            fetchWalletAmount()
        } else {
            self.lbl_headline.text = R.string.localizable.help()
            self.lbl_Desctiption.text = R.string.localizable.ifYouWantToCancelThisOrderThenYouWillHaveToSendRequestToAdministratorForSendingTheRequestClickOnYesButton()
        }
    }
    
    func fetchWalletAmount()
    {
        Api.shared.requestTopUserProfile(self) { [weak self] responseData in
            guard let self = self else { return }
            
            let obj = responseData.result!
            self.strWalletAmount = obj.wallet ?? ""
            self.lbl_headline.text = "\(R.string.localizable.walletBalance()) SR \(obj.wallet ?? "0")"
            self.lbl_Desctiption.text = R.string.localizable.areYouWantToUseTheWalletBalanceForThisRequest()
        }
    }
    
    @IBAction func btn_Confirm(_ sender: UIButton) {
        if strHeadline == "forPayment" {
            self.dismiss(animated: true) {
                DispatchQueue.main.async {
                    self.cloPayment?("Yes", self.strWalletAmount ?? "")
                }
            }
        } else {
            if cancelByUser != "Yes" {
                let vC = R.storyboard.main().instantiateViewController(withIdentifier: "CancelReasonPopup") as! CancelReasonPopup
                vC.cloCheckAndCall = { [weak self] strReason in
                    guard let self = self else { return }
                    self.dismiss(animated: true) {
                        self.cloCallApi?(strReason)
                    }
                }
                vC.modalPresentationStyle = .overFullScreen
                vC.modalTransitionStyle = .crossDissolve
                self.present(vC, animated: true)
            } else {
                Utility.showAlertWithAction(withTitle: "", message: L102Language.currentAppleLanguage() == "en" ? "Cancel request already sent to admin" : "طلب الإلغاء قد تم إرساله للمدير", delegate: nil, parentViewController: self) { bool in
                    self.dismiss(animated: true)
                }
            }
        }
    }
    
    @IBAction func btn_No(_ sender: UIButton) {
        if strHeadline == "forPayment" {
            self.cloPayment?("No", strWalletAmount ?? "")
            self.dismiss(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
