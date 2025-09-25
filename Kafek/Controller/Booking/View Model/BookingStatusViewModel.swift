//
//  BookingStatusViewModel.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 06/02/25.
//

import Foundation

class BookingStatusViewModel {
    
    var arrayBookingStatus: [Res_BookingStatus] = []
    var cloSuccessfulBookingStatus: (() -> Void)?
    
    func fetchBookingStatus(vC: UIViewController,strType:String, tableView: UITableView) {
        
        var paramDict: [String : AnyObject] = [:]
        paramDict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        paramDict["type"] = strType as AnyObject
        
        print(paramDict)
        
        Api.shared.requestToOrderByStatus(vC, paramDict) { [weak self] responseData in
            guard let self = self else { return }
            if responseData.status == "1" {
                if let res = responseData.result {
                    if res.count > 0 {
                        self.arrayBookingStatus = res
                        tableView.backgroundView = UIView()
                        tableView.reloadData()
                    }
                }
            } else {
                self.arrayBookingStatus = []
                tableView.backgroundView = UIView()
                tableView.reloadData()
                Utility.noDataFound(R.string.localizable.youHaveNoOrders(), k.emptyString, tableViewOt: tableView, parentViewController: vC, appendImg: #imageLiteral(resourceName: "empty_cart.png"))
            }
            self.cloSuccessfulBookingStatus?()
        }
    }
    
    func navigateToOrderDetails(vC: UIViewController, strOrderiD:String) {
        let vc = vC.storyboard?.instantiateViewController(withIdentifier: "ProductOrderWaitingVC") as! ProductOrderWaitingVC
        vc.viewModel.orderiD = strOrderiD
        vC.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToServiceDetails(vC: UIViewController, strOrderiD:String, strStatus:String, productiD: String) {
        let vc = vC.storyboard?.instantiateViewController(withIdentifier: "ServiceOrderWaitingVC") as! ServiceOrderWaitingVC
        vc.viewModel.orderiD = strOrderiD
        vc.productiD = productiD
//        if strStatus == "Pending" {
//            vc.isCancelled = true
//        } else {
//            vc.isCancelled = false
//        }
        vC.navigationController?.pushViewController(vc, animated: true)
    }
}
 
