//
//  RecShopCell.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 08/08/24.
//

import UIKit

class RecShopCell: UITableViewCell {

    @IBOutlet weak var lbl_StoreName: UILabel!
    @IBOutlet weak var lbl_Timing: UILabel!
    @IBOutlet weak var lbl_Address: UILabel!
    
    @IBOutlet weak var btn_RatingReview: UIButton!
    
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var subVw: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        img.roundCorners(corners: [.topLeft, .bottomLeft], radius: 10)
        subVw.roundCorners(corners: [.topRight, .bottomRight], radius: 10)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
