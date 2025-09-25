//
//  Api.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 10/09/24.
//

import Foundation

class Api: NSObject {
    
    static let shared = Api()
    private override init() {}
    
    func paramGetUserId() -> [String : AnyObject]
    {
        var dict: [String : AnyObject] = [:]
        dict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject
        return dict
    }
    
    func requestToLogin(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Res_Login) -> Void) {
        CustomLoader.showCustomLoader()
        Service.post(url: Router.login.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_Login.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    vC.alert(alertmessage: root.message ?? "")
                    k.userDefault.set(false, forKey: k.session.status)
                    k.userDefault.set(k.emptyString, forKey: k.session.userId)
                    k.userDefault.set(k.emptyString, forKey: k.session.userEmail)
                }
                CustomLoader.hideCustomLoader()
            } catch {
                print(error)
                CustomLoader.hideCustomLoader()
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            CustomLoader.hideCustomLoader()
        }
    }
    
    func requestToSignup(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Res_Login) -> Void) {
        CustomLoader.showCustomLoader()
        Service.post(url: Router.signup.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_Login.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    vC.alert(alertmessage: root.message ?? "")
                    k.userDefault.set(false, forKey: k.session.status)
                    k.userDefault.set(k.emptyString, forKey: k.session.userId)
                    k.userDefault.set(k.emptyString, forKey: k.session.userEmail)
                }
                CustomLoader.hideCustomLoader()
            } catch {
                print(error)
                CustomLoader.hideCustomLoader()
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            CustomLoader.hideCustomLoader()
        }
    }
    
    func requestToSendOtp(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Res_SendOtp) -> Void) {
        CustomLoader.showCustomLoader()
        Service.post(url: Router.send_otp.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_SendOtp.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    vC.alert(alertmessage: root.message ?? "")
                }
                CustomLoader.hideCustomLoader()
            } catch {
                print(error)
                CustomLoader.hideCustomLoader()
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            CustomLoader.hideCustomLoader()
        }
    }
    
    func requestToSendOtpForResetPassword(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Res_SendOtp) -> Void) {
        CustomLoader.showCustomLoader()
        Service.post(url: Router.send_otp_for_change_password.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_SendOtp.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    vC.alert(alertmessage: root.message ?? "")
                }
                CustomLoader.hideCustomLoader()
            } catch {
                print(error)
                CustomLoader.hideCustomLoader()
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            CustomLoader.hideCustomLoader()
        }
    }
    
    func requestToResetPassword(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Api_ForgotPassword) -> Void) {
        CustomLoader.showCustomLoader()
        Service.post(url: Router.forgot_password.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_ForgotPassword.self, from: response)
                if root.result != nil {
                    success(root)
                } else {
                    vC.alert(alertmessage: root.message ?? "")
                }
                CustomLoader.hideCustomLoader()
            } catch {
                print(error)
                CustomLoader.hideCustomLoader()
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            CustomLoader.hideCustomLoader()
        }
    }
    
    func requestToChangePassword(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Api_Basic) -> Void) {
        CustomLoader.showCustomLoader()
        Service.post(url: Router.change_password.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_Basic.self, from: response)
                if root.result != nil {
                    success(root)
                } else {
                    vC.alert(alertmessage: root.message ?? "")
                }
                CustomLoader.hideCustomLoader()
            } catch {
                print(error)
                CustomLoader.hideCustomLoader()
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            CustomLoader.hideCustomLoader()
        }
    }
    
    func requestToSendFeedback(_ vc: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Res_Contact) -> Void) {
        CustomLoader.showCustomLoader()
        Service.post(url: Router.send_feedback.url(), params: param, method: .get, vc: vc, successBlock: {(response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_ContactInfo.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    vc.alert(alertmessage: root.message ?? "")
                }
                CustomLoader.hideCustomLoader()
            } catch {
                print(error)
                CustomLoader.hideCustomLoader()
            }
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            CustomLoader.hideCustomLoader()
        }
    }

    func requestTopUserProfile(_ vC: UIViewController,_ success: @escaping(_ responseData: Api_Login) -> Void) {
        CustomLoader.showCustomLoader()
        Service.post(url: Router.get_profile.url(), params: paramGetUserId(), method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_Login.self, from: response)
                if root.result != nil {
                    success(root)
                } else {
                    print(root.message ?? "")
                }
                CustomLoader.hideCustomLoader()
            } catch {
                print(error)
                CustomLoader.hideCustomLoader()
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            CustomLoader.hideCustomLoader()
        }
    }

    func requestToUpdateProfile(_ vc: UIViewController, _ params: [String: String], images: [String : UIImage?]?, videos: [String : Data?]?, _ success: @escaping(_ responseData : Res_Login) -> Void) {
        CustomLoader.showCustomLoader()
        Service.postSingleMedia(url: Router.update_profile.url(), params: params, imageParam: images, videoParam: videos, parentViewController: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_Login.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    vc.alert(alertmessage: root.message ?? "Something went wrong")
                }
            } catch {
                print(error)
                CustomLoader.hideCustomLoader()
            }
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            CustomLoader.hideCustomLoader()
        }
    }
    
    func requestToBanner(_ vC: UIViewController,_ success: @escaping(_ responseData: [Res_BannerList]) -> Void) {
        Service.post(url: Router.get_banner.url(), params: paramGetUserId(), method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_BannerList.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                }
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
        }
    }
    
    func requestToAllService(_ vC: UIViewController,_ success: @escaping(_ responseData: [Res_Services]) -> Void) {
        Service.post(url: Router.get_services.url(), params: paramGetUserId(), method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_Service.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                }
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
        }
    }
    
    func requestToAllStore(_ vC: UIViewController,_ success: @escaping(_ responseData: [Res_Stores]) -> Void) {
        CustomLoader.showCustomLoader()
        Service.post(url: Router.get_all_store_list.url(), params: paramGetUserId(), method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_AllStores.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    print(root.message ?? "")
                }
                CustomLoader.hideCustomLoader()
            } catch {
                print(error)
                CustomLoader.hideCustomLoader()
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            CustomLoader.hideCustomLoader()
        }
    }
    
    func requestToStoreDetails(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Res_StoreDetail) -> Void) {
        CustomLoader.showCustomLoader()
        Service.post(url: Router.get_provider_details.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_StoreDetails.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    print(root.message ?? "")
                }
                CustomLoader.hideCustomLoader()
            } catch {
                print(error)
                CustomLoader.hideCustomLoader()
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            CustomLoader.hideCustomLoader()
        }
    }
    
    func requestToSavedAddress(_ vC: UIViewController,_ success: @escaping(_ responseData: Api_SavedAddress) -> Void) {
        CustomLoader.showCustomLoader()
        Service.post(url: Router.get_user_address.url(), params: paramGetUserId(), method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_SavedAddress.self, from: response)
                if root.result != nil {
                    success(root)
                } else {
                    vC.alert(alertmessage: root.message ?? "")
                }
                CustomLoader.hideCustomLoader()
            } catch {
                print(error)
                CustomLoader.hideCustomLoader()
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            CustomLoader.hideCustomLoader()
        }
    }
    
    func requestToDeletAddress(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Api_Basic) -> Void) {
        CustomLoader.showCustomLoader()
        Service.post(url: Router.delete_user_address.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_Basic.self, from: response)
                if root.result != nil {
                    success(root)
                } else {
                    print(root.message ?? "")
                }
                CustomLoader.hideCustomLoader()
            } catch {
                print(error)
                CustomLoader.hideCustomLoader()
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            CustomLoader.hideCustomLoader()
        }
    }
    
    func requestToFetchWalletTransaction(_ vC: UIViewController,_ paramDict: [String : AnyObject],_ success: @escaping(_ responseData: Api_TransactionHistory) -> Void) {
        CustomLoader.showCustomLoader()
        Service.post(url: Router.get_transaction.url(), params: paramDict, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_TransactionHistory.self, from: response)
                if root.result != nil {
                    success(root)
                } else {
                    print(root.message ?? "")
                }
                CustomLoader.hideCustomLoader()
            } catch {
                print(error)
                CustomLoader.hideCustomLoader()
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            CustomLoader.hideCustomLoader()
        }
    }
    
    func requestToAddAddress(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Res_AddAddress) -> Void) {
        CustomLoader.showCustomLoader()
        Service.post(url: Router.add_user_address.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_AddAddress.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    print(root.message ?? "")
                }
                CustomLoader.hideCustomLoader()
            } catch {
                print(error)
                CustomLoader.hideCustomLoader()
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            CustomLoader.hideCustomLoader()
        }
    }
    
    func requestToStoreProductDetails(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Res_StoreProductDetail) -> Void) {
        CustomLoader.showCustomLoader()
        Service.post(url: Router.get_product_details.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_StoreProductDetail.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    print(root.message ?? "")
                }
                CustomLoader.hideCustomLoader()
            } catch {
                print(error)
                CustomLoader.hideCustomLoader()
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            CustomLoader.hideCustomLoader()
        }
    }
    
    func requestToServiceDetails(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: [Res_ServiceDetails]) -> Void) {
        CustomLoader.showCustomLoader()
        Service.post(url: Router.get_service_by_id.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_ServiceDetails.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    print(root.message ?? "")
                }
                CustomLoader.hideCustomLoader()
            } catch {
                print(error)
                CustomLoader.hideCustomLoader()
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            CustomLoader.hideCustomLoader()
        }
    }
    
    func requestToCartList(_ vC: UIViewController,_ success: @escaping(_ responseData: [Res_CartList]) -> Void) {
        CustomLoader.showCustomLoader()
        Service.post(url: Router.get_provider_cart.url(), params: paramGetUserId(), method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_CartList.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    vC.alert(alertmessage: root.message ?? "")
                }
                CustomLoader.hideCustomLoader()
            } catch {
                print(error)
                CustomLoader.hideCustomLoader()
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            CustomLoader.hideCustomLoader()
        }
    }
    
    func requestToOrderByStatus(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Api_BookingStatus) -> Void) {
        CustomLoader.showCustomLoader()
        Service.post(url: Router.get_user_order_by_status.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_BookingStatus.self, from: response)
                if root.result != nil {
                    success(root)
                } else {
                    print(root.message ?? "")
                }
                CustomLoader.hideCustomLoader()
            } catch {
                print(error)
                CustomLoader.hideCustomLoader()
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            CustomLoader.hideCustomLoader()
        }
    }
    
    func requestToBookingOrderDetail(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Res_BookingOrderDetail) -> Void) {
        CustomLoader.showCustomLoader()
        Service.post(url: Router.get_order_details.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_BookingOrderDetail.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    print(root.message ?? "")
                }
                CustomLoader.hideCustomLoader()
            } catch {
                print(error)
                CustomLoader.hideCustomLoader()
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            CustomLoader.hideCustomLoader()
        }
    }
    
    func requestToChangeOrderStatus(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Res_CancelOrderStatus) -> Void) {
        CustomLoader.showCustomLoader()
        Service.post(url: Router.get_order_details.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_ChangeOrderStatus.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    print(root.message ?? "")
                }
                CustomLoader.hideCustomLoader()
            } catch {
                print(error)
                CustomLoader.hideCustomLoader()
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            CustomLoader.hideCustomLoader()
        }
    }
    
    func requestToAddInCart(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Api_AddToCart) -> Void) {
        CustomLoader.showCustomLoader()
        Service.post(url: Router.add_to_cart_product.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_AddToCart.self, from: response)
                if root.result != nil {
                    success(root)
                } else {
                    print(root.message ?? "")
                }
                CustomLoader.hideCustomLoader()
            } catch {
                print(error)
                CustomLoader.hideCustomLoader()
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            CustomLoader.hideCustomLoader()
        }
    }
    
    func requestToCartDetail(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Api_CartDetails) -> Void) {
        CustomLoader.showCustomLoader()
        Service.post(url: Router.get_cart.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_CartDetails.self, from: response)
                if root.result != nil {
                    success(root)
                } else {
                    print(root.message ?? "")
                }
                CustomLoader.hideCustomLoader()
            } catch {
                print(error)
                CustomLoader.hideCustomLoader()
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            CustomLoader.hideCustomLoader()
        }
    }
    
    func requestToUpdateCart(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Api_AddToCart) -> Void) {
        Service.post(url: Router.update_cart.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_AddToCart.self, from: response)
                if root.result != nil {
                    success(root)
                } else {
                    print(root.message ?? "")
                }
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
        }
    }
    
    func requestToDeleteCart(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Api_Basic) -> Void) {
        //        vC.showProgressBar()
        Service.post(url: Router.delete_cart_item.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_Basic.self, from: response)
                if root.result != nil {
                    success(root)
                } else {
                    print(root.message ?? "")
                }
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
        }
    }
    
    func requestToOrderedServiceDetails(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Res_OrderedServiceDetails) -> Void) {
        CustomLoader.showCustomLoader()
        Service.post(url: Router.get_product_details.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_OrderedServiceDetail.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    print(root.message ?? "")
                }
                CustomLoader.hideCustomLoader()
            } catch {
                print(error)
                CustomLoader.hideCustomLoader()
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            CustomLoader.hideCustomLoader()
        }
    }
    
    func requestToPlaceServiceOrder(_ vC: UIViewController,_ param: [String : String], imgParam: [String : Array<Any>?],_ success: @escaping(_ responseData: Res_PlaceServiceOrder) -> Void) {
        CustomLoader.showCustomLoader()
        Service.postWithMedia(url: Router.place_order_for_service.url(), params: param, imageParam: imgParam, videoParam: [:], vc: vC, successBlock: {(response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_PlaceServiceOrder.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    print(root.message ?? "")
                }
                CustomLoader.hideCustomLoader()
            } catch {
                print(error)
                CustomLoader.hideCustomLoader()
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            CustomLoader.hideCustomLoader()
        }
    }
    
    func requestToPlaceBid(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Api_PlaceBid) -> Void) {
//        vC.showProgressBar()
        Service.post(url: Router.get_bid_place_list.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_PlaceBid.self, from: response)
                if root.result != nil {
                    success(root)
                } else {
                    print(root.message ?? "")
                }
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
        }
    }
    
    func requestToAcceptOrRejectOffer(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Res_OfferAcceptOrReject) -> Void) {
        CustomLoader.showCustomLoader()
        Service.post(url: Router.offerAcceptOrReject.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_OfferAcceptOrReject.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    print(root.message ?? "")
                }
                CustomLoader.hideCustomLoader()
            } catch {
                print(error)
                CustomLoader.hideCustomLoader()
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            CustomLoader.hideCustomLoader()
        }
    }
    
    func requestToCancelAcceptedOrder(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Res_WorkForThreeModule) -> Void) {
        CustomLoader.showCustomLoader()
        Service.post(url: Router.order_cancel_by_user_after_accept.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_WorkForThreeModule.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    print(root.message ?? "")
                }
                CustomLoader.hideCustomLoader()
            } catch {
                print(error)
                CustomLoader.hideCustomLoader()
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            CustomLoader.hideCustomLoader()
        }
    }
    
    func requestToPlaceOrder(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Res_WorkForThreeModule) -> Void) {
        CustomLoader.showCustomLoader()
        Service.post(url: Router.place_order.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_WorkForThreeModule.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    print(root.message ?? "")
                }
                CustomLoader.hideCustomLoader()
            } catch {
                print(error)
                CustomLoader.hideCustomLoader()
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            CustomLoader.hideCustomLoader()
        }
    }
    
    func requestToUpdateProductOrderStatus(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Api_Basic) -> Void) {
        CustomLoader.showCustomLoader()
        Service.post(url: Router.update_payment_status_user_side.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_Basic.self, from: response)
                if root.result != nil {
                    success(root)
                } else {
                    print(root.message ?? "")
                }
                CustomLoader.hideCustomLoader()
            } catch {
                print(error)
                CustomLoader.hideCustomLoader()
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            CustomLoader.hideCustomLoader()
        }
    }
    
    func requestToUpdatePaymentStatus(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Api_Basic) -> Void) {
        CustomLoader.showCustomLoader()
        Service.post(url: Router.update_payment_status_by_user.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_Basic.self, from: response)
                if root.result != nil {
                    success(root)
                } else {
                    vC.alert(alertmessage: root.message ?? "")
                }
                CustomLoader.hideCustomLoader()
            } catch {
                print(error)
                CustomLoader.hideCustomLoader()
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            CustomLoader.hideCustomLoader()
        }
    }
    
    func requestToUserChatDetails(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: [Res_ChatDetails]) -> Void) {
        CustomLoader.showCustomLoader()
        Service.post(url: Router.get_chat_detail.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_ChatDetails.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    print(root.message ?? "")
                }
                CustomLoader.hideCustomLoader()
            } catch {
                print(error)
                CustomLoader.hideCustomLoader()
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            CustomLoader.hideCustomLoader()
        }
    }
    
    func requestToAdminChatDetails(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: [Res_AdminConversation]) -> Void) {
        CustomLoader.showCustomLoader()
        Service.post(url: Router.get_feedback_chat_detail.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_AdminConversation.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    print(root.message ?? "")
                }
                CustomLoader.hideCustomLoader()
            } catch {
                print(error)
                CustomLoader.hideCustomLoader()
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            CustomLoader.hideCustomLoader()
        }
    }
    
    func requestToAdminChat(_ vC: UIViewController,_ success: @escaping(_ responseData: [Res_AdminChat]) -> Void) {
        CustomLoader.showCustomLoader()
        Service.post(url: Router.get_send_feedback.url(), params: paramGetUserId(), method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_AdminChat.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    print(root.message ?? "")
                }
                CustomLoader.hideCustomLoader()
            } catch {
                print(error)
                CustomLoader.hideCustomLoader()
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            CustomLoader.hideCustomLoader()
        }
    }

//    func requestToWelcomeBanner(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: [Res_OnBoarding]) -> Void) {
//        CustomLoader.showCustomLoader()
//        Service.post(url: Router.get_welcome_page_banner.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
//            do {
//                let jsonDecoder = JSONDecoder()
//                let root = try jsonDecoder.decode(Api_OnBoarding.self, from: response)
//                if root.status == "1" {
//                    if let result = root.result {
//                        success(result)
//                    }
//                } else {
//                    print(root.message ?? "")
//                }
//                CustomLoader.hideCustomLoader()
//            } catch {
//                print(error)
//                CustomLoader.hideCustomLoader()
//            }
//        }) { (error: Error) in
//            vC.alert(alertmessage: error.localizedDescription)
//            CustomLoader.hideCustomLoader()
//        }
//    }
    
    func requestToWelcomeBanner(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: [Res_OnBoarding]) -> Void) {
        CustomLoader.showCustomLoader()
        
        Service.post(
            url: Router.get_welcome_page_banner.url(),
            params: param,
            method: .get,
            vc: vC,
            successBlock: { [weak self] response in
                do {
                    let jsonDecoder = JSONDecoder()
                    let root = try jsonDecoder.decode(Api_OnBoarding.self, from: response)
                    if root.status == "1" {
                        if let result = root.result {
                            success(result)
                        }
                    } else {
                        print(root.message ?? "")
                    }
                    CustomLoader.hideCustomLoader()
                } catch {
                    print(error)
                    CustomLoader.hideCustomLoader()
                }
            },
            failureBlock: { [weak vC] error in
                vC?.alert(alertmessage: error.localizedDescription)
                CustomLoader.hideCustomLoader()
            }
        )
    }
   
    func requestToLastConversation(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Api_LastChat) -> Void) {
        CustomLoader.showCustomLoader()
        Service.post(url: Router.get_conversation_detail.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_LastChat.self, from: response)
                if root.result != nil {
                    success(root)
                } else {
                    print(root.message ?? "")
                }
                CustomLoader.hideCustomLoader()
            } catch {
                print(error)
                CustomLoader.hideCustomLoader()
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            CustomLoader.hideCustomLoader()
        }
    }
    
    func requestToSendChat(_ vc: UIViewController, _ params: [String: String], images: [String : UIImage?]?,videos: [String : Data?]?, _ success: @escaping(_ responseData : ResSendChat) -> Void) {
        CustomLoader.showCustomLoader()
        Service.postSingleMedia(url: Router.insert_chat.url(), params: params, imageParam: images, videoParam: videos, parentViewController: vc, successBlock:  { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiSendChat.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    vc.alert(alertmessage: root.message ?? "Something went wrong")
                }
                CustomLoader.hideCustomLoader()
            } catch {
                print(error)
                CustomLoader.hideCustomLoader()
            }
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            CustomLoader.hideCustomLoader()
        }
    }
    
    func requestToSendAdminChat(_ vc: UIViewController, _ params: [String: String], images: [String : UIImage?]?,videos: [String : Data?]?, _ success: @escaping(_ responseData : ResSendChat) -> Void) {
        CustomLoader.showCustomLoader()
        Service.postSingleMedia(url: Router.insert_chat_feedback.url(), params: params, imageParam: images, videoParam: videos, parentViewController: vc, successBlock:  { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiSendChat.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    vc.alert(alertmessage: root.message ?? "Something went wrong")
                }
                CustomLoader.hideCustomLoader()
            } catch {
                print(error)
                CustomLoader.hideCustomLoader()
            }
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            CustomLoader.hideCustomLoader()
        }
    }
    
    func requestToWithDrawAmount(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : Res_BankWithdrawRequest) -> Void) {
        Service.post(url: Router.add_withdraw_request.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_BankWithdrawRequest.self, from: response)
                if let result = root.result {
                    success(result)
                }
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
        }
    }
    
    func requestToFetchUserReview(_ vC: UIViewController,_ success: @escaping(_ responseData: [Res_ReviewList]) -> Void) {
        CustomLoader.showCustomLoader()
        Service.post(url: Router.get_user_review_rating.url(), params: paramGetUserId(), method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_ReviewList.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    print(root.message ?? "")
                }
                CustomLoader.hideCustomLoader()
            } catch {
                print(error)
                CustomLoader.hideCustomLoader()
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            CustomLoader.hideCustomLoader()
        }
    }
    
    func requestToAddRatingReview(_ vc: UIViewController, _ params: [String: String], images: [String : UIImage?]?, videos: [String : Data?]?, _ success: @escaping(_ responseData : Api_Basic) -> Void) {
        CustomLoader.showCustomLoader()
        Service.postSingleMedia(url: Router.add_rating_review_by_order.url(), params: params, imageParam: images, videoParam: videos, parentViewController: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_Basic.self, from: response)
                if root.status != "0" {
                    success(root)
                } else {
                    Utility.showAlertWithAction(withTitle: k.appName, message: root.message ?? "", delegate: nil, parentViewController: vc) { bool in
                        Switcher.updateRootVC()
                    }
                }
            } catch {
                print(error)
                CustomLoader.hideCustomLoader()
            }
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            CustomLoader.hideCustomLoader()
        }
    }
    
    func requestToDeleteUserAccount(_ vC: UIViewController,_ success: @escaping(_ responseData: Api_Basic) -> Void) {
        CustomLoader.showCustomLoader()
        Service.post(url: Router.delete_user_account.url(), params: paramGetUserId(), method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_Basic.self, from: response)
                if root.result != nil {
                    success(root)
                } else {
                    vC.alert(alertmessage: root.message ?? "")
                }
                CustomLoader.hideCustomLoader()
            } catch {
                print(error)
                CustomLoader.hideCustomLoader()
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            CustomLoader.hideCustomLoader()
        }
    }
    
    func requestToAddWalletAmount(_ vC: UIViewController,_ paramDict: [String : AnyObject],_ success: @escaping(_ responseData: Res_AddWalletAmount) -> Void) {
        CustomLoader.showCustomLoader()
        Service.post(url: Router.add_wallet_amount.url(), params: paramDict, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_AddWalletAmount.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    print(root.message ?? "")
                }
                CustomLoader.hideCustomLoader()
            } catch {
                print(error)
                CustomLoader.hideCustomLoader()
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            CustomLoader.hideCustomLoader()
        }
    }
        
    func requestToCheckWithrawAmountReq(_ vC: UIViewController,_ success: @escaping(_ responseData: Api_WithdrawAmountRequest) -> Void) {
        CustomLoader.showCustomLoader()
        Service.post(url: Router.get_withdraw_request.url(), params: paramGetUserId(), method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_WithdrawAmountRequest.self, from: response)
                if root.result != nil {
                    success(root)
                } else {
                    print(root.message ?? "")
                }
                CustomLoader.hideCustomLoader()
            } catch {
                print(error)
                CustomLoader.hideCustomLoader()
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            CustomLoader.hideCustomLoader()
        }
    }
    
    func requestToCalculateServicePriceZone(_ vC: UIViewController,param: [String : AnyObject],_ success: @escaping(_ responseData: Api_ServicePriceWithZonePrice) -> Void) {
        Service.post(url: Router.get_service_price_with_zone_price.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_ServicePriceWithZonePrice.self, from: response)
                if root.status != "0" {
                    success(root)
                } else {
                    print(root.message ?? "")
                }
                CustomLoader.hideCustomLoader()
            } catch {
                print(error)
                CustomLoader.hideCustomLoader()
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            CustomLoader.hideCustomLoader()
        }
    }
    
    func requestToNotification(_ vC: UIViewController,_ success: @escaping(_ responseData: Api_Notification) -> Void) {
        CustomLoader.showCustomLoader()
        Service.post(url: Router.get_notification_list.url(), params: paramGetUserId(), method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_Notification.self, from: response)
                if root.result != nil {
                    success(root)
                } else {
                    print(root.message ?? "")
                }
                CustomLoader.hideCustomLoader()
            } catch {
                print(error)
                CustomLoader.hideCustomLoader()
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            CustomLoader.hideCustomLoader()
        }
    }

    func add_Payment(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : AnyObject) -> Void) {
        CustomLoader.showCustomLoader()
        Service.callPostService(apiUrl: Router.addPayment.url(), parameters: params, Method: .get, parentViewController: vc, successBlock: { (response, message) in
            success(response)
            CustomLoader.hideCustomLoader()
        }) { (error) in
            vc.alert(alertmessage: error.localizedDescription)
            CustomLoader.hideCustomLoader()
        }
    }
    
    func requestToAddPaymentCard(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Res_AddCardForPayment) -> Void) {
        CustomLoader.showCustomLoader()
        Service.post(url: Router.add_user_card.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_AddCardForPayment.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    print(root.message ?? "")
                }
                CustomLoader.hideCustomLoader()
            } catch {
                print(error)
                CustomLoader.hideCustomLoader()
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            CustomLoader.hideCustomLoader()
        }
    }
    
    func requestForSavedCards(_ vC: UIViewController,_ success: @escaping(_ responseData: [Res_SavedCards]) -> Void) {
        CustomLoader.showCustomLoader()
        Service.post(url: Router.get_user_card.url(), params: paramGetUserId(), method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_SavedCards.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    print(root.message ?? "")
                }
                CustomLoader.hideCustomLoader()
            } catch {
                print(error)
                CustomLoader.hideCustomLoader()
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            CustomLoader.hideCustomLoader()
        }
    }
    
    func requestToDeleteSavedCard(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Api_Basic) -> Void) {
        CustomLoader.showCustomLoader()
        Service.post(url: Router.delete_user_card.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_Basic.self, from: response)
                if root.result != nil {
                    success(root)
                } else {
                    vC.alert(alertmessage: root.message ?? "")
                }
                CustomLoader.hideCustomLoader()
            } catch {
                print(error)
                CustomLoader.hideCustomLoader()
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            CustomLoader.hideCustomLoader()
        }
    }
    
    func requestToTermsCondition(_ vC: UIViewController,_ success: @escaping(_ responseData: Res_TermCondition) -> Void) {
        CustomLoader.showCustomLoader()
        Service.post(url: Router.get_user_page.url(), params: paramGetUserId(), method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_TermsCondition.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    print(root.message ?? "")
                }
                CustomLoader.hideCustomLoader()
            } catch {
                print(error)
                CustomLoader.hideCustomLoader()
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            CustomLoader.hideCustomLoader()
        }
    }
    
    func requestToUpdateLanguage(_ vC: UIViewController,_ paramDict: [String : AnyObject],_ success: @escaping(_ responseData: Res_UpdateLanguage) -> Void) {
//        CustomLoader.showCustomLoader()
        Service.post(url: Router.update_app_language.url(), params: paramDict, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_UpdateLanguge.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    print(root.message ?? "")
                }
//                CustomLoader.hideCustomLoader()
            } catch {
                print(error)
//                CustomLoader.hideCustomLoader()
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
//            CustomLoader.hideCustomLoader()
        }
    }
}
