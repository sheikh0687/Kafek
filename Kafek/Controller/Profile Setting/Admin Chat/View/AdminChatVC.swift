//
//  AdminChatVC.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 07/04/25.
//

import UIKit

class AdminChatVC: UIViewController {

    @IBOutlet weak var lastChatTableVw: UITableView!
    @IBOutlet weak var lbl_Headline: UILabel!
    
    let viewModel = AdminChatViewMode()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lastChatTableVw.register(UINib(nibName: "AdminContactCell", bundle: nil), forCellReuseIdentifier: "AdminContactCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        self.lbl_Headline.text = R.string.localizable.query()
        fetchAdminChat()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

    @IBAction func btn_BackClick(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_HelpClick(_ sender: UIButton) {
        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "HelpVC") as! HelpVC
        self.navigationController?.pushViewController(vC, animated: true)
    }
    
    func fetchAdminChat()
    {
        viewModel.requestToGetAdminChatRequest(vC: self)
        viewModel.cloSuccessfullChat = { [weak self] in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.lastChatTableVw.reloadData()
            }
        }
    }
}

extension AdminChatVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.arrayChatRequest.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AdminContactCell", for: indexPath) as! AdminContactCell
        let obj = self.viewModel.arrayChatRequest[indexPath.row]

        cell.lbl_Query.text = obj.feedback ?? ""
        cell.lbl_DateTime.text = obj.date_time ?? ""
        
        cell.cloChat = { [weak self] in
            guard let self = self else { return }
            
            let vC = R.storyboard.main().instantiateViewController(withIdentifier: "AdminConvsersationVC") as! AdminConvsersationVC
            vC.viewModel.strRequestId = obj.id ?? ""
            self.navigationController?.pushViewController(vC, animated: true)
        }
        
        if obj.no_of_message != 0 {
            cell.notificationVw.isHidden = false
            cell.lbl_Count.text = String(obj.no_of_message ?? 0)
        } else {
            cell.notificationVw.isHidden = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableVw: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = self.viewModel.arrayChatRequest[indexPath.row]
        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "AdminConvsersationVC") as! AdminConvsersationVC
        vC.viewModel.strRequestId = obj.id ?? ""
        self.navigationController?.pushViewController(vC, animated: true)
    }
}
