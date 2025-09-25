//
//  HelpVC.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 14/08/24.
//

import UIKit

class HelpVC: UIViewController {

    @IBOutlet weak var txt_Message: UITextView!
    @IBOutlet weak var lbl_Headline: UILabel!
    
    let viewModel = HelpViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txt_Message.addHint(R.string.localizable.typeSomething())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        self.lbl_Headline.text = R.string.localizable.writeToUs()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func btn_back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_Send(_ sender: UIButton) {
        if txt_Message.text != "" {
            bindViewModel()
        } else {
            self.alert(alertmessage: R.string.localizable.pleaseEnterTheMessage())
        }
    }
    
    private func bindViewModel() {
        viewModel.strMessage = self.txt_Message.text ?? ""
        viewModel.contactInfo(vC: self)
        viewModel.cloSuccessfull = { [weak self] in
            guard let self = self else { return }
            
            Utility.showAlertWithAction(withTitle: k.appName,
                                        message: R.string.localizable.weWillContactYouSoon(),
                                        delegate: nil,
                                        parentViewController: self) { bool in
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
