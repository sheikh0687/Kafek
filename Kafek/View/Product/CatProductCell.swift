//
//  CatProductCell.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 10/08/24.
//

import UIKit

class CatProductCell: UITableViewCell {

    @IBOutlet weak var lbl_ItemName: UILabel!
    @IBOutlet weak var lbl_ItemPrice: UILabel!
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var subVw: UIView!
    
    var cloViewDetail:(() -> Void)?
    
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
    
    @IBAction func btn_ViewDetail(_ sender: UIButton) {
        self.cloViewDetail?()
    }
}
