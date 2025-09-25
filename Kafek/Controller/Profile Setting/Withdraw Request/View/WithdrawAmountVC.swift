//
//  WithdrawAmountVC.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 05/04/25.
//

import UIKit

class WithdrawAmountVC: UIViewController {

    @IBOutlet weak var lbl_BalanceAmount: UILabel!
    @IBOutlet weak var txt_Amount: UITextField!
    @IBOutlet weak var transactionTableVw: UITableView!
    @IBOutlet weak var lbl_Headline: UILabel!
    
    let viewModel = WithdrawRequestViewModel()
    var strAmountBalance:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lbl_BalanceAmount.text = "\(R.string.localizable.yourBalance())\nSR\(strAmountBalance)"
//        txt_Amount.enforceEnglishNumbers()
        transactionTableVw.register(UINib(nibName: "WithdrawCell", bundle: nil), forCellReuseIdentifier: "WithdrawCell")
        fetchWithdrawRequest()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        self.lbl_Headline.text = R.string.localizable.withdraw()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func btn_Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func fetchWithdrawRequest() {
        viewModel.requestWithdrawAmount(vC: self, tableView: transactionTableVw)
        viewModel.cloSuccess = { [weak self] in
            guard let self = self else { return }
            
            self.transactionTableVw.reloadData()
        }
    }
    
    @IBAction func btn_SendReq(_ sender: UIButton) {
        guard let enteredText = txt_Amount.text?.trimmingCharacters(in: .whitespacesAndNewlines), !enteredText.isEmpty else {
            self.alert(alertmessage: R.string.localizable.pleaseEnterAmount())
            return
        }
        
        guard let textAmount = Double(enteredText.replacingOccurrences(of: ",", with: "")),
              let walletBalance = Double(strAmountBalance.replacingOccurrences(of: ",", with: "")) else {
            self.alert(alertmessage: R.string.localizable.invalidAmount())
            return
        }
        
        if textAmount > walletBalance {
            self.alert(alertmessage: R.string.localizable.pleaseEnterLowerOrEqualAmountThanYourWalletBalance())
        } else {
            let vC = R.storyboard.main().instantiateViewController(withIdentifier: "BankTransferVC") as! BankTransferVC
            vC.strWalletAmount = strAmountBalance
            vC.strWithdrawAmount = enteredText
            self.navigationController?.pushViewController(vC, animated: true)
        }
    }
}

extension WithdrawAmountVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.arrayWithdrawRequest.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WithdrawCell", for: indexPath) as! WithdrawCell
        let obj = self.viewModel.arrayWithdrawRequest[indexPath.row]
        
        cell.lbl_AvailableAmount.text = "+SR\(obj.amount ?? "") \(R.string.localizable.requested())"
        cell.lbl_DateTime.text = "\(R.string.localizable.paymentWithdrawalMethod()): \(obj.method ?? "")\n\(obj.date_time ?? "")"
        cell.btn_Status.isHidden = false
        cell.btn_Status.setTitle(obj.status ?? "", for: .normal)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
