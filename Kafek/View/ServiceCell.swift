//
//  ServiceCell.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 08/08/24.
//

import UIKit

class ServiceCell: UICollectionViewCell {

    @IBOutlet weak var service_Img: UIImageView!
    @IBOutlet weak var lbl_ServiceName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        service_Img.roundCorners(corners: [.topLeft, .topRight], radius: 10)
    }
}
