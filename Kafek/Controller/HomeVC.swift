//
//  HomeVC.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 08/08/24.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var main_ServicesCollection: UICollectionView!
    @IBOutlet weak var service_CollectionVw: UICollectionView!
    
    @IBOutlet weak var RecommendedShops_TableVw: UITableView!
    @IBOutlet weak var table_Height: NSLayoutConstraint!
    
    @IBOutlet weak var lbl_Address: UILabel!
    
    let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectAddress))
        lbl_Address.isUserInteractionEnabled = true
        lbl_Address.addGestureRecognizer(tapGesture)
        initIndentifier()
        setUpBannerBinding()
        setUpServiceBinding()
        setUpStoreBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @objc func selectAddress()
    {
        viewModel.navigateToSavedAddressViewController(from: self.navigationController, addressValue: lbl_Address)
    }
    
    private func setUpBannerBinding()
    {
        viewModel.requestBannerList(vC: self)
        viewModel.bannerSuccessResponse = {
            DispatchQueue.main.async {
                self.main_ServicesCollection.reloadData()
            }
        }
    }
    
    private func setUpServiceBinding()
    {
        viewModel.requestServiceList(vC: self)
        viewModel.serviceSuccessResponse = {
            DispatchQueue.main.async {
                self.service_CollectionVw.reloadData()
            }
        }
    }
    
    private func setUpStoreBinding()
    {
        viewModel.tableHieght = table_Height
        viewModel.requestStoreList(vC: self)
        viewModel.storeSuccessResponse = {
            DispatchQueue.main.async {
                self.RecommendedShops_TableVw.reloadData()
            }
        }
    }
    
    @IBAction func btn_Cart(_ sender: UIButton) {
        viewModel.navigateToCartViewController(from: self.navigationController!)
    }
}

extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == main_ServicesCollection {
            return self.viewModel.arrayBannerList.count
        } else {
            return self.viewModel.arrayServiceList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == main_ServicesCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainServiceCell", for: indexPath) as! MainServiceCell
            let obj = viewModel.arrayBannerList[indexPath.row]
            
            if Router.BASE_IMAGE_URL != obj.image {
                Utility.setImageWithSDWebImage(obj.image ?? "", cell.banner_Img)
            } else {
                cell.banner_Img.image = R.image.no_Image_Available()
            }
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ServiceCell", for: indexPath) as! ServiceCell
            
            let obj = viewModel.arrayServiceList[indexPath.row]
            
            cell.lbl_ServiceName.text = obj.category_name ?? ""
            
            if Router.BASE_IMAGE_URL != obj.image {
                Utility.setImageWithSDWebImage(obj.image ?? "", cell.service_Img)
            } else {
                cell.service_Img.image = R.image.no_Image_Available()
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == main_ServicesCollection {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        } else {
            return CGSize(width: 140, height: collectionView.frame.height)
        }
    }
}

extension HomeVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.arrayStoreList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecShopCell", for: indexPath) as! RecShopCell
        
        let obj = viewModel.arrayStoreList[indexPath.row]
        
        cell.lbl_StoreName.text = obj.provider_name ?? ""
        cell.lbl_Address.text = obj.provider_streat_address ?? ""
        cell.btn_RatingReview.setTitle(obj.avg_rating ?? "", for: .normal)
        
        if Router.BASE_IMAGE_URL != obj.provider_logo {
            Utility.setImageWithSDWebImage(obj.provider_logo ?? "", cell.img)
        } else {
            cell.img.image = R.image.no_Image_Available()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.navigateToStoreDetailViewController(from: navigationController!, providerId: self.viewModel.arrayStoreList[indexPath.row].id ?? "")
    }
}

extension HomeVC {
    
    func initIndentifier()
    {
        self.service_CollectionVw.register(UINib(nibName: "ServiceCell", bundle: nil),forCellWithReuseIdentifier: "ServiceCell")
        self.main_ServicesCollection.register(UINib(nibName: "MainServiceCell", bundle: nil),forCellWithReuseIdentifier: "MainServiceCell")
        self.RecommendedShops_TableVw.register(UINib(nibName: "RecShopCell", bundle: nil), forCellReuseIdentifier: "RecShopCell")
    }
}
