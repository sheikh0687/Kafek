//
//  NotificationVC.swift
//  Kafak Driver
//
//  Created by Techimmense Software Solutions on 12/08/24.
//

import UIKit

class NotificationVC: UIViewController {

    @IBOutlet weak var notification_TableVw: UITableView!
    @IBOutlet weak var lbl_Headline: UILabel!
    
    let viewModel = NotificationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        notification_TableVw.register(UINib(nibName: "NotificationCell", bundle: nil), forCellReuseIdentifier: "NotificationCell")
        self.lbl_Headline.text = R.string.localizable.notifications()
        bindData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    deinit {
        print("Notification Screen Deinit")
    }

    @IBAction func btn_Back_Tapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func bindData()
    {
        viewModel.requestToNotification(vC: self, tableView: notification_TableVw)
        viewModel.cloNotification = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.notification_TableVw.reloadData()
            }
        }
    }
}

extension NotificationVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.arrayNotificationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationCell
        
        let obj = self.viewModel.arrayNotificationList[indexPath.row]
        cell.lbl_NotificationTitle.text = "\(L102Language.currentAppleLanguage() == "en" ? obj.title ?? "" : obj.title_ar ?? "")\n\(L102Language.currentAppleLanguage() == "en" ? obj.message ?? "" : obj.message_ar ?? "")"
        cell.lbl_DateTime.text = obj.date_time ?? ""
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = self.viewModel.arrayNotificationList[indexPath.row]
        if obj.notification_type == "Request" {
            let vC = R.storyboard.main().instantiateViewController(withIdentifier: "ServiceOrderWaitingVC") as! ServiceOrderWaitingVC
            vC.viewModel.orderiD =  obj.request_id ?? ""
            self.navigationController?.pushViewController(vC, animated: true)
        }
    }
}
