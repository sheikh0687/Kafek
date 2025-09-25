//
//  RequestProviderViewModel.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 15/02/25.
//

import Foundation

class RequestProviderViewModel {
    
    var arrayOfServiceDetails: Res_OrderedServiceDetails!
    var arrayOfProductImages: [Product_images] = []
    
    var orderiD:String = ""
    var productiD:String = ""
    var totalAmt:String = ""
    var totalCount:String = ""
    
    var provideriD:String = ""
    var vehicleiD:String = ""
    var priceType:String = ""
    var strNotes:String = ""
    var strDeliveryFee:String = ""
    var directDellivery:String = ""
    
    var valAddressId:String = ""
    var valAddress:String = ""
    var valLat:String = ""
    var valLon:String = ""
    var zoneiD:String = ""
    var zoneName:String = ""
    var zonePrice:String = ""
    var zonePriceiD:String = ""
    
    var arrImage:[[String : AnyObject]] = []
    
    var cloServiceAddedSuccessful:((_ orderiD:String) -> Void)?
    var cloAddToCartSuccessful:() -> Void = {}
    var cloPlaceOrderSuccessful:() -> Void = {}
    
    func addOrdersInCart(vC: UIViewController) {
        let obj = arrayOfServiceDetails
        var paramDict: [String: AnyObject] = [:]
        paramDict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        paramDict["item_type"] = obj?.item_type as AnyObject
        paramDict["product_id"] = productiD as AnyObject
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
                if directDellivery == "Yes" {
                    CustomLoader.showCustomLoader()
                    cloAddToCartSuccessful()
                } else {
                    self.placeServiceRequest(vC: vC, paymentMethod: k.emptyString, paymentiD: "")
                }
            } else {
                print(responseData.message ?? "")
            }
        }
    }
    
    func placeServiceRequest(vC: UIViewController, paymentMethod: String, paymentiD: String) {
        var paramDict: [String : String] = [:]
        paramDict["user_id"] = k.userDefault.value(forKey: k.session.userId) as? String
        paramDict["provider_id"] = provideriD
        paramDict["driver_id"] = k.emptyString
        paramDict["vehicle_id"] = vehicleiD
        paramDict["address_id"] = valAddressId
        paramDict["address"] = valAddress
        paramDict["lat"] = String(valLat)
        paramDict["lon"] = String(valLon)
        paramDict["price_type"] = priceType
        paramDict["user_note"] = strNotes
        paramDict["delivery_fee"] = strDeliveryFee
        paramDict["total_amount"] = totalAmt
        paramDict["zone_id"] = zoneiD
        paramDict["zone_price_id"] = zonePriceiD
        paramDict["zone_name"] = zoneName
        paramDict["zone_price"] = zonePrice
        paramDict["direct_accepted"] = directDellivery
        paramDict["payment_method"] = paymentMethod
        paramDict["payment_type"] = paymentMethod
        paramDict["payment_id"] = paymentiD
        
        print("This Api called from Closure :\(paramDict)")
        
        var paramImg: [String : Array<Any>] = [:]
        var arrayOfImages: [UIImage] = []
        if self.arrImage.count > 0 {
            for val in arrImage {
                if let type = val["type"] as? String, type == "local" {
                    arrayOfImages.append(val["image"] as! UIImage)
                }
            }
        }
        
        paramImg["request_images[]"] = arrayOfImages
        
        print(paramImg)
        
        Api.shared.requestToPlaceServiceOrder(vC, paramDict, imgParam: paramImg) { [weak self] responseData in
            guard let self = self else { return }
            
            self.cloServiceAddedSuccessful?(responseData.id ?? "")
        }
    }
    
    func requestToPlaceOrder(vC: UIViewController) {
        var paramDict: [String : AnyObject] = [:]
        paramDict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        paramDict["delivery_fee"] = strDeliveryFee as AnyObject
        paramDict["address"] = valAddress as AnyObject
        paramDict["address_id"] = valAddressId as AnyObject
        paramDict["lat"] = String(valLat) as AnyObject
        paramDict["lon"] = String(valLon) as AnyObject
        paramDict["total_amount"] = totalAmt as AnyObject
        paramDict["provider_id"] = provideriD as AnyObject
        paramDict["vehicle_id"] = vehicleiD as AnyObject
        paramDict["payment_method"] = "Cash" as AnyObject
        
        print(paramDict)
        
        Api.shared.requestToPlaceOrder(vC, paramDict) { [weak self] responseData in
            guard let self = self else { return }
            
            self.cloPlaceOrderSuccessful()
        }
    }
}

