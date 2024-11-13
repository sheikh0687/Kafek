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
        vC.showProgressBar()
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
                vC.hideProgressBar()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            vC.hideProgressBar()
        }
    }
    
    func requestToSignup(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Res_Login) -> Void) {
        vC.showProgressBar()
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
                vC.hideProgressBar()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            vC.hideProgressBar()
        }
    }

    func requestToResetPassword(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Api_ForgotPassword) -> Void) {
        vC.showProgressBar()
        Service.post(url: Router.forgot_password.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_ForgotPassword.self, from: response)
                if root.result != nil {
                  success(root)
                } else {
                    vC.alert(alertmessage: root.message ?? "")
                }
                vC.hideProgressBar()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            vC.hideProgressBar()
        }
    }
    
    func requestToBanner(_ vC: UIViewController,_ success: @escaping(_ responseData: [Res_BannerList]) -> Void) {
        vC.showProgressBar()
        Service.post(url: Router.get_banner.url(), params: paramGetUserId(), method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_BannerList.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
//                    vC.alert(alertmessage: root.message ?? "")
                }
                vC.hideProgressBar()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            vC.hideProgressBar()
        }
    }

    func requestToAllService(_ vC: UIViewController,_ success: @escaping(_ responseData: [Res_Services]) -> Void) {
        vC.showProgressBar()
        Service.post(url: Router.get_services.url(), params: paramGetUserId(), method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_Service.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vC.hideProgressBar()
                    }
                } else {
//                    vC.alert(alertmessage: root.message ?? "")
                }
                vC.hideProgressBar()
            } catch {
                print(error)
                vC.hideProgressBar()
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            vC.hideProgressBar()
        }
    }
    
    func requestToAllStore(_ vC: UIViewController,_ success: @escaping(_ responseData: [Res_Stores]) -> Void) {
        vC.showProgressBar()
        Service.post(url: Router.get_all_store_list.url(), params: paramGetUserId(), method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_AllStores.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vC.hideProgressBar()
                    }
                } else {
//                    vC.alert(alertmessage: root.message ?? "")
                }
                vC.hideProgressBar()
            } catch {
                print(error)
                vC.hideProgressBar()
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            vC.hideProgressBar()
        }
    }
    
    func requestToStoreDetails(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Res_StoreDetail) -> Void) {
        vC.showProgressBar()
        Service.post(url: Router.get_provider_details.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_StoreDetails.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vC.hideProgressBar()
                    }
                } else {
//                    vC.alert(alertmessage: root.message ?? "")
                }
                vC.hideProgressBar()
            } catch {
                print(error)
                vC.hideProgressBar()
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            vC.hideProgressBar()
        }
    }
    
    func requestToSavedAddress(_ vC: UIViewController,_ success: @escaping(_ responseData: [Res_SavedAddress]) -> Void) {
        vC.showProgressBar()
        Service.post(url: Router.get_user_address.url(), params: paramGetUserId(), method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_SavedAddress.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vC.hideProgressBar()
                    }
                } else {
                    vC.alert(alertmessage: root.message ?? "")
                }
                vC.hideProgressBar()
            } catch {
                print(error)
                vC.hideProgressBar()
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            vC.hideProgressBar()
        }
    }
    
    func requestToDeletAddress(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Api_Basic) -> Void) {
        vC.showProgressBar()
        Service.post(url: Router.delete_user_address.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_Basic.self, from: response)
                if root.result != nil {
                    success(root)
                } else {
//                    vC.alert(alertmessage: root.message ?? "")
                }
                vC.hideProgressBar()
            } catch {
                print(error)
                vC.hideProgressBar()
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            vC.hideProgressBar()
        }
    }
    
    func requestToAddAddress(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Res_AddAddress) -> Void) {
        vC.showProgressBar()
        Service.post(url: Router.add_user_address.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_AddAddress.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
//                    vC.alert(alertmessage: root.message ?? "")
                }
                vC.hideProgressBar()
            } catch {
                print(error)
                vC.hideProgressBar()
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            vC.hideProgressBar()
        }
    }
    
    func requestToStoreProductDetails(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Res_StoreProductDetail) -> Void) {
        vC.showProgressBar()
        Service.post(url: Router.get_product_details.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_StoreProductDetail.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vC.hideProgressBar()
                    }
                } else {
//                    vC.alert(alertmessage: root.message ?? "")
                }
                vC.hideProgressBar()
            } catch {
                print(error)
                vC.hideProgressBar()
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            vC.hideProgressBar()
        }
    }
}
