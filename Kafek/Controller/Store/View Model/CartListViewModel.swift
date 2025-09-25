//
//  CartListViewModel.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 06/02/25.
//

import Foundation

class CartListViewModel {
    
    var arrayCartStoreList: [Res_CartList] = []
    var cartSuccessResponse:(() -> Void)?
    
    func requestCartStoreList(vC: UIViewController)
    {
        Api.shared.requestToCartList(vC) { [weak self] responseData in
            guard let self = self else { return }
            if responseData.count > 0 {
                self.arrayCartStoreList = responseData
            } else {
                self.arrayCartStoreList = []
            }
            self.cartSuccessResponse?()
        }
    }
    
    func navigateToCartDetailViewController(from navigationController: UINavigationController, providerId: String)
    {
        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "CartVC") as! CartVC
        vC.viewModel.provideriD = providerId
        navigationController.pushViewController(vC, animated: true)
    }
}
