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
        Api.shared.requestToBanner(vC) { responseData in
            if responseData.count > 0 {
                self.arrayBannerList = responseData
            } else {
                self.arrayBannerList = []
            }
            self.bannerSuccessResponse?()
        }
    }
    
    var arrayServiceList: [Res_Services] = []
    var serviceSuccessResponse:(() -> Void)?
    
    func requestServiceList(vC: UIViewController)
    {
        Api.shared.requestToAllService(vC) { responseData in
            if responseData.count > 0 {
                self.arrayServiceList = responseData
            } else {
                self.arrayBannerList = []
            }
            self.serviceSuccessResponse?()
        }
    }
    
    var arrayStoreList: [Res_Stores] = []
    var storeSuccessResponse:(() -> Void)?
    var tableHieght: NSLayoutConstraint!
    
    func requestStoreList(vC: UIViewController)
    {
        Api.shared.requestToAllStore(vC) { responseData in
            if responseData.count > 0 {
                self.arrayStoreList = responseData
                self.tableHieght.constant = CGFloat(responseData.count * 160)
            } else {
                self.arrayStoreList = []
            }
            self.storeSuccessResponse?()
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
        vC.cloAddress = { addressVal in
            print(addressVal)
            addressValue.text = addressVal
        }
        navigate?.pushViewController(vC, animated: true)
    }
    
    func navigateToCartViewController(from navigationController: UINavigationController)
    {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "CartVC") as! CartVC
        navigationController.pushViewController(vc, animated: true)
    }
}
