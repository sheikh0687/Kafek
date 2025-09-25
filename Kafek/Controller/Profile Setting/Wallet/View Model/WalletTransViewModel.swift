//
//  WalletTransViewModel.swift
//  Kafak Driver
//
//  Created by Techimmense Software Solutions on 11/03/25.
//

import Foundation

class WalletTransViewModel {
    
    var strWalletAmount:String = ""
    var strTotalEaring:String = ""
    var arrayWalletTransaction: [Res_TransactionHistory] = []
    var cloSuccess: (() -> Void)?
    
    func requestForWalletTransaction(vC: UIViewController, tableView: UITableView) {
        
        var paramDict: [String : AnyObject] = [:]
        paramDict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        paramDict["type"] = "USER" as AnyObject
        
        print(paramDict)
        
        Api.shared.requestToFetchWalletTransaction(vC, paramDict) { [weak self] responseData in
            guard let self = self else { return }
            
            self.strWalletAmount = responseData.wallet ?? ""
            self.strTotalEaring = responseData.total_earning ?? ""
            if responseData.status == "1" {
                if let res = responseData.result {
                    if res.count > 0 {
                        self.arrayWalletTransaction = res
                        tableView.backgroundView = UIView()
                        tableView.reloadData()
                    }
                }
            } else {
                self.arrayWalletTransaction = []
                tableView.backgroundView = UIView()
                tableView.reloadData()
                Utility.noDataFound(R.string.localizable.noTransactionYet(), R.string.localizable.afterYourFirstTransactionYouWillBeAbleToSeeItHere(), tableViewOt: tableView, parentViewController: vC, appendImg: #imageLiteral(resourceName: "empty_transaction.png"))
            }
            self.cloSuccess?()
        }
    }
}
