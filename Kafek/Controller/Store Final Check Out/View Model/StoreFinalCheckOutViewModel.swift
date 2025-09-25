//
//  DeliveryHubDtViewModel.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 19/09/24.
//

import Foundation

class StoreFinalCheckOutViewModel {
    
    var arrayOfStoreProductDetail: Res_StoreProductDetail!
    var arrayOfProductImages: [Product_images] = []
    var arrayOfProductSizesPrice: [Product_size_price] = []
    var successResponse:(() -> Void)?
    
    var addedSuccessful:(() -> Void)?
    var productId = ""
    var totalAmt:Int = 0
    var totalCount:Int = 0
    var strTotalOfferPrice:String = ""
    
    func requestToGetAllProductDt(vC: UIViewController)
    {
        var paramDict: [String : AnyObject] = [:]
        paramDict["product_id"] = productId as AnyObject
        
        print(paramDict)
        
        Api.shared.requestToStoreProductDetails(vC, paramDict) { [weak self] responseData in
            guard let self = self else { return }
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
    
    func addOrdersInCart(vC: UIViewController) {
        let obj = arrayOfStoreProductDetail
        var paramDict: [String: AnyObject] = [:]
        paramDict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        paramDict["item_type"] = obj?.item_type as AnyObject
        paramDict["product_id"] = productId as AnyObject
        paramDict["size_id"] = k.emptyString as AnyObject
        paramDict["size_name"] = k.emptyString as AnyObject
        paramDict["cat_id"] = obj?.cat_id as AnyObject
        paramDict["cat_name"] = obj?.cat_name as AnyObject
        paramDict["product_name"] = obj?.item_name as AnyObject
        paramDict["product_price"] = obj?.item_price as AnyObject
        paramDict["provider_id"] = obj?.provider_id as AnyObject
        paramDict["total_amount"] = totalAmt as AnyObject
        paramDict["before_discount_amount"] = totalAmt as AnyObject
        paramDict["quantity"] = totalCount as AnyObject
        
        if self.arrayOfProductImages.count > 0 {
            if let firstImage = arrayOfProductImages.first?.image {
                let productImage = firstImage.replacingOccurrences(of: Router.BASE_IMAGE_URL, with: "")
                paramDict["product_image"] = productImage as AnyObject
            }
        } else {
            paramDict["product_image"] = k.emptyString as AnyObject
        }
        
        print(paramDict)
        
        Api.shared.requestToAddInCart(vC, paramDict) { [weak self] responseData in
            guard let self = self else { return }
            if responseData.status == "1" {
                self.addedSuccessful?()
            } else {
                print(responseData.message ?? "")
            }
        }
    }
}


