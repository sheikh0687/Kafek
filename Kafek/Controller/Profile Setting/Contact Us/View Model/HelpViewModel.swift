//
//  HelpViewModel.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 12/03/25.
//

import Foundation

class HelpViewModel {
    
    var strMessage: String = ""
    var cloSuccessfull: (() -> Void)?
    
    func contactInfo(vC: UIViewController)
    {
        var paramDict:[String : AnyObject] = [:]
        paramDict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        paramDict["name"] = k.userDefault.value(forKey: k.session.userName) as AnyObject
        paramDict["contact_number"] = k.userDefault.value(forKey: k.session.userMobile) as AnyObject
        paramDict["email"] = k.userDefault.value(forKey: k.session.userEmail) as AnyObject
        paramDict["feedback"] = strMessage as AnyObject
        
        print(paramDict)
        
        Api.shared.requestToSendFeedback(vC, paramDict) { [weak self] responseData in
            guard let self = self else { return }
            
            self.cloSuccessfull?()
        }
    }
}

