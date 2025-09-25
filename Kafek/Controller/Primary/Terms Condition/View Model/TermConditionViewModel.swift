//
//  TermConditionViewModel.swift
//  Kafak Driver
//
//  Created by Techimmense Software Solutions on 21/04/25.
//

import Foundation

class TermConditionViewModel {
    
    var strType:String = ""
    var strDescription:String = ""
    
    var cloSuccess: (() -> Void)?
    
    func fetchUserPages(vC: UIViewController)
    {
        Api.shared.requestToTermsCondition(vC) { [weak self] responseData in
            guard let self = self else { return }
            
            let obj = responseData
            if self.strType == "TermsCondition" {
                if L102Language.currentAppleLanguage() == "ar" {
                    self.strDescription = obj.term_sp ?? ""
                } else {
                    self.strDescription = obj.term ?? ""
                }
            } else if self.strType == "AboutUs" {
                if L102Language.currentAppleLanguage() == "ar" {
                    self.strDescription = obj.about_us_sp ?? ""
                } else {
                    self.strDescription = obj.about_us ?? ""
                }
            } else {
                if L102Language.currentAppleLanguage() == "ar" {
                    self.strDescription = obj.privacy_sp ?? ""
                } else {
                    self.strDescription = obj.privacy ?? ""
                }
            }
            self.cloSuccess?()
        }
    }
}
