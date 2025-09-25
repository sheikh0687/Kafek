//
//  HomeViewModel.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 17/09/24.
//

import Foundation

class HomeViewModel {
    
    var address:String = ""
    
    var arrayBannerList: [Res_BannerList] = []
    var bannerSuccessResponse:(() -> Void)?
    
    func requestBannerList(vC: UIViewController)
    {
        Api.shared.requestToBanner(vC) { [weak self] responseData in
            guard let self = self else { return }
            if responseData.count > 0 {
                self.arrayBannerList = responseData
            } else {
                self.arrayBannerList = []
            }
            self.bannerSuccessResponse?()
        }
    }
    
    var arrayStoreList: [Res_Stores] = []
    var storeSuccessResponse:(() -> Void)?
//    var tableHieght: NSLayoutConstraint!
    
    func requestStoreList(vC: UIViewController)
    {
        Api.shared.requestToAllStore(vC) { [weak self] responseData in
            guard let self = self else { return }
            if responseData.count > 0 {
                self.arrayStoreList = responseData
            } else {
                self.arrayStoreList = []
            }
            self.storeSuccessResponse?()
        }
    }

    var arrayServiceList: [Res_Services] = []
    var serviceSuccessResponse:(() -> Void)?
    var collectionVwHeight: NSLayoutConstraint!
    
    func requestServiceList(vC: UIViewController)
    {
        Api.shared.requestToAllService(vC) { [weak self] responseData in
            guard let self = self else { return }
            if responseData.count > 0 {
                var totalRows = 0
                if responseData.count <= 2 {
                    totalRows = 1
                } else {
                    let remaining = responseData.count - 2
                    totalRows = 1 + Int(ceil(Double(remaining) / 3.0))
                }

                let itemHeight: CGFloat = 150
                let spacing: CGFloat = 10
                self.collectionVwHeight.constant = (itemHeight * CGFloat(totalRows)) + (spacing * CGFloat(totalRows - 1))
                self.arrayServiceList = responseData
            } else {
                self.arrayBannerList = []
            }
            self.serviceSuccessResponse?()
        }
    }
    
    func navigateToStoreDetailViewController(from navigationController: UINavigationController, providerId: String)
    {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "HubVC") as! StoreDetailVC
        vc.viewModel.providerId = providerId
        navigationController.pushViewController(vc, animated: true)
    }
    
    func navigateToSavedAddressViewController(from navigate: UINavigationController?, addressValue: UILabel!) {
        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "SaveAddressVC") as! SaveAddressVC
        vC.isFrom = "Home"
        vC.cloAddress = { [weak self] addressVal in
            guard self != nil else { return }
            print(addressVal)
            addressValue.text = addressVal
        }
        navigate?.pushViewController(vC, animated: true)
    }
    
    func navigateToCartViewController(from navigationController: UINavigationController, isFor:String)
    {
        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "ShopsVC") as! ShopsVC
        vC.isNavigate = isFor
        navigationController.pushViewController(vC, animated: true)
    }
    
    func navigateToServiceDetailViewController(from navigationController: UINavigationController, catiD: String, serviceImg: String, serviceName: String)
    {
        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "EquipmentVC") as! EquipmentVC
        vC.viewModel.catiD = catiD
        vC.viewModel.serviceiMG = serviceImg
        vC.viewModel.serviceName = "\(R.string.localizable.available()) \(serviceName)"
        navigationController.pushViewController(vC, animated: true)
    }
}
