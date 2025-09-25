//
//  PaymentTypeVC.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 10/08/24.
//

import UIKit

class PaymentTypeVC: UIViewController {
    
    // MARK: PROPERTIES
    @IBOutlet weak var cashPaymentVw: UIView!
    @IBOutlet weak var onlinePaymentVw: UIView!
    
    @IBOutlet weak var lbl_CashPayment: UILabel!
    @IBOutlet weak var lbl_OnlinePayment: UILabel!
    @IBOutlet weak var lbl_Headline: UILabel!
    
    // MARK: VARIABLES
    let paymentViewModel = PaymentConfirmationViewModel()
    let serviceDetailModel = ServiceOrderViewModel()
    
    var cloDirectAccptCashPay:((String, String, String)->Void)?
    
    var isForr:String = ""
    var isComesFrom:String = ""
    var forOfferService:Bool = false
    var isDirectAccepted = ""
    var paymentMethod:String = "Cash"
    var strPaymentMethodOption:String = ""
    
    var timer: Timer?
    
    //    MARK: APPEARANCE
    override func viewDidLoad() {
        super.viewDidLoad()
        let cashTapGesture = UITapGestureRecognizer(target: self, action: #selector(cashPaymentMethod))
        lbl_CashPayment.isUserInteractionEnabled = true
        lbl_CashPayment.addGestureRecognizer(cashTapGesture)
        lbl_CashPayment.text = "\(R.string.localizable.cashPayment())\n\(R.string.localizable.usingThisMethodYouCanPayCashPayment())"
        
        let onlineTapGesture = UITapGestureRecognizer(target: self, action: #selector(onlinePaymentMethod))
        lbl_OnlinePayment.isUserInteractionEnabled = true
        lbl_OnlinePayment.addGestureRecognizer(onlineTapGesture)
        lbl_OnlinePayment.text = "\(R.string.localizable.onlinePayment())\n\(R.string.localizable.usingThisPaymentMethodYouCanPayOnlineViaDebitCreditAndVisaMasterCard())"
        
        updateContent()
        startRepeatingAPIRequest()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.lbl_Headline.text = R.string.localizable.paymentMethod()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    //    MARK: ALL ACTIONS
    @objc func cashPaymentMethod()
    {
        self.cashPaymentVw.backgroundColor = R.color.darkBlue()
        self.lbl_CashPayment.textColor = .white
        
        self.onlinePaymentVw.backgroundColor = .white
        self.lbl_OnlinePayment.textColor = .black
        paymentMethod = "Cash"
    }
    
    @objc func onlinePaymentMethod()
    {
        self.onlinePaymentVw.backgroundColor = R.color.darkBlue()
        self.lbl_OnlinePayment.textColor = .white
        
        self.cashPaymentVw.backgroundColor = .white
        self.lbl_CashPayment.textColor = .black
        paymentMethod = "Card"
    }
    
    @IBAction func btn_back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_Next(_ sender: UIButton) {
        if isForr == "Product" {
            self.timer?.invalidate()
            print("Stop timer to update payment method")
            paymentViewModel.requestToUpdateOrderStatus(vC: self)
            paymentViewModel.cloOrderStatus = { [weak self] in
                guard let self = self else { return }
                let vC = R.storyboard.main().instantiateViewController(withIdentifier: "PresentPaymentConfirmPopup") as! PresentPaymentConfirmPopup
                vC.modalTransitionStyle = .crossDissolve
                vC.modalPresentationStyle = .overFullScreen
                self.present(vC, animated: true)
            }
        } else {
            if paymentMethod == "Cash" {
                if isDirectAccepted == "Yes" {
                    self.timer?.invalidate()
                    print("Stop timer to update payment method")
                    self.cloDirectAccptCashPay?("Cash", "", "")
                } else {
                    self.WebServiceCall("FullCash")
                }
            } else {
                self.timer?.invalidate()
                print("Stop timer to update payment method")
                
                let offerAmtInt = Int(paymentViewModel.offerAmt) ?? 0
                
                if k.userDefault.value(forKey: k.session.userWallet) as? String != "0" {
                    let popupVC = R.storyboard.main().instantiateViewController(withIdentifier: "PopUpUserHelp") as! PopUpUserHelp
                    popupVC.strHeadline = "forPayment"
                      
                    popupVC.cloPayment = { [weak self] walletStatus, walletAmt in
                        guard let self = self else { return }
                        
                        print("PaymentTypeVC → cloPayment called with status: \(walletStatus), amt: \(walletAmt)")

                        let walletAmtDouble = Double(walletAmt) ?? 0.0

                        switch walletStatus {
                        case "Yes":
                            if walletAmtDouble >= Double(offerAmtInt) {
                                // ✅ Case 1: Wallet covers full amount
                                self.timer?.invalidate()

                                paymentViewModel.addPaymentIntegration(vC: self, strPaymentType: "Wallet", strAmount: String(offerAmtInt), strWalletAmt: String(offerAmtInt))
                                paymentViewModel.cloSuccessfulWalletPayment = { striD in
                                    if self.isComesFrom == "DriverOrderService" {
                                        self.cloDirectAccptCashPay?("Wallet", "", striD)
                                    } else {
                                        self.WebServiceCall("FullWallet")
                                    }
                                }
                            } else if walletAmtDouble < Double(offerAmtInt) {
                                // ✅ Case 3: Partial Wallet + Card
                                
                                let remainingAmt = Double(offerAmtInt) - walletAmtDouble
                                print("Using wallet partially. Remaining via card: \(remainingAmt)")
                                let paymentVC = self.preparePaymentVC(offerAmt: offerAmtInt,
                                                                      walletAmt: walletAmt,
                                                                      payAmt: String(remainingAmt),
                                                                      type: "Card")
                                self.navigationController?.pushViewController(paymentVC, animated: true)
                            }

                        case "No":
                            // ✅ Case 4: Wallet ignored → Full Card
                            print("User chose not to use wallet. Full amount via card.")
                            
                            let paymentVC = self.preparePaymentVC(offerAmt: offerAmtInt,
                                                                  walletAmt: "0",
                                                                  payAmt: String(offerAmtInt),
                                                                  type: "Card")
                            self.navigationController?.pushViewController(paymentVC, animated: true)

                        default:
                            print("⚠️ Unknown walletStatus: \(walletStatus)")
                        }
                    }
                    
                    // Present the wallet choice popup
                    popupVC.modalTransitionStyle = .crossDissolve
                    popupVC.modalPresentationStyle = .overFullScreen
                    self.present(popupVC, animated: true)
                } else {
                                        
                    let paymentVC = self.preparePaymentVC(offerAmt: offerAmtInt,
                                                          walletAmt: "0",
                                                          payAmt: String(offerAmtInt),
                                                          type: "Card")
                    self.navigationController?.pushViewController(paymentVC, animated: true)
                }
            }
        }
    }
    
    //    MARK: FUNCTIONS
    func startRepeatingAPIRequest() {
        // Invalidate existing timer if already running
        timer?.invalidate()
        
        // Schedule a new timer
        timer = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true) { [weak self] _ in
            self?.updateContent()
        }
    }
    
    func updateContent() {
        serviceDetailModel.requestToGetServiceDt(vC: self)
        serviceDetailModel.successResponse = { [weak self] in
            guard let self = self else { return }
            
            let obj = self.serviceDetailModel.arrayOfServiceDetails
            if obj?.payment_method == "Cash" {
                cashPaymentVw.isHidden = false
                onlinePaymentVw.isHidden = true
            } else if obj?.payment_method == "Online" {
                cashPaymentVw.isHidden = true
                onlinePaymentVw.isHidden = false
            } else {
                cashPaymentVw.isHidden = false
                onlinePaymentVw.isHidden = false
            }
        }
    }
    
    func WebServiceCall(_ isForr: String) {
        offerAcceptOrRejectByUser = true
        paymentViewModel.requestToAcceptOrder(vC: self)
        paymentViewModel.cloOfferAccepted = { [weak self] in
            guard let self = self else { return }
            self.timer?.invalidate()
            if isComesFrom == "DriverOrderService" {
                self.navigationController?.popViewController(animated: true)
            } else {
                Utility.showAlertWithAction(withTitle: k.appName, message: L102Language.currentAppleLanguage() == "en" ? "Request Accepted Successfully" : "تم قبول الطلب بنجاح", delegate: nil, parentViewController: self) { bool in
                    if isForr == "FullWallet" || isForr == "FullCash" {
                        self.navigationController?.popViewController(animated: true)
                    } else {
                        Switcher.updateRootVC()
                    }
                }
            }
        }
    }
    
//    MARK: HELPER FUNCTION
    private func preparePaymentVC(offerAmt: Int,
                                  walletAmt: String,
                                  payAmt: String,
                                  type: String) -> MakeTabPaymentVC {
        let paymentVC = R.storyboard.main().instantiateViewController(withIdentifier: "MakeTabPaymentVC") as! MakeTabPaymentVC
        
        paymentVC.viewModel.paymentFor = "Service"
        paymentVC.viewModel.strAmount = String(offerAmt)
//        print(viewModel.orderiD)
        paymentVC.viewModel.payRequestiD = paymentViewModel.orderiD 
        
        paymentVC.viewModel.isDirectAccept = isDirectAccepted
        
        paymentVC.viewModel.strPaymentType = type
        paymentVC.viewModel.strWalletAmt = walletAmt
        paymentVC.viewModel.tabPayAmt = payAmt

        paymentVC.viewModel.cloDirectAcceptCardPay = { [weak self] strPaymentiD in
            guard let self = self else { return }
            
            if self.isComesFrom == "DriverOrderService" {
                self.cloDirectAccptCashPay?(type, "", strPaymentiD)
            } else {
                self.WebServiceCall("dd")
            }
        }
        
        return paymentVC
    }
}
