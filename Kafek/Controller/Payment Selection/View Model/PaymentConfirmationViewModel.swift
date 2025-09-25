//
//  PaymentConfirmationViewModel.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 19/02/25.
//

import Foundation
import SwiftyJSON

class PaymentConfirmationViewModel {
    
    var cloOfferAccepted:() -> Void = {}
    
    var orderiD:String!
    var place_bid_id:String!
    var driveriD:String!
    var offerAmt:String!
    var quantity:String!
    
    var provideriD:String!
    
    var cloOrderStatus:() -> Void = {}
//    var requestiD:String = ""
    
    func requestToAcceptOrder(vC: UIViewController)
    {
        var paramDict: [String : AnyObject] = [:]
        paramDict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        paramDict["order_id"] = orderiD as AnyObject
        paramDict["bid_id"] = place_bid_id as AnyObject
        paramDict["driver_id"] = driveriD as AnyObject
        paramDict["offer_amount"] = offerAmt as AnyObject
        paramDict["quantity"] = quantity as AnyObject
        
        print(paramDict)
        
        Api.shared.requestToAcceptOrRejectOffer(vC, paramDict) { [weak self] responseData in
            guard let self = self else { return }
            self.cloOfferAccepted()
        }
    }
    
//    https://techimmense.in/kafak/webservice/offer_accept_by_user?&order_id=23&bid_id=20&driver_id=39&user_id=14&offer_amount=900.00&payment_type=CASH%0D%0A&payment_method=CASH%0D%0A&quantity=3&total_amount=900.00
    
    // For Product
    func requestToUpdateOrderStatus(vC: UIViewController) {
        var paramDict: [String : AnyObject] = [:]
        paramDict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        paramDict["request_id"] = orderiD as AnyObject
        paramDict["payment_status"] = "Complete" as AnyObject
        paramDict["payment_method"] = "Cash" as AnyObject
        
        print(paramDict)
        
        Api.shared.requestToUpdateProductOrderStatus(vC, paramDict) { [weak self] responseData in
            guard let self = self else { return }
            
            if responseData.status == "1" {
                self.cloOrderStatus()
            } else {
                print(responseData.message ?? "")
            }
        }
    }
    
    var cloSuccessfulWalletPayment:((String) -> Void)?
    
    func addPaymentIntegration(vC: UIViewController, strPaymentType: String, strAmount: String, strWalletAmt: String)
    {
        var paramDict: [String : AnyObject] = [:]
        paramDict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        paramDict["payment_method"] = strPaymentType as AnyObject
        paramDict["payment_type"] = strPaymentType as AnyObject
        paramDict["total_amount"] = strAmount as AnyObject
        paramDict["provider_id"] = "" as AnyObject
        paramDict["request_id"] = orderiD as AnyObject
        paramDict["transaction_id"] = "" as AnyObject
        paramDict["currency"] = "SAR" as AnyObject
        paramDict["token"] = k.emptyString as AnyObject
        paramDict["transaction_type"] = "Order" as AnyObject
        paramDict["wallet_amount"] = strWalletAmt as AnyObject
        
        print(paramDict)
        
        Api.shared.add_Payment(vC, paramDict) { [weak self] responseData in
            guard let self = self else { return }
            print(responseData)
            self.parseDataSaveCard(apiResponse: responseData, vCs: vC)
        }
    }
    
    func parseDataSaveCard(apiResponse : AnyObject, vCs: UIViewController) {
        DispatchQueue.main.async { [weak self] in
            guard let self  else { return }
            
            let swiftyJsonVar = JSON(apiResponse)
            print(swiftyJsonVar)
            if(swiftyJsonVar["status"] == 1) {
                print(swiftyJsonVar["result"]["id"].stringValue)
                self.cloSuccessfulWalletPayment?(swiftyJsonVar["result"]["id"].stringValue)
            } else {
                Utility.showAlertWithAction(withTitle: k.appName, message: L102Language.currentAppleLanguage() == "en" ? "Something went wrong" : "حدث خطأ ما", delegate: nil, parentViewController: vCs, completionHandler: { (boool) in
                })
            }
        }
    }
}
