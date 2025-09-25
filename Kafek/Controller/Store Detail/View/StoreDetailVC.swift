//
//  HubVC.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 09/08/24.
//

import UIKit
import Parchment
import SnapKit

class StoreDetailVC: UIViewController {
    
    @IBOutlet weak var store_Img: UIImageView!
    @IBOutlet weak var lbl_StoreName: UILabel!
    @IBOutlet weak var lbl_StoreAddress: UILabel!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var pagingView: UIView!
    @IBOutlet weak var lbl_Headline: UILabel!
    
    let viewModel = StoreDetailViewModel()
    var vcs:[ContentVC] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lbl_Headline.text = R.string.localizable.riverSandHub()
        setUpStoreDetailBinding()
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
        print("Store Detail SCreen deinit")
    }
    
    @IBAction func btnBackTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setUpStoreDetailBinding()
    {
        viewModel.requestAllStoreDetails(vC: self)
        viewModel.storeDtSuccessResponse = { [weak self] in
            guard let self = self else { return }
            
            self.lbl_StoreName.text = self.viewModel.storeName
            self.lbl_StoreAddress.text = self.viewModel.storeAddress
            
            if Router.BASE_IMAGE_URL != self.viewModel.storeImg {
                Utility.setImageWithSDWebImage(self.viewModel.storeImg, self.store_Img)
            } else {
                self.store_Img.image = R.image.no_Image_Available()
            }
            
            for i in 0...self.viewModel.arrayStoreCategoryDetail.count - 1 {
                self.vcs.append(ContentVC(index: L102Language.currentAppleLanguage() == "en" ? self.viewModel.arrayStoreCategoryDetail[i].category_name ?? "" : self.viewModel.arrayStoreCategoryDetail[i].category_name_ar ?? "",
                                          arrSubCategory: self.viewModel.arrayStoreCategoryDetail[i].product ?? [],
                                          catId: ""))
                if i == self.viewModel.arrayStoreCategoryDetail.count - 1 {
                    self.setUpCategories(self.vcs)
                }
            }
        }
    }
    
    func setUpCategories(_ vcs: [ContentVC]) {
        let pagingViewController = PagingViewController(viewControllers: vcs)
        pagingViewController.backgroundColor = .clear
        pagingViewController.collectionView.backgroundColor = .clear
        addChild(pagingViewController)
        pagingView.addSubview(pagingViewController.view)
        
        pagingViewController.view.snp.makeConstraints { make in
            make.top.equalTo(lblProductName.snp.bottom).offset(10) // Position below searchVw with a 20-point gap
            make.leading.trailing.equalToSuperview() // Stretch to the edges horizontally
            make.bottom.equalToSuperview() // Stretch to the bottom
        }
        
        pagingViewController.didMove(toParent: self)
    }
}
