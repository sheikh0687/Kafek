//
//  BookingOrderDetailVC.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 06/02/25.
//

import UIKit
import Cosmos

class ProductOrderWaitingVC: UIViewController {
    
    @IBOutlet weak var lbl_ProviderName: UILabel!
    @IBOutlet weak var ratingStart: CosmosView!
    @IBOutlet weak var lbl_RatingCount: UILabel!
    @IBOutlet weak var lbl_PaymentStatus: UILabel!
    
    @IBOutlet weak var lbl_Address: UILabel!
    @IBOutlet weak var lbl_RequestId: UILabel!
    @IBOutlet weak var lbl_Status: UILabel!
    @IBOutlet weak var lbl_OrderDate: UILabel!
    
    @IBOutlet weak var category_TableVw: UITableView!
    @IBOutlet weak var categoryTableHeight: NSLayoutConstraint!
    
    @IBOutlet weak var lbl_CostOfProduct: UILabel!
    @IBOutlet weak var lbl_DeliveryFee: UILabel!
    @IBOutlet weak var lbl_AdminFees: UILabel!
    
    @IBOutlet weak var lbl_TotalAmount: UILabel!
    
    @IBOutlet weak var btn_CancelOrderOt: UIButton!
    @IBOutlet weak var btn_MakePaymentOt: UIButton!
    
    @IBOutlet weak var waitingVw: UIView!
    @IBOutlet weak var aboutTotalAmtvw: UIView!
    
    @IBOutlet weak var progressImageView: UIImageView! // Your custom image
    @IBOutlet weak var lbl_Headline: UILabel!
    
    let viewModel = BookingOrderDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.category_TableVw.register(UINib(nibName: "BookingCell", bundle: nil), forCellReuseIdentifier: "BookingCell")
        self.category_TableVw.isHidden = true
        setUpBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        self.lbl_Headline.text = R.string.localizable.orderDetails()
    }
    
    @IBAction func btn_back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btn_ShowProductList(_ sender: UIButton) {
        if sender.isSelected {
            sender.setImage(R.image.downarow(), for: .normal)
            sender.isSelected = false
            category_TableVw.isHidden = true
        } else {
            sender.isSelected = true
            sender.setImage(R.image.uparrow(), for: .normal)
            category_TableVw.isHidden = false
        }
    }
    
    @IBAction func btn_CancelOrder(_ sender: UIButton) {
        viewModel.changeOrderStatus(vC: self, strStatus: "Cancel")
        viewModel.cloChangeStatus = { [weak self] in
            guard let self = self else { return }
            Utility.showAlertWithAction(withTitle: k.appName, message: R.string.localizable.orderHasBeenCancelledSuccessfully(), delegate: nil, parentViewController: self) { bool in
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func btn_Chat(_ sender: UIButton) {
        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "UserChatVC") as! UserChatVC
        vC.strUserName = viewModel.categoryName
        vC.viewModel.request_Id = viewModel.requestiD
        vC.viewModel.receiver_Id = viewModel.provideriD
        self.navigationController?.pushViewController(vC, animated: true)
    }
    
    @IBAction func btn_Call(_ sender: UIButton) {
        
    }
    
    @IBAction func btn_MakePayment(_ sender: UIButton) {
        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "PaymentTypeVC") as! PaymentTypeVC
        vC.paymentViewModel.orderiD = viewModel.orderiD
        self.navigationController?.pushViewController(vC, animated: true)
    }
}

extension ProductOrderWaitingVC {
    
    private func setUpBinding() {
        self.viewModel.getBookingOrderDetail(vC: self)
        self.viewModel.cloSuccesfull = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.lbl_ProviderName.text = self.viewModel.categoryName
                self.ratingStart.rating = Double(self.viewModel.ratingCount) ?? 0.0
                self.lbl_RatingCount.text = self.viewModel.ratingCount
                self.lbl_Address.text = self.viewModel.providerAddress
                self.lbl_PaymentStatus.text = self.viewModel.paymentMethod
                self.lbl_RequestId.text = "\(R.string.localizable.requestIDD())-\(self.viewModel.requestiD)"
                self.lbl_Status.text = "\(R.string.localizable.status()): \(self.viewModel.status)"
                
                if self.viewModel.status == "Pending" {
                    self.waitingVw.isHidden = false
                    self.aboutTotalAmtvw.isHidden = true
                    self.btn_CancelOrderOt.isHidden = false
                    self.btn_MakePaymentOt.isHidden = true
                    self.startRotatingAnimation()
                } else {
                    self.waitingVw.isHidden = true
                    self.aboutTotalAmtvw.isHidden = false
                    self.lbl_TotalAmount.text = "SR \(self.viewModel.totalAmount)"
                    self.lbl_DeliveryFee.text = "SR \(self.viewModel.deliveryFee)"
                    self.lbl_AdminFees.text = "SR \(self.viewModel.adminFee)"
                    self.btn_CancelOrderOt.isHidden = true
                    self.stopRotatingAnimation()
                    if self.viewModel.paymentStatus == "Complete" {
                        self.btn_MakePaymentOt.isHidden = true
                    } else {
                        self.btn_MakePaymentOt.isHidden = false
                    }
                }
                
                self.lbl_OrderDate.text = "\(self.viewModel.orderDate)"
                //                self.lbl_DriverOffer.text = "\(self.viewModel.driverOfferAmt)"
                self.category_TableVw.reloadData()
                self.categoryTableHeight.constant = CGFloat((self.viewModel.arrayBookingOrderDetail.count) * 140)
            }
        }
    }

    func startRotatingAnimation() {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.toValue = CGFloat.pi * 2  // Rotate 360 degrees
        rotationAnimation.duration = 1.5  // Speed of rotation
        rotationAnimation.repeatCount = Float.infinity  // Keep rotating
        rotationAnimation.isRemovedOnCompletion = false

        progressImageView.layer.add(rotationAnimation, forKey: "rotationAnimation")
    }
    
    func stopRotatingAnimation() {
        progressImageView.layer.removeAnimation(forKey: "rotationAnimation")
    }
}

extension ProductOrderWaitingVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.arrayBookingOrderDetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookingCell", for: indexPath) as! BookingCell
        let obj = viewModel.arrayBookingOrderDetail[indexPath.row]
        cell.lbl_Category.text = "\(obj.product_name ?? "") (\(obj.cat_name ?? ""))"
        cell.lbl_Size.text = "\(R.string.localizable.size()): \(obj.size_name ?? "")"
        cell.lbl_Quantity.text = "\(R.string.localizable.quantity()): \(obj.quantity ?? "")"
        cell.lbl_Amount.text = "\(R.string.localizable.price()): \(obj.total_amount ?? "") SR"
        cell.lbl_Status.isHidden = true
        
        if let productImg = obj.product_details?.product_images {
            if productImg.count > 0 {
                print("Download Image!!")
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
