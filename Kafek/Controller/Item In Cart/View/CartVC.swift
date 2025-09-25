//
//  CartVC.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 27/09/24.
//

import UIKit

class CartVC: UIViewController {

    @IBOutlet weak var view_1: UIView!
    @IBOutlet weak var view_2: UIView!
    
    @IBOutlet weak var lbl_SubTotal: UILabel!
    @IBOutlet weak var lbl_Tax: UILabel!
    @IBOutlet weak var lbl_TotalPay: UILabel!
    @IBOutlet weak var lbl_Headline: UILabel!
    
    @IBOutlet weak var cart_TableView: UITableView!
    
    let viewModel = CartDetailViewModel()
    
    var totalAmt:String = ""
    var deliveryFee:String = ""
    var provideriD:String = ""
    var vehicleiD:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cart_TableView.register(UINib(nibName: "CartCell", bundle: nil), forCellReuseIdentifier: "CartCell")
        self.lbl_Headline.text = R.string.localizable.myCart()
        setUpBinding()
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
        print("Cart Screen deinited")
    }
    
    @IBAction func btn_Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setUpBinding() {
        viewModel.requestCartDetail(vC: self)
        viewModel.cloSuccessfully = { [weak self] in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.lbl_SubTotal.text = "SR \(self.viewModel.subTotal)"
                self.lbl_Tax.text = "SR \(self.viewModel.taxAmt)"
                self.lbl_TotalPay.text = "SR \(self.viewModel.totalAmount)"
                self.totalAmt = self.viewModel.totalAmount
                self.deliveryFee = self.viewModel.deliveryFee
                self.cart_TableView.reloadData()
            }
        }
    }
    
    @IBAction func btn_Proceed(_ sender: UIButton) {
        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "CartCheckOutVC") as! CartCheckOutVC
        vC.arrayCartDetail = self.viewModel.arrayCartDetail
        vC.totalAmt = self.totalAmt
        vC.deliveryFee = self.deliveryFee
        vC.provideriD = self.provideriD
        vC.vehicleiD = self.vehicleiD
        self.navigationController?.pushViewController(vC, animated: true)
    }
}

extension CartVC: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.arrayCartDetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as! CartCell
        var obj = self.viewModel.arrayCartDetail[indexPath.row]
        
        cell.lbl_ItemName.text = "\(obj.product_name ?? "")(\(obj.cat_name ?? ""))"
        cell.lbl_Size.text = "\(R.string.localizable.size()): \(obj.size_name ?? "")"
        cell.lbl_ProviderName.text = obj.rest_details?.provider_name ?? ""
        cell.lbl_Amount.text = "SR \(obj.total_amount ?? "").0"
        cell.lbl_Quantity.text = "\(obj.quantity ?? "")"
        
        self.provideriD = obj.provider_id ?? ""
        self.vehicleiD = obj.product_details?.vehicle_id ?? ""
        
        if let productImg = obj.product_details?.product_images {
            if productImg.count > 0 {
                if Router.BASE_IMAGE_URL != productImg[0].image {
                    Utility.setImageWithSDWebImage(productImg[0].image ?? "", cell.item_Img)
                } else {
                    cell.item_Img.image = R.image.no_Image_Available()
                }
            } else {
                cell.item_Img.image = R.image.no_Image_Available()
            }
        }
        
        cell.cloAdd = {
            var quantity = Int(obj.quantity ?? "") ?? 0
            quantity += 1
            obj.quantity = String(quantity)
            print(quantity)
            self.viewModel.updateCartItems(vC: self, strQuantity: "\(quantity)", strCartId: obj.id ?? "", strType: "Plus")
            self.viewModel.cloUpdated = { [weak self] in
                guard let self = self else { return }
                
                self.setUpBinding()
            }
        }
        
        cell.cloMinus = {
            var quantity = Int(obj.quantity ?? "") ?? 0
            if quantity > 1 {
                quantity -= 1
                obj.quantity = String(quantity)
                print(quantity)
                self.viewModel.updateCartItems(vC: self, strQuantity: "\(quantity)", strCartId: obj.id ?? "", strType: "Minus")
                self.viewModel.cloUpdated = { [weak self] in
                    guard let self = self else { return }
                    
                    self.setUpBinding()
                }
            }
        }
        
        cell.cloDelete = { [self] in
            self.viewModel.deleteCartItem(vC: self, strCartId: obj.id ?? "")
            viewModel.cloDeleted = { [weak self] in
                guard let self = self else { return }
                
                self.setUpBinding()
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

