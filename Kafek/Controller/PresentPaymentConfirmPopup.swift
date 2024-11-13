//
//  PresentAddProductVC.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 14/08/24.
//

import UIKit

class PresentPaymentConfirmPopup: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func btn_Cancel(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func btn_Ok(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
