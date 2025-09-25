//
//  ServiceDetailViewModel.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 03/02/25.
//

import Foundation

class ServiceDetailViewModel {
    
    var cloFethcedSuccessfull:(() -> Void)?
    var arrayOfServiceDetails: [Res_ServiceDetails] = []
    
    var catiD:String = ""
    var serviceiMG:String = ""
    var serviceName:String = ""
    
    func fetchEquipmentDetails(vC: UIViewController) {
        var paramDict: [String : AnyObject] = [:]
        paramDict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject
        paramDict["cat_id"] = catiD as AnyObject
        
        print(paramDict)
        
        Api.shared.requestToServiceDetails(vC, paramDict) { [weak self] responseData in
            guard let self = self else { return }
            if responseData.count > 0 {
                self.arrayOfServiceDetails = responseData
            } else {
                self.arrayOfServiceDetails = []
            }
            self.cloFethcedSuccessfull?()
        }
    }
    
    func getImage(imageName:UIImageView) {
        if Router.BASE_IMAGE_URL != serviceiMG {
            Utility.setImageWithSDWebImage(serviceiMG, imageName)
        } else {
            imageName.image = R.image.no_Image_Available()
        }
    }
}
