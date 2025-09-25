//
//  WalletVC.swift
//  Kafak Driver
//
//  Created by Techimmense Software Solutions on 14/08/24.
//

import UIKit

class WalletVC: UIViewController {

    @IBOutlet weak var transaction_TableVw: UITableView!
    @IBOutlet weak var lbl_WalletAmount: UILabel!
    @IBOutlet weak var lbl_TotalEarning: UILabel!
    @IBOutlet weak var btn_WithdrawOt: UIButton!
    @IBOutlet weak var lbl_YourBalance: UILabel!
    @IBOutlet weak var walletView: UIView!
    @IBOutlet weak var walletIconVw: UIView!
    
    let viewModel = WalletTransViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lbl_WalletAmount.tag = 999
        self.lbl_WalletAmount.textAlignment = .left
        self.lbl_YourBalance.tag = 999
        self.lbl_YourBalance.textAlignment = .left
        
        if L102Language.currentAppleLanguage() == "ar" {
            walletView.semanticContentAttribute = .forceLeftToRight
            walletIconVw.semanticContentAttribute = .forceLeftToRight
        }
        
        self.transaction_TableVw.register(UINib(nibName: "WithdrawCell", bundle: nil), forCellReuseIdentifier: "WithdrawCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bindViewModel()
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func bindViewModel() {
        viewModel.requestForWalletTransaction(vC: self, tableView: transaction_TableVw)
        viewModel.cloSuccess = {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                self.lbl_WalletAmount.text = "SR \(self.viewModel.strWalletAmount)"
                self.lbl_TotalEarning.text = "SR \(self.viewModel.strTotalEaring)"
                self.transaction_TableVw.reloadData()
            }
        }
    }
    
    @IBAction func btn_Withdraw(_ sender: UIButton) {
        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "WithdrawAmountVC") as! WithdrawAmountVC
        vC.strAmountBalance = viewModel.strWalletAmount
        self.navigationController?.pushViewController(vC, animated: true)
    }
    
    @IBAction func btn_Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btn_AddWalletAmount(_ sender: UIButton) {
        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "PresentForWalletAmountVC") as! PresentForWalletAmountVC
        vC.cloAdd = { [weak self] amount in
            guard let self = self else { return }
            
            let vC = R.storyboard.main().instantiateViewController(withIdentifier: "MakeTabPaymentVC") as! MakeTabPaymentVC
            vC.viewModel.paymentFor = "Wallet"
            vC.viewModel.strAmount = amount
            vC.viewModel.tabPayAmt = amount
            k.userDefault.set(amount, forKey: k.session.userWallet)
            self.navigationController?.pushViewController(vC, animated: true)
        }
        vC.modalTransitionStyle = .coverVertical
        vC.modalPresentationStyle = .overFullScreen
        self.present(vC, animated: true)
    }
}

extension WalletVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.arrayWalletTransaction.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WithdrawCell", for: indexPath) as! WithdrawCell
        let obj = self.viewModel.arrayWalletTransaction[indexPath.row]
        cell.lbl_AvailableAmount.text = "+SR\(obj.total_amount ?? "") \(R.string.localizable.debitedForServiceDelivery())"
        cell.lbl_DateTime.text = obj.date_time ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = self.viewModel.arrayWalletTransaction[indexPath.row]
        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "ServiceOrderWaitingVC") as! ServiceOrderWaitingVC
        vC.viewModel.orderiD = obj.id ?? ""
        self.navigationController?.pushViewController(vC, animated: true)
    }
}
