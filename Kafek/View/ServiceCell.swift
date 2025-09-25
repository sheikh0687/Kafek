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
    
    @IBOutlet weak var mainVw: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lbl_ServiceName.font = UIFont(name: "Cairo-Regular", size: 14)
    }
}
