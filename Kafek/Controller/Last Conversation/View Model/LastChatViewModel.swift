//
//  LastChatViewModel.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 11/03/25.
//

import Foundation

class LastChatViewModel {
    
    var arrayLastChat: [Res_LastChat] = []
    var cloChatReceived: (() -> Void)?
    
    func requestToFetchLastChat(vC: UIViewController, tableVw: UITableView) {
        var paramDict: [String: AnyObject] = [:]
        
        paramDict["receiver_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        
        print(paramDict)
        
        Api.shared.requestToLastConversation(vC, paramDict) { [weak self] responseData in
            guard let self else { return }
            
            if responseData.status == "1" {
                if let res = responseData.result {
                    if res.count > 0 {
                        self.arrayLastChat = res
                        tableVw.backgroundView = UIView()
                        tableVw.reloadData()
                    }
                }
            } else {
                self.arrayLastChat = []
                tableVw.backgroundView = UIView()
                tableVw.reloadData()
                Utility.noDataFound(L102Language.currentAppleLanguage() == "en" ? "No new chat at this moment" : "لا توجد محادثة جديدة في الوقت الحالي", k.emptyString, tableViewOt: tableVw, parentViewController: vC, appendImg: nil)

            }
            self.cloChatReceived?()
        }
    }
    
    func setupSearchBar(searchBar: UISearchBar!) {
        searchBar.placeholder = R.string.localizable.search()
       searchBar.barTintColor = UIColor.white
       searchBar.searchTextField.backgroundColor = UIColor.white
       searchBar.searchTextField.textColor = UIColor.black
       
       if let clearButton = searchBar.searchTextField.value(forKey: "_clearButton") as? UIButton {
           clearButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
       }
       
       searchBar.layer.cornerRadius = 10
       searchBar.layer.masksToBounds = true
   }
}
