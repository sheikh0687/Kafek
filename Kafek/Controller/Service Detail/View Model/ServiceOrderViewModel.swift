//
//  ServiceOrderViewModel.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 14/02/25.
//

import Foundation

class ServiceOrderViewModel {
    
    var orderiD:String = ""
    var productiD:String = ""
//    var totalCount:String = ""
    var type:String = ""
    
    var successResponse:(() -> Void)?
    
    var arrayOfServiceDetails: Res_OrderedServiceDetails!
    var arrayOfProductImages: [Product_images] = []
    
    func requestToGetServiceDt(vC: UIViewController)
    {
        var paramDict: [String : AnyObject] = [:]
        paramDict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        paramDict["product_id"] = productiD as AnyObject
        paramDict["type"] = type as AnyObject
        
        print(paramDict)
        
        Api.shared.requestToOrderedServiceDetails(vC, paramDict) { [weak self] responseData in
            guard let self = self else { return }
            self.arrayOfServiceDetails = responseData
            let obj = responseData
            self.orderiD = obj.id ?? ""
            if let obj_ProductImg = obj.product_images {
                if obj_ProductImg.count > 0 {
                    self.arrayOfProductImages = obj_ProductImg
                } else {
                    self.arrayOfProductImages = []
                }
            }
            self.successResponse?()
        }
    }
    
    var finalPriceWithZonePrice:Double = 0.0
    var strZoneiD:String = ""
    var strZonePrice:String = ""
    var strZoneName:String = ""
    var strZonePriceiD:String = ""
    
    func caculateServicePriceWithZone(vC: UIViewController, strItmePrice:String, strLat:String, strLon:String, totalCount: Int)
    {
        var paramDict: [String : AnyObject] = [:]
        paramDict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        paramDict["service_id"] = productiD as AnyObject
        paramDict["current_item_price"] = strItmePrice as AnyObject
        paramDict["total_count"] = totalCount as AnyObject
        paramDict["lat"] = strLat as AnyObject
        paramDict["lon"] = strLon as AnyObject
        
        print(paramDict)
        
        Api.shared.requestToCalculateServicePriceZone(vC, param: paramDict) { [weak self] responseData in
            guard let self = self else { return }
            
            if let finalAmt = responseData.final_price,
               let zoneId = responseData.zone_id,
               let zone_name = responseData.zone_name,
               let zone_price = responseData.zone_price,
               let zone_price_id = responseData.zone_price_id,
               let finalAmtInt = Double(finalAmt),
               finalAmtInt != 0 {
                print(finalAmtInt)
                self.finalPriceWithZonePrice = finalAmtInt
                self.strZoneiD = zoneId
                self.strZoneName = zone_name
                self.strZonePrice = zone_price
                self.strZonePriceiD = zone_price_id
                print(self.finalPriceWithZonePrice)
//                self.cloSuccessCalculation?()
            }
        }
    }
}
