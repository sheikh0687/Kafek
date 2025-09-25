//
//  DeliveryVhcCell.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 10/08/24.
//

import UIKit

class DeliveryVhcCell: UITableViewCell {

    @IBOutlet weak var lbl_Size: UILabel!
    @IBOutlet weak var vehicle_Img: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lbl_Size.font = UIFont(name: "Cairo-Regular", size: 14)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
