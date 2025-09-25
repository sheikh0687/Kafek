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
    @IBOutlet weak var lbl_ItemOfferPrice: UILabel!
    @IBOutlet weak var lbl_Decription: UILabel!
    //    @IBOutlet weak var btn_ViewDetailsOt: UIButton!
    @IBOutlet weak var priceVw: UIView!
    
    
    @IBOutlet weak var img: UIImageView!
    //    @IBOutlet weak var subVw: UIView!
    
    var cloViewDetail:(() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lbl_ItemName.font = UIFont(name: "Cairo-Regular", size: 14)
        lbl_ItemPrice.font = UIFont(name: "Cairo-Regular", size: 10)
        lbl_ItemOfferPrice.font = UIFont(name: "Cairo-Regular", size: 12)
        lbl_Decription.font = UIFont(name: "Cairo-Regular", size: 12)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func btn_ViewDetail(_ sender: UIButton) {
        self.cloViewDetail?()
    }
}
