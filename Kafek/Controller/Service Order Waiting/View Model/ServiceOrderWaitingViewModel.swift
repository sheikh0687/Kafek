//
//  ServiceOfferViewModel.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 17/02/25.
//

import Foundation

class ServiceOrderWaitingViewModel {
    
    var orderiD:String = ""
    var itemName:String = ""
    var priceType:String = ""
    var itemQuantity:String = ""
    var expectedPrice:String = ""
    var driverOfferAmount:String = ""
    var strDateTime:String = ""
    
    var strStatus:String = ""
    var strPaymentStatus:String = ""
    var strWaitingForOffer:String = ""
    
    var strDriverName:String = ""
    var strDriveriD:String = ""
    
    var isChatOpen:String = ""
    var isCallOpen:String = ""
    var isRatingReviewDriver:String = ""
    var strDriverMobileNum:String = ""
    var strUserNotes:String = ""
    
    var strAddressLat:String = ""
    var strAddressLon:String = ""
    var strCancelRequest:String = ""
    
    var strServiceImg:String = ""
    
    var arrayBookingOrderDetail: [Cart_details] = []
    var arrayPlaceBidding: [Res_PlaceBid] = []
    var arrayDriverDetails: Driver_details?
    var arrayPlaceOrderImg: [Place_order_images] = []
    
    var cloSuccesfull:(() -> Void)?
    var cloSuccessfullBid:() -> Void = {}
    var cloOfferRejected:() -> Void = {}
    var cloCancelAcceptedOrder:() -> Void = {}
    
    func getBookingOrderDetail(vC: UIViewController) {
        var paramDict: [String : AnyObject] = [:]
        paramDict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        paramDict["order_id"] = orderiD as AnyObject
        
        print(paramDict)
        
        Api.shared.requestToBookingOrderDetail(vC, paramDict) { [weak self] responseData in
            guard let self = self else { return }
            
            let obj = responseData
            self.orderiD = obj.id ?? ""
            self.strStatus = obj.status ?? ""
            self.expectedPrice = obj.total_amount ?? ""
            self.priceType = obj.price_type ?? ""
            self.driverOfferAmount = obj.driver_offer_amount ?? ""
            self.strDateTime = obj.date_time ?? ""
            self.strDriveriD = obj.driver_id ?? ""
            self.strUserNotes = obj.user_note ?? ""
            self.strCancelRequest = obj.cancel_by_user ?? ""
            
            if obj.payment_type != "" {
                self.strPaymentStatus = "\(obj.payment_type ?? "") Payment \(obj.payment_status ?? "")"
            } else {
                self.strPaymentStatus = "Online Payment \(obj.payment_status ?? "")"
            }
            
            self.isRatingReviewDriver = obj.rating_review_driver ?? ""
            
            if obj.direct_accepted == "Yes" {
                self.strWaitingForOffer = R.string.localizable.waitingForAccept()
            } else {
                self.strWaitingForOffer = R.string.localizable.waitingForOffers()
            }
            
            if let obj_DriverDetail = obj.driver_details {
                self.arrayDriverDetails = obj_DriverDetail
            }
            
            self.strAddressLat = obj.address_details?.lat ?? ""
            self.strAddressLon = obj.address_details?.lon ?? ""
            
            if let obj_CartDetail = obj.cart_details {
                if obj_CartDetail.count > 0 {
                    self.arrayBookingOrderDetail = obj_CartDetail
                    let chatStatus = obj.cart_details?[0].product_details?.chat ?? ""
                    let callStatus = obj.cart_details?[0].product_details?.call ?? ""
                    self.strServiceImg = obj.cart_details?[0].product_image ?? ""
                    self.isChatOpen = chatStatus
                    self.isCallOpen = callStatus
                } else {
                    self.arrayBookingOrderDetail = []
                }
                self.cloSuccesfull?()
            }
            
            if let obj_PlaceOrderImage = obj.place_order_images {
                if obj_PlaceOrderImage.count > 0 {
                    self.arrayPlaceOrderImg = obj_PlaceOrderImage
                } else {
                    self.arrayPlaceOrderImg = []
                }
            }
        }
    }
    
    func getPlaceBid(vC: UIViewController, tableView: UITableView)
    {
        var paramDict: [String : AnyObject] = [:]
        paramDict["order_id"] = orderiD as AnyObject
        paramDict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        
        print(paramDict)
        
        Api.shared.requestToPlaceBid(vC, paramDict) { [weak self] responseData in
            guard let self = self else { return }
            
            if responseData.status == "1" {
                if let res = responseData.result {
                    if res.count > 0 {
                        self.arrayPlaceBidding = res
                        tableView.backgroundView = UIView()
                        tableView.reloadData()
                    }
                }
            } else {
                self.arrayPlaceBidding = []
                tableView.backgroundView = UIView()
                tableView.reloadData()
            }
            self.cloSuccessfullBid()
        }
    }
    
    func offerRejection(vC: UIViewController,place_bid_id:String, driver_id:String)
    {
        var paramDict: [String : AnyObject] = [:]
        paramDict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        paramDict["order_id"] = orderiD as AnyObject
        paramDict["place_bid_id"] = place_bid_id as AnyObject
        paramDict["driver_id"] = driver_id as AnyObject
        paramDict["status"] = "Reject" as AnyObject
        
        print(paramDict)
        
        Api.shared.requestToAcceptOrRejectOffer(vC, paramDict) { [weak self] responseData in
            guard let self = self else { return }
            
            self.cloOfferRejected()
        }
    }
    
    func requestToCancelAcceptedOrder(vC: UIViewController, cancelReason:String)
    {
        var paramDict: [String : AnyObject] = [:]
        paramDict["order_request_id"] = orderiD as AnyObject
        paramDict["cancel_reason"] = cancelReason as AnyObject
        
        print(paramDict)
        
        Api.shared.requestToCancelAcceptedOrder(vC, paramDict) { [weak self] responseData in
            guard let self = self else { return }
            
            self.cloCancelAcceptedOrder()
        }
    }
}
