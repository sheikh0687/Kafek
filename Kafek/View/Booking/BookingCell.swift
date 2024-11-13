//
//  BookingCell.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 09/08/24.
//

import UIKit

class BookingCell: UITableViewCell {

    @IBOutlet weak var subVw: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        subVw.roundCorners(corners: [.topRight, .bottomRight], radius: 10)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
