//
//  OfferValidityVC.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 10/08/24.
//

import UIKit

class ServiceOrderWaitingVC: UIViewController {
    
    @IBOutlet weak var OfferValidity_TableVw: UITableView!
    @IBOutlet weak var offerValidityHeight: NSLayoutConstraint!
    @IBOutlet weak var lbl_WaitingForOffer: UILabel!
    
    @IBOutlet weak var lbl_OrderNumber: UILabel!
    @IBOutlet weak var lbl_ExpectedAmt: UILabel!
    
    @IBOutlet weak var productOrder_TableVw: UITableView!
    
    @IBOutlet weak var driverDetailsVw: UIView!
    @IBOutlet weak var driver_Img: UIImageView!
    @IBOutlet weak var lbl_DriverName: UILabel!
    
    @IBOutlet weak var confirmedVw: UIView!
    @IBOutlet weak var assignedVw: UIView!
    @IBOutlet weak var inProgressVw: UIView!
    @IBOutlet weak var completedVw: UIView!
    @IBOutlet weak var lbl_RequestiD: UILabel!
    @IBOutlet weak var lbl_Status: UILabel!
    @IBOutlet weak var lbl_Note: UILabel!
    @IBOutlet weak var lbl_Date: UILabel!
    @IBOutlet weak var lbl_Total: UILabel!
    @IBOutlet weak var lbl_DriverOffer: UILabel!
    @IBOutlet weak var expectedPriceAndOfferVw: UIStackView!
    
    @IBOutlet weak var imageLoaderVw: UIImageView!
    @IBOutlet weak var btn_RateDriver: UIButton!
    @IBOutlet weak var btn_CallOt: UIButton!
    @IBOutlet weak var btn_CHatOt: UIButton!
    @IBOutlet weak var contactVw: UIView!
    @IBOutlet weak var btn_PaymentStatus: UIButton!
    
    @IBOutlet weak var placeOrderImgCollection: UICollectionView!
    
    @IBOutlet weak var lbl_Headline: UILabel!
    @IBOutlet weak var btn_HelpOt: UIButton!
    
    let viewModel = ServiceOrderWaitingViewModel()
    let reqViewModel = RequestProviderViewModel()
    
    var offerFrom:String = ""
    var isCancelled:Bool = false
    var isComing:String = ""
    var productiD: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.OfferValidity_TableVw.register(UINib(nibName: "OfferValidityCell", bundle: nil), forCellReuseIdentifier: "OfferValidityCell")
        
        self.productOrder_TableVw.register(UINib(nibName: "ServiceOfferDetailCell", bundle: nil), forCellReuseIdentifier: "ServiceOfferDetailCell")
        
        self.placeOrderImgCollection.register(UINib(nibName: "CatImageCell", bundle: nil),forCellWithReuseIdentifier: "CatImageCell")
        
        self.lbl_WaitingForOffer.text = self.offerFrom
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        fetchBookingDetails()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchBidDetails()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func btn_backClicked(_ sender: UIButton) {
        if isComing == "ServiceBooking" {
            Switcher.updateRootVC()
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func btn_HelpOtClicked(_ sender: UIButton) {
        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "PopUpUserHelp") as! PopUpUserHelp
        vC.cancelByUser = viewModel.strCancelRequest
        print(viewModel.strCancelRequest)
        vC.cloCallApi = { [weak self] strReason in
            guard let self = self else { return }
            self.viewModel.requestToCancelAcceptedOrder(vC: self, cancelReason: strReason)
            self.viewModel.cloCancelAcceptedOrder = { [weak self] in
                guard let self = self else {return}
                Utility.showAlertWithAction(withTitle: "", message: L102Language.currentAppleLanguage() == "en" ? "Cancellation request sent successfully to admin" : "تم إرسال طلب الإلغاء بنجاح إلى المشرف", delegate: nil, parentViewController: self) { bool in
                    self.fetchBookingDetails()
                }
            }
        }
        vC.modalTransitionStyle = .crossDissolve
        vC.modalPresentationStyle = .overFullScreen
        self.present(vC, animated: true)
    }
        
    @IBAction func btn_CheckReviews(_ sender: UIButton) {
        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "RatingReviewVC") as! RatingReviewVC
        self.navigationController?.pushViewController(vC, animated: true)
    }
    
    @IBAction func btn_DoReview(_ sender: UIButton) {
        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "GiveRatingVC") as! GiveRatingVC
        vC.viewModel.provideriD = viewModel.strDriveriD
        vC.viewModel.req_Id = viewModel.orderiD
        self.navigationController?.pushViewController(vC, animated: true)
    }
    
    @IBAction func btn_Call(_ sender: UIButton) {
        Utility.callNumber(phoneNumber: viewModel.strDriverMobileNum)
    }
    
    @IBAction func btn_Chat(_ sender: UIButton) {
        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "UserChatVC") as! UserChatVC
        vC.strUserName = viewModel.strDriverName
        vC.viewModel.request_Id = viewModel.orderiD
        vC.viewModel.receiver_Id = viewModel.strDriveriD
        self.navigationController?.pushViewController(vC, animated: true)
    }
    
    @IBAction func btn_SeeMap(_ sender: UIButton) {
        Utility.openGoogleMaps(latitude: Double(self.viewModel.strAddressLat) ?? 0.0, longitude: Double(self.viewModel.strAddressLon) ?? 0.0)
    }
}

extension ServiceOrderWaitingVC {
    
     func fetchBookingDetails()  {
        viewModel.getBookingOrderDetail(vC: self)
        viewModel.cloSuccesfull = { [weak self] in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.lbl_WaitingForOffer.text = self.viewModel.strWaitingForOffer
                self.lbl_OrderNumber.text = "# \(self.viewModel.orderiD)"
                self.lbl_ExpectedAmt.text = "\(self.viewModel.expectedPrice) SR"
                self.btn_PaymentStatus.setTitle(self.viewModel.strPaymentStatus, for: .normal)
                self.lbl_Date.text = self.viewModel.strDateTime
                
                self.productOrder_TableVw.reloadData()
                
                if self.viewModel.strStatus == "Pending" {
                    self.driverDetailsVw.isHidden = true
                    self.OfferValidity_TableVw.isHidden = false
                    self.expectedPriceAndOfferVw.isHidden = false
                    self.startRotatingAnimation()
                } else {
                    self.driverDetailsVw.isHidden = false
                    self.OfferValidity_TableVw.isHidden = true
                    self.expectedPriceAndOfferVw.isHidden = true
                    self.fetchDriverDetails()
                    self.stopRotatingAnimation()
                }
            }
        }
    }
    
    private func fetchDriverDetails() {
        let obj = self.viewModel.arrayDriverDetails
        self.lbl_DriverName.text = "\(obj?.first_name ?? "") \(obj?.last_name ?? "")"
        self.lbl_RequestiD.text = "\(R.string.localizable.requestIDD())- \(self.viewModel.orderiD)"
        self.lbl_Status.text = "\(R.string.localizable.status()) : \(viewModel.strStatus)"
        self.lbl_Total.text = "SR \(viewModel.expectedPrice)"
        self.lbl_DriverOffer.text = "SR \(viewModel.driverOfferAmount)"
        self.lbl_Note.text = "\(R.string.localizable.myNote()): \(viewModel.strUserNotes)"
        self.viewModel.strDriverName = obj?.first_name ?? ""
        self.viewModel.strDriverMobileNum = obj?.mobile ?? ""
        
        if Router.BASE_IMAGE_URL != obj?.image {
            Utility.setImageWithSDWebImage(obj?.image ?? "", self.driver_Img)
        } else {
            self.driver_Img.image = R.image.no_Image_Available()
        }
        
        if viewModel.isChatOpen == "Yes" {
            self.btn_CHatOt.isHidden = false
        } else {
            self.btn_CHatOt.isHidden = true
        }
        
        if viewModel.isCallOpen == "Yes" {
            self.btn_CallOt.isHidden = false
        } else {
            self.btn_CallOt.isHidden = true
        }
        
        if viewModel.isChatOpen == "No" && viewModel.isCallOpen == "No" {
            self.contactVw.isHidden = true
        }

        if viewModel.arrayPlaceOrderImg.count > 0 {
            self.placeOrderImgCollection.reloadData()
        } else {
            self.placeOrderImgCollection.isHidden = true
        }
        
        switch viewModel.strStatus {
        case "Pending":
            self.confirmedVw.backgroundColor = R.color.darkBlue()
            self.assignedVw.backgroundColor = .separator
            self.inProgressVw.backgroundColor = .separator
            self.completedVw.backgroundColor = .separator
            self.contactVw.isHidden = true
            
        case "Cancel":
            self.confirmedVw.backgroundColor = R.color.darkBlue()
            self.assignedVw.backgroundColor = .separator
            self.inProgressVw.backgroundColor = .separator
            self.completedVw.backgroundColor = .separator
            self.contactVw.isHidden = true
            
        case "Accept":
            self.confirmedVw.backgroundColor = .separator
            self.assignedVw.backgroundColor = R.color.darkBlue()
            self.inProgressVw.backgroundColor = .separator
            self.completedVw.backgroundColor = .separator
            
        case "Picked":
            self.confirmedVw.backgroundColor = .separator
            self.assignedVw.backgroundColor = .separator
            self.inProgressVw.backgroundColor = R.color.darkBlue()
            self.completedVw.backgroundColor = .separator
        default:
            self.confirmedVw.backgroundColor = .separator
            self.assignedVw.backgroundColor = .separator
            self.inProgressVw.backgroundColor = .separator
            self.completedVw.backgroundColor = R.color.darkBlue()

            self.contactVw.isHidden = true
            if viewModel.isRatingReviewDriver == "No" {
                let vC = R.storyboard.main().instantiateViewController(withIdentifier: "GiveRatingVC") as! GiveRatingVC
                vC.viewModel.provideriD = viewModel.strDriveriD
                vC.viewModel.req_Id = viewModel.orderiD
                vC.serviceImage = viewModel.strServiceImg
                self.navigationController?.pushViewController(vC, animated: true)
            }
        }
    }
    
     func fetchBidDetails() {
        viewModel.getPlaceBid(vC: self, tableView: OfferValidity_TableVw)
        viewModel.cloSuccessfullBid = { [weak self] in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.OfferValidity_TableVw.reloadData()
                self.offerValidityHeight.constant = CGFloat(self.viewModel.arrayPlaceBidding.count * 180)
            }
        }
    }
    
    func startRotatingAnimation() {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.toValue = CGFloat.pi * 2  // Rotate 360 degrees
        rotationAnimation.duration = 1.5  // Speed of rotation
        rotationAnimation.repeatCount = Float.infinity  // Keep rotating
        rotationAnimation.isRemovedOnCompletion = false
        imageLoaderVw.layer.add(rotationAnimation, forKey: "rotationAnimation")
    }
    
    func stopRotatingAnimation() {
        imageLoaderVw.layer.removeAnimation(forKey: "rotationAnimation")
    }
}

extension ServiceOrderWaitingVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == productOrder_TableVw {
            return viewModel.arrayBookingOrderDetail.count
        } else {
            return viewModel.arrayPlaceBidding.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == productOrder_TableVw {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ServiceOfferDetailCell", for: indexPath) as! ServiceOfferDetailCell
            let obj = self.viewModel.arrayBookingOrderDetail[indexPath.row]
            
            if L102Language.currentAppleLanguage() == "ar" {
                cell.lbl_ItemName.text = obj.product_details?.item_name_ar ?? ""
            } else {
                cell.lbl_ItemName.text = obj.product_details?.item_name ?? ""
            }
            cell.lbl_ItemPrice.text = "SR \(obj.product_price ?? "") \(self.viewModel.priceType)"
            cell.lbl_Quantity.text = obj.quantity ?? ""
            
            if let product_Img = obj.product_details?.product_images {
                if product_Img.count > 0 {
                    Utility.setImageWithSDWebImage(product_Img[0].image ?? "", cell.product_Img)
                } else {
                    cell.product_Img.image = R.image.no_Image_Available()
                }
            } else {
                cell.product_Img.image = R.image.no_Image_Available()
            }
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OfferValidityCell", for: indexPath) as! OfferValidityCell
            
            let obj = self.viewModel.arrayPlaceBidding[indexPath.row]
            
            cell.lbl_Name.text = "\(obj.driver_details?.first_name ?? "") \(obj.driver_details?.last_name ?? "")"
            print(cell.lbl_Name.text!)
            cell.lbl_OfferPrice.text = "\(R.string.localizable.offerPrice()): SR \(obj.amount ?? "") * \(obj.item_count ?? "")"
            cell.lbl_TotalAmount.text = "\(R.string.localizable.totalAmount()): SR\(obj.total_amount ?? "")"
            cell.lbl_Quantity.text = obj.item_count ?? ""
            cell.ratingStart.rating = Double(obj.driver_details?.avg_rating ?? 0)
            cell.lbl_RatingCount.text = String(obj.driver_details?.avg_rating ?? 0)
            
            if Router.BASE_IMAGE_URL != obj.driver_details?.image {
                Utility.setImageWithSDWebImage(obj.driver_details?.image ?? "", cell.driver_Img)
            } else {
                cell.driver_Img.image = R.image.no_Image_Available()
            }
                        
            cell.cloOfferReject = { [weak self] in
                guard let self = self else { return }
                self.viewModel.offerRejection(vC: self, place_bid_id: obj.id ?? "", driver_id: obj.driver_id ?? "")
                self.viewModel.cloOfferRejected = { [] in
                    self.fetchBidDetails()
                }
            }
            
            cell.cloOfferAccepted = { [weak self] in
                guard let self = self else { return }
                let vC = R.storyboard.main().instantiateViewController(withIdentifier: "PaymentTypeVC") as! PaymentTypeVC
                vC.isForr = "Service"
                vC.forOfferService = true
                vC.isComesFrom = "DriverOrderAccept"
                vC.isDirectAccepted = obj.driver_details?.direct_accepted ?? ""
                vC.serviceDetailModel.productiD = productiD
                vC.paymentViewModel.orderiD = viewModel.orderiD
                vC.paymentViewModel.place_bid_id = obj.id ?? ""
                vC.paymentViewModel.driveriD = obj.driver_id ?? ""
                vC.paymentViewModel.offerAmt = obj.total_amount ?? ""
                vC.paymentViewModel.quantity = obj.item_count ?? ""
//                vC.viewModel.provideriD =
                
                vC.cloDirectAccptCashPay = { [weak self] strPaymentMethod, strTotalWalletAmt, strPaymentiD in
                    guard let self  else { return }
                    print("ServiceOrderFinalCheckOutVC → cloDirectAccptCashPay triggered: \(strPaymentMethod)")
                    
                    self.reqViewModel.totalAmt = strTotalWalletAmt
                    self.reqViewModel.placeServiceRequest(vC: self, paymentMethod: strPaymentMethod, paymentiD: strPaymentiD)
                    self.reqViewModel.cloServiceAddedSuccessful = { [weak self] striD in
                        guard let self else { return }
                        fetchBookingDetails()
//                        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "ServiceOrderWaitingVC") as! ServiceOrderWaitingVC
//                        vC.offerFrom = R.string.localizable.waitingForAccept()
//                        vC.viewModel.orderiD = striD
//                        vC.isComing = "ServiceBooking"
//                        self.navigationController?.pushViewController(vC, animated: true)
                    }
                }
                
                self.navigationController?.pushViewController(vC, animated: true)
            }
            
            cell.cloChat = { [weak self] in
                guard let self = self else { return }
                let vC = R.storyboard.main().instantiateViewController(withIdentifier: "UserChatVC") as! UserChatVC
                vC.strUserName = obj.driver_details?.first_name ?? ""
                vC.viewModel.request_Id = obj.id ?? ""
                vC.viewModel.receiver_Id = obj.driver_details?.id ?? ""
                self.navigationController?.pushViewController(vC, animated: true)
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == productOrder_TableVw {
            return 120
        } else {
            return UITableView.automaticDimension
        }
    }
}

// MARK: COLLECTION VIEW
extension ServiceOrderWaitingVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.arrayPlaceOrderImg.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CatImageCell", for: indexPath) as! CatImageCell
        let obj = viewModel.arrayPlaceOrderImg[indexPath.row]
        
        if Router.BASE_IMAGE_URL != obj.image {
            Utility.setImageWithSDWebImage(obj.image ?? "", cell.cat_Img)
        } else {
            cell.cat_Img.image = R.image.no_Image_Available()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let obj = self.viewModel.arrayPlaceOrderImg[indexPath.row]
        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "PlaceOrderImgVC") as! PlaceOrderImgVC
        vC.imageVw = obj.image ?? ""
        self.navigationController?.pushViewController(vC, animated: true)
    }
}
