//
//  BookingCell.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 09/08/24.
//

import UIKit

class BookingCell: UITableViewCell {

    @IBOutlet weak var cat_Img: UIImageView!
    @IBOutlet weak var subVw: UIView!
    
    @IBOutlet weak var lbl_Category: UILabel!
    @IBOutlet weak var lbl_Size: UILabel!
    @IBOutlet weak var lbl_Quantity: UILabel!
    @IBOutlet weak var lbl_Amount: UILabel!
    @IBOutlet weak var lbl_Status: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        subVw.roundCorners(corners: [.topRight, .bottomRight], radius: 10)
        lbl_Category.font = UIFont(name: "Cairo-Regular", size: 14)
        lbl_Size.font = UIFont(name: "Cairo-Light", size: 10)
        lbl_Quantity.font = UIFont(name: "Cairo-Regular", size: 10)
        lbl_Amount.font = UIFont(name: "Cairo-Regular", size: 12)
        lbl_Status.font = UIFont(name: "Cairo-Regular", size: 10)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
