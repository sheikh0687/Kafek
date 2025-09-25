//
//  ShopsVC.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 09/08/24.
//

import UIKit

class ShopsVC: UIViewController {
    
    @IBOutlet weak var shops_TableVw: UITableView!
    @IBOutlet weak var lbl_Headline: UILabel!
    @IBOutlet weak var btnBackOt: UIButton!
    
    let viewModel = ShopViewModel()
    let cartViewModel = CartListViewModel()
    var isNavigate:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.shops_TableVw.register(UINib(nibName: "RecShopCell", bundle: nil), forCellReuseIdentifier: "RecShopCell")
        if isNavigate == "Cart" {
            setUpCartBinding()
        } else {
            setUpStoreBinding()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isNavigate == "Cart" {
            self.navigationController?.navigationBar.isHidden = true
            self.tabBarController?.tabBar.isHidden = true
            self.lbl_Headline.text = R.string.localizable.myCart()
            self.btnBackOt.isHidden = false
        } else {
            self.navigationController?.navigationBar.isHidden = true
            self.tabBarController?.tabBar.isHidden = true
            self.lbl_Headline.text = R.string.localizable.shop()
            self.btnBackOt.isHidden = true
        }
    }
    
    deinit {
        print("Shops Screen deinit")
    }
    
    @IBAction func btn_Back_Tapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setUpStoreBinding()
    {
        viewModel.requestStoreList(vC: self)
        viewModel.storeSuccessResponse = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.shops_TableVw.reloadData()
            }
        }
    }
    
    private func setUpCartBinding()
    {
        cartViewModel.requestCartStoreList(vC: self)
        cartViewModel.cartSuccessResponse = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.shops_TableVw.reloadData()
            }
        }
    }

}

extension ShopsVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isNavigate == "Cart" {
            return self.cartViewModel.arrayCartStoreList.count
        } else {
            return self.viewModel.arrayStoreList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecShopCell", for: indexPath) as! RecShopCell
        
        if isNavigate == "Cart" {
            let obj = cartViewModel.arrayCartStoreList[indexPath.row]
            cell.lbl_StoreName.text = obj.provider_name ?? ""
            cell.cosmosVw.rating = Double(obj.avg_rating ?? 0)
            cell.lbl_Rating.text = String(obj.avg_rating ?? 0)
            cell.lbl_Timing.text = "\(R.string.localizable.open()): \(obj.open_time ?? "") - \(obj.close_time ?? "")"
            cell.lbl_Timing.textColor = #colorLiteral(red: 0, green: 0.5098039216, blue: 0, alpha: 1)
            cell.lbl_Description.text = obj.description ?? ""
            
            if Router.BASE_IMAGE_URL != obj.provider_logo {
                Utility.setImageWithSDWebImage(obj.provider_logo ?? "", cell.img)
            } else {
                cell.img.image = R.image.no_Image_Available()
            }
        } else {
            let obj = viewModel.arrayStoreList[indexPath.row]
            
            cell.lbl_StoreName.text = obj.provider_name ?? ""
            //        cell.cosmosVw.rating = Double(obj.avg_rating ?? 0)
            cell.lbl_Rating.text = obj.total_rating_count ?? ""
            cell.lbl_Timing.text = "\(R.string.localizable.open()): \(obj.open_time ?? "") - \(obj.close_time ?? "")"
            cell.lbl_Timing.textColor = #colorLiteral(red: 0, green: 0.5098039216, blue: 0, alpha: 1)
            cell.lbl_Description.text = obj.description ?? ""
            
            if Router.BASE_IMAGE_URL != obj.provider_logo {
                Utility.setImageWithSDWebImage(obj.provider_logo ?? "", cell.img)
            } else {
                cell.img.image = R.image.no_Image_Available()
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isNavigate == "Cart" {
            cartViewModel.navigateToCartDetailViewController(from: navigationController!, providerId: self.cartViewModel.arrayCartStoreList[indexPath.row].id ?? "")
        } else {
            viewModel.navigateToStoreDetailViewController(from: navigationController!, providerId: self.viewModel.arrayStoreList[indexPath.row].id ?? "")
        }
    }
}

