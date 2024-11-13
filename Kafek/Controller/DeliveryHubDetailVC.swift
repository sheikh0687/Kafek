//
//  DeliveryHubDetailVC.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 10/08/24.
//

import UIKit

class DeliveryHubDetailVC: UIViewController {
    
    @IBOutlet weak var lbl_ItemName: UILabel!
    @IBOutlet weak var lbl_Description: UILabel!
    @IBOutlet weak var lbl_Price: UILabel!
    
    @IBOutlet weak var deliveryVehicle_TableVw: UITableView!
    @IBOutlet weak var vehicleTableHeight: NSLayoutConstraint!
    
    @IBOutlet weak var category_CollectionVw: UICollectionView!
    
    let viewModel = DeliveryHubDtViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initIdentifiers()
        setUpProductDetailBind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: "", CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "#001845", BackgroundImage: "", TextColor: "#ffffff", TintColor: "#ffffff", Menu: "")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func btn_Add(_ sender: UIButton) {
        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "OrderDetailVC") as! OrderDetailVC
        self.navigationController?.pushViewController(vC, animated: true)
    }
    
    private func setUpProductDetailBind()
    {
        viewModel.requestToGetAllProductDt(vC: self)
        viewModel.successResponse = {
            DispatchQueue.main.async {
                let obj = self.viewModel.arrayOfStoreProductDetail
                self.lbl_ItemName.text = obj?.item_name ?? ""
                self.lbl_Description.text = obj?.description ?? ""
                self.lbl_Price.text = "Price: \(obj?.item_price ?? "") riyals"
                self.deliveryVehicle_TableVw.reloadData()
                self.category_CollectionVw.reloadData()
            }
        }
    }
}

extension DeliveryHubDetailVC: UITableViewDelegate, UITableViewDataSource {
    
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

extension DeliveryHubDetailVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
