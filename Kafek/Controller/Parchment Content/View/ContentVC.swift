//
//  ContentVC.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 09/08/24.
//

import UIKit

final class ContentVC: UIViewController {

    let identifier = "CatProductCell"
    
    var arraySubCatDetail: [Product] = []
    
    convenience init(index: String, arrSubCategory: [Product], catId : String) {
        self.init(title: "\(index)", arrSub: arrSubCategory, catId: catId)
    }
    
    convenience init(title: String, arrSubCategory: [Product], catId : String) {
        self.init(title: title, arrSub: arrSubCategory, catId: catId)
    }
    
    init(title: String, arrSub: [Product], catId : String) {
        super.init(nibName: nil, bundle: nil)
        self.title = title
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .systemGroupedBackground
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        tableView.separatorStyle = .none
        self.arraySubCatDetail = arrSub
        tableView.reloadData()
        view.addSubview(tableView)
        view.backgroundColor = .clear
        view.constrainToEdgesAfterMargin(tableView, after: 10)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ContentVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arraySubCatDetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatProductCell", for: indexPath) as! CatProductCell
        
        let obj = self.arraySubCatDetail[indexPath.row]
        print(obj)
        
        cell.lbl_ItemName.text = obj.item_name ?? ""
        cell.lbl_Decription.text = obj.description ?? ""
        
        cell.lbl_ItemPrice.text = "SR \(obj.item_price ?? "0")"
        cell.lbl_ItemOfferPrice.text = "\(obj.offer_item_price ?? "0") SR"
        
        if let productImage = obj.product_images {
            if productImage.count > 0 {
                if Router.BASE_IMAGE_URL != productImage.first?.image {
                    Utility.setImageWithSDWebImage(productImage.first?.image ?? "", cell.img)
                } else {
                    cell.img.image = R.image.no_Image_Available()
                }
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
        let obj = self.arraySubCatDetail[indexPath.row]
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "StoreFinalCheckOutVC") as! StoreFinalCheckOutVC
        vc.viewModel.productId = obj.id ?? ""
        vc.viewModel.strTotalOfferPrice = obj.offer_item_price ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
