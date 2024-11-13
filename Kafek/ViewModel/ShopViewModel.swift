//
//  ShopViewModel.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 19/09/24.
//

import Foundation

class ShopViewModel {
    
    var arrayStoreList: [Res_Stores] = []
    var storeSuccessResponse:(() -> Void)?
    
    func requestStoreList(vC: UIViewController)
    {
        Api.shared.requestToAllStore(vC) { responseData in
            if responseData.count > 0 {
                self.arrayStoreList = responseData
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
    
}
