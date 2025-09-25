//
//  BookingOrderDetailViewModel.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 06/02/25.
//

import Foundation

class BookingOrderDetailViewModel {
    
    var arrayBookingOrderDetail: [Cart_details] = []
    var cloSuccesfull: (() -> Void)?
    
    var orderiD:String = ""
    
    var categoryName:String = ""
    var ratingStar:String = ""
    var ratingCount:String = ""
    var orderDate:String = ""
    var providerAddress:String = ""
    var requestiD:String = ""
    var provideriD:String = ""
    var status:String = ""
    var paymentMethod:String = ""
    var paymentStatus:String = ""
    
    var totalAmount:String = ""
    var driverOfferAmt:String = ""
    var deliveryFee:String = ""
    var adminFee:String = ""
    
    var cloChangeStatus: (() -> Void)?
    
    func getBookingOrderDetail(vC: UIViewController) {
        var paramDict: [String : AnyObject] = [:]
        paramDict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        paramDict["order_id"] = orderiD as AnyObject
        
        print(paramDict)
        
        Api.shared.requestToBookingOrderDetail(vC, paramDict) { [weak self] responseData in
            guard let self = self else { return }
            let obj = responseData
            
            self.categoryName = "\(obj.provider_details?.first_name ?? "") \(obj.provider_details?.last_name ?? "")"
            self.ratingStar = String(obj.provider_details?.avg_rating ?? 0)
            self.ratingCount = String(obj.provider_details?.avg_rating ?? 0)
            self.providerAddress = obj.user_details?.address ?? ""
            self.requestiD = obj.id ?? ""
            self.provideriD = obj.provider_id ?? ""
            self.status = obj.status ?? ""
            self.paymentMethod = "\(obj.payment_method ?? "") \(R.string.localizable.payment()): \(obj.payment_status ?? "")"
            self.paymentStatus = obj.payment_status ?? ""
            self.totalAmount = obj.total_amount ?? ""
            self.driverOfferAmt = obj.driver_offer_amount ?? ""
            self.orderDate = obj.date_time ?? ""
            self.deliveryFee = obj.delivery_fee ?? ""
            self.adminFee = obj.admin_commission ?? ""
            
            if let obj_CartDetail = obj.cart_details {
                if obj_CartDetail.count > 0 {
                    self.arrayBookingOrderDetail = obj_CartDetail
                } else {
                    self.arrayBookingOrderDetail = []
                }
                self.cloSuccesfull?()
            }
        }
    }
    
    func changeOrderStatus(vC: UIViewController, strStatus: String) {
        var paramDict: [String : AnyObject] = [:]
        paramDict["order_id"] = orderiD as AnyObject
        paramDict["status"] = strStatus as AnyObject
        paramDict["self_delivery_status"] = k.emptyString as AnyObject
        
        print(paramDict)
        
        Api.shared.requestToChangeOrderStatus(vC, paramDict) { [weak self] responseData in
            guard let self = self else { return }
            self.cloChangeStatus?()
        }
    }
}
