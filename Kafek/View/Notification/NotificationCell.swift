//
//  NotificationCell.swift
//  Kafak Driver
//
//  Created by Techimmense Software Solutions on 12/08/24.
//

import UIKit

class NotificationCell: UITableViewCell {

    @IBOutlet weak var lbl_NotificationTitle: UILabel!
    @IBOutlet weak var lbl_DateTime: UILabel!
    
    @IBOutlet weak var lbl_Line: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.lbl_Line.roundCorners(corners: [.allCorners], radius: 4)
        self.lbl_NotificationTitle.font = UIFont(name: "Cairo-Bold", size: 12)
        self.lbl_DateTime.font = UIFont(name: "Cairo-Light", size: 10)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
