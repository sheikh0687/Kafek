//
//  ShopsVC.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 09/08/24.
//

import UIKit

class ShopsVC: UIViewController {

    @IBOutlet weak var shops_TableVw: UITableView!
    
    let viewModel = ShopViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.shops_TableVw.register(UINib(nibName: "RecShopCell", bundle: nil), forCellReuseIdentifier: "RecShopCell")
        setUpStoreBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func setUpStoreBinding()
    {
        viewModel.requestStoreList(vC: self)
        viewModel.storeSuccessResponse = {
            DispatchQueue.main.async {
                self.shops_TableVw.reloadData()
            }
        }
    }
    
}

extension ShopsVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.arrayStoreList.count
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

