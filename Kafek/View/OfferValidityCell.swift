//
//  OfferValidityCell.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 10/08/24.
//

import UIKit
import Cosmos

class OfferValidityCell: UITableViewCell {

    @IBOutlet weak var driver_Img: UIImageView!
    @IBOutlet weak var lbl_Name: UILabel!
    @IBOutlet weak var ratingStart: CosmosView!
    @IBOutlet weak var lbl_RatingCount: UILabel!
    @IBOutlet weak var lbl_OfferPrice: UILabel!
    @IBOutlet weak var lbl_Distance: UILabel!
    @IBOutlet weak var lbl_Quantity: UILabel!
    @IBOutlet weak var lbl_TotalAmount: UILabel!
    
    @IBOutlet weak var btn_OfferAcceptedOt: UIButton!
    @IBOutlet weak var btn_RejectedOt: UIButton!

    var cloOfferAccepted:(() -> Void)?
    var cloOfferReject:(() -> Void)?
    var cloChat:(() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lbl_Name.font = UIFont(name: "Cairo-Bold", size: 12)
        lbl_Quantity.font = UIFont(name: "Cairo-Bold", size: 10)
        lbl_RatingCount.font = UIFont(name: "Cairo-Regular", size: 12)
        lbl_OfferPrice.font = UIFont(name: "Cairo-Bold", size: 12)
        lbl_TotalAmount.font = UIFont(name: "Cairo-Regular", size: 14)
        lbl_Distance.font = UIFont(name: "Cairo-Regular", size: 10)
        
        btn_OfferAcceptedOt.titleLabel?.font = UIFont(name: "Cairo-Bold", size: 10)
        btn_RejectedOt.titleLabel?.font = UIFont(name: "Cairo-Bold", size: 10)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func btn_OfferAccepted(_ sender: UIButton) {
        self.cloOfferAccepted?()
    }
    
    @IBAction func btn_Reject(_ sender: UIButton) {
        self.cloOfferReject?()
    }
    
    @IBAction func btn_Chat(_ sender: UIButton) {
        self.cloChat?()
    }
}
