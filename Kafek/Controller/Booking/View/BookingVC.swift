//
//  BookingVC.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 09/08/24.
//

import UIKit

class BookingVC: UIViewController {
    
    @IBOutlet weak var booking_TableVw: UITableView!
    @IBOutlet weak var btn_CurrentOrderOt: UIButton!
    @IBOutlet weak var btn_PastOrderOt: UIButton!
    @IBOutlet weak var lbl_Headline: UILabel!
    @IBOutlet weak var btnBackOt: UIButton!
    
    let viewModel = BookingStatusViewModel()
    var isNavigate: String!
    var strType:String = "Current"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.booking_TableVw.register(UINib(nibName: "BookingCell", bundle: nil), forCellReuseIdentifier: "BookingCell")
        self.setUpBinding(strType: "Current")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isNavigate == "History" {
            self.navigationController?.navigationBar.isHidden = true
            self.tabBarController?.tabBar.isHidden = true
            self.lbl_Headline.text = R.string.localizable.booking()
            self.btnBackOt.isHidden = false
        } else {
            self.navigationController?.navigationBar.isHidden = true
            self.tabBarController?.tabBar.isHidden = false
            self.lbl_Headline.text = R.string.localizable.booking()
            self.btnBackOt.isHidden = true
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_OrderStatus(_ sender: UIButton) {
        if sender.tag == 0 {
            self.btn_CurrentOrderOt.backgroundColor = R.color.darkBlue()
            self.btn_PastOrderOt.backgroundColor = .clear
            self.btn_CurrentOrderOt.setTitleColor(.white, for: .normal)
            self.btn_PastOrderOt.setTitleColor(R.color.darkBlue(), for: .normal)
            self.setUpBinding(strType: "Current")
            strType = "Current"
        } else {
            self.btn_CurrentOrderOt.backgroundColor = .clear
            self.btn_PastOrderOt.backgroundColor = R.color.darkBlue()
            self.btn_CurrentOrderOt.setTitleColor(R.color.darkBlue(), for: .normal)
            self.btn_PastOrderOt.setTitleColor(.white, for: .normal)
            self.setUpBinding(strType: "Past")
            strType = "Past"
        }
    }
    
    private func setUpBinding(strType:String) {
        viewModel.fetchBookingStatus(vC: self, strType: strType, tableView: booking_TableVw)
        viewModel.cloSuccessfulBookingStatus = { [weak self] in
            guard let self = self else { return }
            self.booking_TableVw.reloadData()
        }
    }
}

extension BookingVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.arrayBookingStatus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookingCell", for: indexPath) as! BookingCell
        
        let obj = viewModel.arrayBookingStatus[indexPath.row]
        
        if L102Language.currentAppleLanguage() == "ar" {
            cell.lbl_Category.text = obj.product_details?[0].item_name_ar ?? ""
        } else {
            cell.lbl_Category.text = obj.product_details?[0].item_name ?? ""
        }
        
        if strType == "Current" {
            cell.lbl_Amount.text = "\(R.string.localizable.amount()): \(obj.product_details?[0].total_amount ?? "") SR \(obj.price_type ?? "")"
        } else {
            cell.lbl_Amount.text = "\(R.string.localizable.amount()): \(obj.total_amount ?? "") SR \(obj.price_type ?? "")"
        }
        
        cell.lbl_Size.text = "\(R.string.localizable.loadCapacity()): \(obj.cart_details?[0].size_name ?? "")"
        cell.lbl_Quantity.text = "\(R.string.localizable.quantity()): \(obj.product_details?[0].quantity ?? "")"
        cell.lbl_Status.text = "\(R.string.localizable.status()): \(obj.status ?? "")"
                
        if let productImg = obj.product_details?.first?.product_images {
            if productImg.count > 0 {
                Utility.setImageWithSDWebImage(productImg[0].image ?? "", cell.cat_Img)
            } else {
                cell.cat_Img.image = R.image.no_Image_Available()
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = viewModel.arrayBookingStatus[indexPath.row]
        if obj.order_type == "Service" {
            print(obj.status ?? "")
            viewModel.navigateToServiceDetails(vC: self, strOrderiD: obj.id ?? "", strStatus: obj.status ?? "", productiD: obj.product_id ?? "")
        } else {
            viewModel.navigateToOrderDetails(vC: self, strOrderiD: obj.id ?? "")
        }
    }
}
