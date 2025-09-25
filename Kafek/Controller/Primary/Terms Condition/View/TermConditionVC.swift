//
//  TermConditionVC.swift
//  Kafak Driver
//
//  Created by Techimmense Software Solutions on 21/04/25.
//

import UIKit

class TermConditionVC: UIViewController {
    
    @IBOutlet weak var lbl_Headline: UILabel!
    @IBOutlet weak var lbl_Privacy: UILabel!
    
    let viewModel = TermConditionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        if viewModel.strType == "TermsCondition" {
            self.lbl_Headline.text = R.string.localizable.termOfServices()
        } else if viewModel.strType == "AboutUs" {
            self.lbl_Headline.text = R.string.localizable.aboutUs()
        } else {
            self.lbl_Headline.text = R.string.localizable.privacyPolicy()
        }
    }
    
    @IBAction func btnBackTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    private func bindData() {
        viewModel.fetchUserPages(vC: self)
        viewModel.cloSuccess = { [weak self] in
            guard let self = self else { return }
            
            let html = self.viewModel.strDescription
            if let attributedString = html.htmlAttributedString3 {
                self.lbl_Privacy.attributedText = attributedString
            }
        }
    }
}
