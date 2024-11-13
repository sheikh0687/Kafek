//
//  DeliveryHubDtViewModel.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 19/09/24.
//

import Foundation

class DeliveryHubDtViewModel {
    
    var arrayOfStoreProductDetail: Res_StoreProductDetail!
    var arrayOfProductImages: [Product_images] = []
    var arrayOfProductSizesPrice: [Product_size_price] = []
    var successResponse:(() -> Void)?
    
    var productId = ""
    
    func requestToGetAllProductDt(vC: UIViewController)
    {
        var paramDict: [String : AnyObject] = [:]
        paramDict["product_id"] = productId as AnyObject
        
        print(paramDict)
        
        Api.shared.requestToStoreProductDetails(vC, paramDict) { responseData in
            self.arrayOfStoreProductDetail = responseData
            let obj = responseData
            if let obj_ProductImg = obj.product_images {
                if obj_ProductImg.count > 0 {
                    self.arrayOfProductImages = obj_ProductImg
                } else {
                    self.arrayOfProductImages = []
                }
            }
            
            if let obj_ProductSizePrice = obj.product_size_price {
                if obj_ProductSizePrice.count > 0 {
                    self.arrayOfProductSizesPrice = obj_ProductSizePrice
                } else {
                    self.arrayOfProductSizesPrice = []
                }
            }
            self.successResponse?()
        }
    }
}
