//
//  DeliveryHubDetailVC.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 10/08/24.
//

import UIKit

class StoreFinalCheckOutVC: UIViewController {
    
    @IBOutlet weak var lbl_ItemName: UILabel!
    @IBOutlet weak var lbl_Description: UILabel!
    @IBOutlet weak var lbl_Price: UILabel!
    @IBOutlet weak var lbl_TotalItemPrice: UILabel!
    @IBOutlet weak var lbl_TotalCount: UILabel!
    
    @IBOutlet weak var deliveryVehicle_TableVw: UITableView!
    @IBOutlet weak var vehicleTableHeight: NSLayoutConstraint!
    
    @IBOutlet weak var category_CollectionVw: UICollectionView!
    @IBOutlet weak var btn_CartOt: UIButton!
    
    let viewModel = StoreFinalCheckOutViewModel()
    
    var itmePrice:Int = 0
    var finalTotalPrice = 0
    var totalCount:Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initIdentifiers()
        setUpProductDetailBind()
        self.btn_CartOt.isHidden = true
        self.lbl_TotalItemPrice.text = "\(viewModel.strTotalOfferPrice).00 SR"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    deinit {
        print("Store Final CheckOut VC deinit")
    }
    
    @IBAction func btn_back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_Cart(_ sender: UIButton) {
        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "ShopsVC") as! ShopsVC
        vC.isNavigate = "Cart"
        self.navigationController?.pushViewController(vC, animated: true)
    }
    
    private func setUpProductDetailBind()
    {
        viewModel.requestToGetAllProductDt(vC: self)
        viewModel.successResponse = { [weak self] in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                let obj = self.viewModel.arrayOfStoreProductDetail
                self.lbl_ItemName.text = obj?.item_name ?? ""
                self.lbl_Description.text = obj?.description ?? ""
                self.lbl_Price.text = "\(R.string.localizable.price()): \(obj?.offer_item_price ?? "") SR"
                self.itmePrice = Int(obj?.offer_item_price ?? "") ?? 0
                self.finalTotalPrice = Int(obj?.offer_item_price ?? "") ?? 0
                self.deliveryVehicle_TableVw.reloadData()
                self.category_CollectionVw.reloadData()
            }
        }
    }
    
    @IBAction func btn_Add(_ sender: UIButton) {
        viewModel.totalAmt = finalTotalPrice
        viewModel.totalCount = totalCount
        viewModel.addOrdersInCart(vC: self)
        viewModel.addedSuccessful = { [weak self] in
            guard let self = self else { return }
            
            self.btn_CartOt.isHidden = false
        }
    }
    
    @IBAction func btn_Plus(_ sender: UIButton) {
        finalTotalPrice += itmePrice
        totalCount += 1
        self.lbl_TotalCount.text = "\(totalCount)"
        self.lbl_TotalItemPrice.text = "\(finalTotalPrice).00 SR"
    }
    
    @IBAction func btn_Minus(_ sender: UIButton) {
        if totalCount != 1 {
            finalTotalPrice -= itmePrice
            totalCount -= 1
            self.lbl_TotalCount.text = "\(totalCount)"
            self.lbl_TotalItemPrice.text = "\(finalTotalPrice).00 SR"
        }
    }
}

extension StoreFinalCheckOutVC: UITableViewDelegate, UITableViewDataSource {
    
    func initIdentifiers()
    {
        self.deliveryVehicle_TableVw.register(UINib(nibName: "DeliveryVhcCell", bundle: nil), forCellReuseIdentifier: "DeliveryVhcCell")
        self.category_CollectionVw.register(UINib(nibName: "CatImageCell", bundle: nil), forCellWithReuseIdentifier: "CatImageCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.arrayOfProductSizesPrice.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeliveryVhcCell", for: indexPath) as! DeliveryVhcCell
        let obj = viewModel.arrayOfProductSizesPrice[indexPath.row]
        
        cell.lbl_Size.text = obj.size ?? ""
        
        if Router.BASE_IMAGE_URL != obj.image {
            Utility.setImageWithSDWebImage(obj.image ?? "", cell.vehicle_Img)
        } else {
            cell.vehicle_Img.image = R.image.truck1()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension StoreFinalCheckOutVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.arrayOfProductImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CatImageCell", for: indexPath) as! CatImageCell
        
        let obj = self.viewModel.arrayOfProductImages[indexPath.row]
        
        if Router.BASE_IMAGE_URL != obj.image {
            Utility.setImageWithSDWebImage(obj.image ?? "", cell.cat_Img)
        } else {
            cell.cat_Img.image = R.image.no_Image_Available()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
