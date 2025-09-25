//
//  LastChatVC.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 11/03/25.
//

import UIKit

class LastChatVC: UIViewController {

    @IBOutlet weak var lastChatTableVw: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var lbl_Headline: UILabel!
    
    let viewModel = LastChatViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setupSearchBar(searchBar: searchBar)
        self.lastChatTableVw.register(UINib(nibName: "LastChatCell", bundle: nil), forCellReuseIdentifier: "LastChatCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        self.lbl_Headline.text = R.string.localizable.chat()
        fetchLastChats()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    deinit {
        print("Last Chat screen deinit")
    }

    @IBAction func btnBackTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func fetchLastChats() {
        viewModel.requestToFetchLastChat(vC: self, tableVw: lastChatTableVw)
        viewModel.cloChatReceived = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.lastChatTableVw.reloadData()
            }
        }
    }
}

extension LastChatVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.arrayLastChat.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LastChatCell", for: indexPath) as! LastChatCell
        let obj = self.viewModel.arrayLastChat[indexPath.row]
        
        cell.lbl_UserName.text = "\(obj.first_name ?? "") \(obj.last_name ?? "")"
        cell.lbl_RequestNumber.text = "\(R.string.localizable.requestIDD()): #\(obj.request_id ?? "") \n\(obj.chat_message ?? "")"
        cell.lbl_LastMessage.text = obj.last_message ?? ""
        cell.lbl_DateTime.text = obj.date ?? ""
        
        if obj.no_of_message != 0 {
            cell.numberMsgVw.isHidden = false
            cell.lbl_Number.text = "\(obj.no_of_message ?? 0)"
        } else {
            cell.numberMsgVw.isHidden = true
        }
        
        if Router.BASE_IMAGE_URL != obj.image ?? "" {
            Utility.setImageWithSDWebImage(obj.image ?? "", cell.profileImg)
        } else {
            cell.profileImg.image = R.image.profile_ic()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = self.viewModel.arrayLastChat[indexPath.row]
        if obj.request_status == "Delivered" || obj.request_status == "Complete" || obj.request_status == "Cancel" || obj.remove_status == "Reject" {
            self.alert(alertmessage: "\(R.string.localizable.yourRequestStatusIs()) \(obj.request_status ?? ""). \(R.string.localizable.thusYouCanNotChat())")
        } else {
            let vC = R.storyboard.main().instantiateViewController(withIdentifier: "UserChatVC") as! UserChatVC
            vC.strUserName = "\(obj.first_name ?? "") \(obj.last_name ?? "")"
            vC.viewModel.request_Id = obj.request_id ?? ""
            vC.viewModel.receiver_Id = obj.sender_id ?? ""
            self.navigationController?.pushViewController(vC, animated: true)
        }
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }
}
