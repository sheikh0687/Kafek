//
//  RecShopCell.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 08/08/24.
//

import UIKit
import Cosmos

class RecShopCell: UITableViewCell {

    @IBOutlet weak var lbl_StoreName: UILabel!
    @IBOutlet weak var lbl_Timing: UILabel!
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var cosmosVw: CosmosView!
    @IBOutlet weak var lbl_Rating: UILabel!
    @IBOutlet weak var lbl_Description: UILabel!
    
    @IBOutlet weak var subVw: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        img.roundCorners(corners: [.topLeft, .bottomLeft], radius: 10)
        subVw.roundCorners(corners: [.topRight, .bottomRight], radius: 10)
        lbl_StoreName.font = UIFont(name: "Cairo-Regular", size: 14)
        lbl_Timing.font = UIFont(name: "Cairo-Regular", size: 14)
        lbl_Rating.font = UIFont(name: "Cairo-Regular", size: 14)
        lbl_Description.font = UIFont(name: "Cairo-Regular", size: 14)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
