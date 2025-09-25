//
//  LastChatCell.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 11/03/25.
//

import UIKit

class LastChatCell: UITableViewCell {

    @IBOutlet weak var lbl_UserName: UILabel!
    @IBOutlet weak var lbl_RequestNumber: UILabel!
    @IBOutlet weak var lbl_LastMessage: UILabel!
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var lbl_DateTime: UILabel!
    @IBOutlet weak var numberMsgVw: UIView!
    @IBOutlet weak var lbl_Number: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.lbl_UserName.font = UIFont(name: "Cairo-Regular", size: 14)
        self.lbl_RequestNumber.font = UIFont(name: "Cairo-Regular", size: 12)
        self.lbl_DateTime.font = UIFont(name: "Cairo-Light", size: 10)
        self.lbl_LastMessage.font = UIFont(name: "Cairo-Regular", size: 14)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
