//
//  OfferValidityCell.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 10/08/24.
//

import UIKit

class OfferValidityCell: UITableViewCell {

    var cloOfferAccepted:(() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func btn_OfferAccepted(_ sender: UIButton) {
        self.cloOfferAccepted?()
    }
}
