//
//  OrderAcceptanceVC.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 10/08/24.
//

import UIKit

class SrviceOrderFinalCheckOutVC: UIViewController {
    
//    MARK: PROPERTIES
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var lbl_ItemName: UILabel!
    @IBOutlet weak var lbl_ItemPrice: UILabel!
    @IBOutlet weak var lbl_Count: UILabel!
    @IBOutlet weak var lbl_ExpectedPrice: UILabel!
    
    @IBOutlet weak var offerMainVw: UIView!
    @IBOutlet weak var automaticMainVw: UIView!
    @IBOutlet weak var offerImg: UIImageView!
    @IBOutlet weak var automaticImg: UIImageView!
    
    @IBOutlet weak var lbl_ChooseOffer: UILabel!
    @IBOutlet weak var lbl_AutomaticAccept: UILabel!
    
    @IBOutlet weak var cat_TableVw: UITableView!
    @IBOutlet weak var cat_TableHeight: NSLayoutConstraint!
    
    @IBOutlet weak var productVw: UIView!
    @IBOutlet weak var productPaymentSlotvw: UIStackView!
    
    var isFrom:String = ""
    var arrayCartDetails: [Res_CartDetails] = []
    var arrImage:[[String : AnyObject]] = []
    
    var expectedAmt:String = ""
    var itemName:String = ""
    var itemImg:String = ""
    var itemCount:String = ""
    var strUnit:String = ""
    
    var directDellivery:String = "No"
    var strPaymentMethod:String = ""
    var strOrderMethod:String = ""
    var cloReCallBackApi:((String)->Void)?
    
    var isCallApi:Bool = true
    
    let viewModel = RequestProviderViewModel()
    let serviceDetailModel = ServiceOrderViewModel()
    
    var timer:Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cat_TableVw.register(UINib(nibName: "BookingCell", bundle: nil), forCellReuseIdentifier: "BookingCell")
        if isFrom == "Product" {
            self.productVw.isHidden = true
            self.productPaymentSlotvw.isHidden = true
            self.cat_TableVw.isHidden = false
            self.lbl_ExpectedPrice.text = "\(expectedAmt) SR + \(R.string.localizable.deliveryFee())"
            self.cat_TableHeight.constant = CGFloat(arrayCartDetails.count * 140)
        } else {
            let OfferTapGesture = UITapGestureRecognizer(target: self, action: #selector(offerTap))
            lbl_ChooseOffer.isUserInteractionEnabled = true
            lbl_ChooseOffer.addGestureRecognizer(OfferTapGesture)
            
            let directAccept = UITapGestureRecognizer(target: self, action: #selector(directAccept))
            lbl_AutomaticAccept.isUserInteractionEnabled = true
            lbl_AutomaticAccept.addGestureRecognizer(directAccept)
            
            self.productVw.isHidden = false
            self.productPaymentSlotvw.isHidden = false
            self.cat_TableVw.isHidden = true
            
            self.lbl_ChooseOffer.text = "\(R.string.localizable.chooseOffer())\n\(R.string.localizable.usingThisOptionYouWillAbleToChooseOfferFromDrivers())"
            self.lbl_AutomaticAccept.text = "\(R.string.localizable.automaticAcceptance())\n\(R.string.localizable.inThisOptionAdminWillDirectlyAssignYourRequestToDrivers())"
            
            self.lbl_ItemName.text = itemName
            
            if viewModel.priceType == "rental_service" {
                self.lbl_ExpectedPrice.text = "\(expectedAmt).00 SR \(strUnit)"
            } else {
                self.lbl_ExpectedPrice.text = "\(expectedAmt).00 SR"
            }
            print(self.lbl_ExpectedPrice.text ?? "")
            
            self.lbl_Count.text = itemCount
            
            if itemImg != "" {
                Utility.setImageWithSDWebImage(itemImg, self.productImage)
            } else {
                productImage.image = R.image.no_Image_Available()
            }
            
            updateContent()
            startRepeatingAPIRequest()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func btnBackTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func startRepeatingAPIRequest() {
        // Invalidate existing timer if already running
        timer?.invalidate()
        
        // Schedule a new timer
        timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { [weak self] _ in
            self?.updateContent()
        }
    }
    
    func updateContent() {
        serviceDetailModel.requestToGetServiceDt(vC: self)
        serviceDetailModel.successResponse = { [weak self] in
            guard let self = self else { return }
            let obj = self.serviceDetailModel.arrayOfServiceDetails
            if obj?.order_method == "driver_choice" {
                self.offerMainVw.isHidden = false
                self.automaticMainVw.isHidden = true
            } else if obj?.order_method == "direct_accepted" {
                self.offerMainVw.isHidden = true
                self.automaticMainVw.isHidden = false
            } else {
                self.offerMainVw.isHidden = false
                self.automaticMainVw.isHidden = false
            }
        }
    }
    
    @objc func offerTap() {
        offerMainVw.backgroundColor = R.color.darkBlue()
        offerImg.image = R.image.offerChecked()
        lbl_ChooseOffer.textColor = .white
        
        automaticMainVw.backgroundColor = .white
        automaticImg.image = R.image.directUnchecked()
        lbl_AutomaticAccept.textColor = .black
        directDellivery = "No"
    }
    
    @objc func directAccept() {
        offerMainVw.backgroundColor = .white
        offerImg.image = R.image.offerUnchecked()
        lbl_ChooseOffer.textColor = .black
        
        automaticMainVw.backgroundColor = R.color.darkBlue()
        automaticImg.image = R.image.directChecked()
        lbl_AutomaticAccept.textColor = .white
        directDellivery = "Yes"
    }
    
    @IBAction func btn_SendRequest(_ sender: UIButton) {
        if isFrom == "Product" {
            setUpPlaceOrderBinding()
        } else {
            if isCallApi {
                CustomLoader.showCustomLoader()
                setUpBinding()
            } else {
                print("Don't Call Api")
            }
        }
    }
    
    private func setUpBinding() {
        if directDellivery == "Yes" {
            self.timer?.invalidate()
            print("===== Stop timer to update Service method ======")
            isCallApi = false
            viewModel.directDellivery = self.directDellivery
            viewModel.addOrdersInCart(vC: self)
            viewModel.cloAddToCartSuccessful = { [weak self] in
                guard let self = self else { return }
                
                let vCPay = R.storyboard.main().instantiateViewController(withIdentifier: "PaymentTypeVC") as! PaymentTypeVC
                
                self.isCallApi = true
                vCPay.isForr = "Service"
                vCPay.isComesFrom = "DriverOrderService"
                
                vCPay.serviceDetailModel.productiD = serviceDetailModel.productiD
                vCPay.serviceDetailModel.type = serviceDetailModel.type
                vCPay.strPaymentMethodOption = self.strPaymentMethod
                vCPay.isDirectAccepted = self.directDellivery
                vCPay.paymentViewModel.offerAmt = self.expectedAmt
                vCPay.paymentViewModel.provideriD = viewModel.provideriD
                vCPay.paymentViewModel.orderiD = viewModel.orderiD
                
                vCPay.cloDirectAccptCashPay = { [weak self] strPaymentMethod, strTotalWalletAmt, strPaymentiD in
                    guard let self = self else { return }
                    
                    print("ServiceOrderFinalCheckOutVC → cloDirectAccptCashPay triggered: \(strPaymentMethod)")
                    
                    self.viewModel.placeServiceRequest(vC: self, paymentMethod: strPaymentMethod, paymentiD: strPaymentiD)
                    self.viewModel.cloServiceAddedSuccessful = { [weak self] striD in
                        guard let self = self else { return }
                        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "ServiceOrderWaitingVC") as! ServiceOrderWaitingVC
                        vC.offerFrom = R.string.localizable.waitingForAccept()
                        vC.viewModel.orderiD = striD
                        vC.isComing = "ServiceBooking"
                        self.navigationController?.pushViewController(vC, animated: true)
                    }
                }
                self.navigationController?.pushViewController(vCPay, animated: true)
            }
        } else {
            self.timer?.invalidate()
            print("===== Stop timer to update Service method ======")
            isCallApi = false
            viewModel.directDellivery = self.directDellivery
            viewModel.addOrdersInCart(vC: self)
            viewModel.cloServiceAddedSuccessful = { [weak self] striD in
                guard let self = self else { return }
                let vC = R.storyboard.main().instantiateViewController(withIdentifier: "ServiceOrderWaitingVC") as! ServiceOrderWaitingVC
                vC.offerFrom = R.string.localizable.waitingForOffers()
                vC.viewModel.orderiD = striD
                vC.isComing = "ServiceBooking"
                self.navigationController?.pushViewController(vC, animated: true)
            }
        }
    }
    
    // For Product
    private func setUpPlaceOrderBinding() {
        viewModel.requestToPlaceOrder(vC: self)
        viewModel.cloPlaceOrderSuccessful = { [weak self] in
            guard let self = self else { return }
            Utility.showAlertWithAction(withTitle: k.appName, message: R.string.localizable.yourOrderHasBeenPlacedSuccessfully(), delegate: nil, parentViewController: self) { [weak self] bool in
                guard let self = self else { return }
                let vC = R.storyboard.main().instantiateViewController(withIdentifier: "BookingVC") as! BookingVC
                self.navigationController?.pushViewController(vC, animated: true)
            }
        }
    }
}

extension SrviceOrderFinalCheckOutVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayCartDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookingCell", for: indexPath) as! BookingCell
        
        let obj = arrayCartDetails[indexPath.row]
        cell.lbl_Category.text = "\(obj.product_name ?? "") (\(obj.cat_name ?? ""))"
        cell.lbl_Size.text = "\(R.string.localizable.size()): \(obj.size_name ?? "")"
        cell.lbl_Quantity.text = "\(R.string.localizable.quantity()): \(obj.quantity ?? "")"
        cell.lbl_Amount.text = "\(R.string.localizable.price()): \(obj.total_amount ?? "") SR"
        cell.lbl_Status.isHidden = true
        
        if let productImg = obj.product_details?.product_images {
            if productImg.count > 0 {
                print("Download Image!!")
                Utility.setImageWithSDWebImage(productImg[0].image ?? "", cell.cat_Img)
            } else {
                cell.cat_Img.image = R.image.no_Image_Available()
            }
        } else {
            cell.cat_Img.image = R.image.no_Image_Available()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
