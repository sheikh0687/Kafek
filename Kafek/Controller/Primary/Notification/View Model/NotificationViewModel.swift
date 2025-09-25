//
//  NotificationViewModel.swift
//  Kafak Driver
//
//  Created by Techimmense Software Solutions on 03/03/25.
//

import Foundation

class NotificationViewModel {
    
    var arrayNotificationList: [Res_Notification] = []
    var cloNotification:() -> Void = {}
    
    func requestToNotification(vC: UIViewController, tableView: UITableView)
    {
        Api.shared.requestToNotification(vC) { [weak self] responseData in
            guard let self = self else { return }
            if responseData.status == "1" {
                if let res = responseData.result {
                    if res.count > 0 {
                        self.arrayNotificationList = res
                        tableView.backgroundView = UIView()
                        tableView.reloadData()
                    }
                }
            } else {
                self.arrayNotificationList = []
                tableView.backgroundView = UIView()
                tableView.reloadData()
                Utility.noDataFound(R.string.localizable.youHave0Notification(), k.emptyString, tableViewOt: tableView, parentViewController: vC, appendImg: #imageLiteral(resourceName: "empty_notification"))

            }
            self.cloNotification()
        }
    }
}
