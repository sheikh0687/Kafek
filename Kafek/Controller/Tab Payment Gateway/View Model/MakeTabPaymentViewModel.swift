//
//  MakeTabPaymentViewModel.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 22/04/25.
//

import Foundation
import SwiftyJSON

class MakeTabPaymentViewModel {
    
    var tabPayAmt:String = ""
    var strAmount:String = ""
    var strTabOrderiD:String = ""
    
    var payProvideriD:String = ""
    var payRequestiD:String = ""
    
    var paymentFor:String = ""
    var strPaymentType:String = ""
    var strWalletAmt:String = ""
    
    var isDirectAccept:String = ""
    
    let viewModel = RequestProviderViewModel()
    
    var cloDirectAcceptCardPay: ((String) -> Void)?
        
    var onPaymentSuccess: (() -> Void)?
    var onPaymentFailure: ((_ message: String) -> Void)?

    func handleRedirectResponse(jsonString: String, vC: UIViewController) {
        print("✅ Received JSON: \(jsonString)")

        guard let jsonData = jsonString.data(using: .utf8) else {
            onPaymentFailure?("Invalid JSON data")
            return
        }

        do {
            if let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                print("✅ Parsed JSON: \(json)")

                if let status = json["status"] as? String, status.lowercased() == "success" {
                    // Call API or notify view
                    if paymentFor == "Wallet" {
                        requestToAddWalletAmount(vC: vC)
                    } else {
                        PaymentIntegration(vC: vC)
                    }
                } else {
                    let message = json["message"] as? String ?? "Unknown error"
                    onPaymentFailure?(message)
                }
            }
        } catch {
            onPaymentFailure?("JSON Parsing Error: \(error.localizedDescription)")
        }
    }

    func requestToAddWalletAmount(vC: UIViewController) {
        var paramDict: [String : AnyObject] = [:]
        paramDict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        paramDict["payment_method"] = "Card" as AnyObject
        paramDict["payment_type"] = "Card" as AnyObject
        paramDict["transaction_type"] = "Wallet" as AnyObject
        paramDict["total_amount"] = strAmount as AnyObject?
        
        print(paramDict)
        
        Api.shared.requestToAddWalletAmount(vC, paramDict) { [weak self] responseData in
            guard let self = self else { return }
            self.onPaymentSuccess?()
        }
    }
    
    func PaymentIntegration(vC: UIViewController)
    {
        var paramDict: [String : AnyObject] = [:]
        paramDict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        paramDict["payment_method"] = strPaymentType as AnyObject
        paramDict["payment_type"] = strPaymentType as AnyObject
        paramDict["total_amount"] = strAmount as AnyObject
        paramDict["provider_id"] = payProvideriD as AnyObject
        paramDict["request_id"] = payRequestiD as AnyObject
        paramDict["transaction_id"] = "" as AnyObject
        paramDict["currency"] = "SAR" as AnyObject
        paramDict["token"] = k.emptyString as AnyObject
        paramDict["transaction_type"] = "Order" as AnyObject
        paramDict["wallet_amount"] = strWalletAmt as AnyObject
        
        print(paramDict)
        
        Api.shared.add_Payment(vC, paramDict) { [weak self] responseData in
            guard let self = self else { return }
            self.parseDataSaveCard(apiResponse: responseData, vCs: vC)
        }
    }
    
    func parseDataSaveCard(apiResponse : AnyObject, vCs: UIViewController) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            let swiftyJsonVar = JSON(apiResponse)
            print(swiftyJsonVar)
            if(swiftyJsonVar["status"] == 1) {
                print(swiftyJsonVar["result"]["id"].stringValue)
                self.cloDirectAcceptCardPay?(swiftyJsonVar["result"]["id"].stringValue)
            } else {
                Utility.showAlertWithAction(withTitle: k.appName, message: L102Language.currentAppleLanguage() == "en" ? "Something went wrong" : "حدث خطأ ما", delegate: nil, parentViewController: vCs, completionHandler: { (boool) in
                })
            }
        }
    }
}
 
