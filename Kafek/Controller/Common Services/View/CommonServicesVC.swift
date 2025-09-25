//
//  CommonServicesVC.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 03/02/25.
//

import UIKit

class CommonServicesVC: UIViewController {

    @IBOutlet weak var services_CollectionVw: UICollectionView!
    @IBOutlet weak var shops_TableVw: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var lbl_Headline: UILabel!
    
    let viewModel = CommonServiceViewModel()
    var strTitle:String = ""
    
    var arrayStoreList: [Res_Stores] = []
    var arrayStoreFiltered: [Res_Stores] = []
    var arrayServiceList: [Res_Services] = []
    var arrayServiceFiltered: [Res_Services] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setupSearchBar(searchBar: searchBar)
        self.searchBar.showsScopeBar = true
        self.searchBar.returnKeyType = .done

        self.lbl_Headline.text = strTitle
        self.shops_TableVw.register(UINib(nibName: "RecShopCell", bundle: nil), forCellReuseIdentifier: "RecShopCell")
        self.services_CollectionVw.register(UINib(nibName: "ServiceCell", bundle: nil),forCellWithReuseIdentifier: "ServiceCell")
        if strTitle == "All Shops" || strTitle == "جميع المحلات" {
            self.shops_TableVw.isHidden = false
            self.services_CollectionVw.isHidden = true
        } else {
            self.shops_TableVw.isHidden = true
            self.services_CollectionVw.isHidden = false
        }
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
    
    @IBAction func btn_BackTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    deinit {
        print("Common Service VC deinit")
    }
}

extension CommonServicesVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayStoreList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecShopCell", for: indexPath) as! RecShopCell
        
        let obj = arrayStoreList[indexPath.row]
        
        cell.lbl_StoreName.text = obj.provider_name ?? ""
        cell.lbl_Rating.text = obj.total_rating_count ?? ""
        cell.lbl_Timing.text = "\(R.string.localizable.open()): \(obj.open_time ?? "") - \(obj.close_time ?? "")"
        cell.lbl_Timing.textColor = #colorLiteral(red: 0, green: 0.5098039216, blue: 0, alpha: 1)
        cell.lbl_Description.text = obj.description ?? ""
        
        if Router.BASE_IMAGE_URL != obj.provider_logo {
            Utility.setImageWithSDWebImage(obj.provider_logo ?? "", cell.img)
        } else {
            cell.img.image = R.image.no_Image_Available()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = arrayStoreList[indexPath.row]
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "HubVC") as! StoreDetailVC
        vc.viewModel.providerId = obj.id ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension CommonServicesVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayServiceList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ServiceCell", for: indexPath) as! ServiceCell
        let obj = arrayServiceList[indexPath.row]
        cell.mainVw.cornerRadius = 10
        cell.service_Img.roundCorners(corners: [.allCorners], radius: 10)
        cell.lbl_ServiceName.isHidden = true
        cell.lbl_ServiceName.text = obj.category_name ?? ""
        
        if Router.BASE_IMAGE_URL != obj.image {
            Utility.setImageWithSDWebImage(obj.image ?? "", cell.service_Img)
        } else {
            cell.service_Img.image = R.image.no_Image_Available()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let obj = arrayServiceList[indexPath.row]
        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "EquipmentVC") as! EquipmentVC
        vC.viewModel.catiD = obj.id ?? ""
        vC.viewModel.serviceiMG = obj.image ?? ""
        self.navigationController?.pushViewController(vC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: services_CollectionVw.frame.width / 3, height: 150)
    }
}

extension CommonServicesVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if strTitle == "All Shops" || strTitle == "جميع المحلات" {
            if searchText.isEmpty {
                self.arrayStoreList = arrayStoreFiltered
            } else {
                self.arrayStoreList = arrayStoreFiltered.filter {
                    $0.provider_name?.range(of: searchText, options: [.diacriticInsensitive, .caseInsensitive]) != nil
                }
            }
            self.shops_TableVw.reloadData()

        } else {
            if searchText.isEmpty {
                self.arrayServiceList = arrayServiceFiltered
            } else {
                self.arrayServiceList = arrayServiceFiltered.filter {
                    $0.category_name?.range(of: searchText, options: [.diacriticInsensitive, .caseInsensitive]) != nil
                }
            }
            self.services_CollectionVw.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
}

