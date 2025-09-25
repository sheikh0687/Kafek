//
//  CancelReasonPopup.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 19/02/25.
//

import UIKit

class CancelReasonPopup: UIViewController {

    @IBOutlet weak var txt_CancelReason: UITextView!
    var cloCheckAndCall: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txt_CancelReason.addHint(R.string.localizable.reasonForCancellation())
    }
    
    @IBAction func btn_Send(_ sender: UIButton) {
        if self.txt_CancelReason.hasText {
            self.dismiss(animated: true) {
                self.cloCheckAndCall?(self.txt_CancelReason.text)
            }
        } else {
            self.alert(alertmessage: R.string.localizable.pleaseEnterTheReasonForCancellation())
        }
    }
    
    @IBAction func btn_Cancel(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
