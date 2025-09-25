//
//  EquipmentVC.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 03/02/25.
//

import UIKit

class EquipmentVC: UIViewController {

    @IBOutlet weak var equipment_Img: UIImageView!
    @IBOutlet weak var equipment_TableVw: UITableView!
    @IBOutlet weak var lbl_Headlin: UILabel!
    
    let viewModel = ServiceDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.equipment_TableVw.register(UINib(nibName: "CatProductCell", bundle: nil), forCellReuseIdentifier: "CatProductCell")
        self.lbl_Headlin.text = viewModel.serviceName
        setupBinding()
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
        print("Equiment screen deinit")
    }
    
    @IBAction func btn_Back_Tapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupBinding() {
        self.viewModel.getImage(imageName: self.equipment_Img)
        viewModel.fetchEquipmentDetails(vC: self)
        viewModel.cloFethcedSuccessfull = { [weak self] in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.equipment_TableVw.reloadData()
            }
        }
    }
}

extension EquipmentVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.arrayOfServiceDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatProductCell", for: indexPath) as! CatProductCell
        let obj = self.viewModel.arrayOfServiceDetails[indexPath.row]
        
        cell.priceVw.isHidden = true
        if L102Language.currentAppleLanguage() == "ar" {
            cell.lbl_ItemName.text = obj.item_name_ar ?? ""
            cell.lbl_Decription.text = obj.short_description_ar ?? ""
        } else {
            cell.lbl_ItemName.text = obj.item_name ?? ""
            cell.lbl_Decription.text = obj.short_description ?? ""
        }
        
        if let obj_ProductImg = obj.product_images {
            if obj_ProductImg.count > 0 {
                if Router.BASE_IMAGE_URL != obj_ProductImg[0].image {
                    Utility.setImageWithSDWebImage(obj_ProductImg[0].image ?? "", cell.img)
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
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = self.viewModel.arrayOfServiceDetails[indexPath.row]
        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "ServiceOrderDetailVC") as! ServiceOrderDetailVC
        vC.viewModel.productiD = obj.id ?? ""
        vC.viewModel.type = obj.item_type ?? ""
        self.navigationController?.pushViewController(vC, animated: true)
    }
}
