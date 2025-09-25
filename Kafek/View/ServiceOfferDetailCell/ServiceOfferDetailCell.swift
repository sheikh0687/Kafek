//
//  ServiceOfferDetailCell.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 17/02/25.
//

import UIKit

class ServiceOfferDetailCell: UITableViewCell {

    @IBOutlet weak var product_Img: UIImageView!
    @IBOutlet weak var lbl_ItemName: UILabel!
    @IBOutlet weak var lbl_ItemPrice: UILabel!
    @IBOutlet weak var lbl_Quantity: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lbl_ItemName.font = UIFont(name: "Cairo-Regular", size: 12)
        lbl_Quantity.font = UIFont(name: "Cairo-Bold", size: 10)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
