//
//  StoreDetailViewModel.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 18/09/24.
//

import Foundation

class StoreDetailViewModel {
    
    var arrayStoreCategoryDetail: [Category_list] = []
    var storeDtSuccessResponse:(() -> Void)?
    
    var storeImg: String!
    var storeName:String = ""
    var storeAddress:String = ""
    
    var providerId = ""
    
    func requestAllStoreDetails(vC: UIViewController)
    {
        var paramDict: [String : AnyObject] = [:]
        paramDict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        paramDict["provider_id"] = providerId as AnyObject
        
        print(paramDict)
        
        Api.shared.requestToStoreDetails(vC, paramDict) { responseData in
            let obj = responseData
            self.storeName = obj.provider_name ?? ""
            self.storeAddress = obj.provider_streat_address ?? ""
            self.storeImg = obj.provider_logo ?? ""
            
            if let storeCategory = obj.category_list {
                if storeCategory.count > 0 {
                    self.arrayStoreCategoryDetail = storeCategory
                } else {
                    self.arrayStoreCategoryDetail = []
                }
            }
            
            self.storeDtSuccessResponse?()
        }
    }
}
