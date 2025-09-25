//
//  CartDetailViewModel.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 07/02/25.
//

import Foundation

class CartDetailViewModel {
    
    var arrayCartDetail: [Res_CartDetails] = []
    var cloSuccessfully:(() -> Void)?
    
    var subTotal:String = ""
    var taxAmt:String = ""
    var totalAmount:String = ""
    var deliveryFee:String = ""
    
    var provideriD:String = ""
    var cloUpdated:(() -> Void)?
    
    var cloDeleted:() -> Void = {}
    
    func requestCartDetail(vC: UIViewController) {
        var paramDict: [String : AnyObject] = [:]
        paramDict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        paramDict["provider_id"] = provideriD as AnyObject
        paramDict["item_type"] = "Item" as AnyObject
        
        print(paramDict)
        
        Api.shared.requestToCartDetail(vC, paramDict) { [weak self] responseData in
            guard let self = self else { return }
            
            let obj = responseData
            self.subTotal = obj.sub_total_amount ?? ""
            self.taxAmt = obj.total_tax ?? ""
            self.totalAmount = obj.total_amount ?? ""
            self.deliveryFee = obj.delivery_fee ?? ""
            
            if let obj_Res = responseData.result {
                if obj_Res.count > 0 {
                    self.arrayCartDetail = obj_Res
                }
            } else {
                self.arrayCartDetail = []
            }
            self.cloSuccessfully?()
        }
    }
    
    func updateCartItems(vC: UIViewController, strQuantity:String, strCartId:String, strType:String) {
        var paramDict: [String : AnyObject] = [:]
        paramDict["cart_id"] = strCartId as AnyObject
        paramDict["type"] = strType as AnyObject
        paramDict["quantity"] = strQuantity as AnyObject
        
        print(paramDict)
        
        Api.shared.requestToUpdateCart(vC, paramDict) { [weak self] responseData in
            guard let self = self else { return }
            
            if responseData.status == "1" {
                self.cloUpdated?()
            } else {
                print(responseData.message ?? "")
            }
        }
    }
    
    func deleteCartItem(vC: UIViewController, strCartId:String) {
        var paramDict: [String : AnyObject] = [:]
        paramDict["cart_id"] = strCartId as AnyObject
        
        print(paramDict)
        
        Api.shared.requestToDeleteCart(vC, paramDict) { [weak self] responseData in
            guard let self = self else { return }
            
            if responseData.status == "1" {
                self.cloDeleted()
            }
        }
    }
}
