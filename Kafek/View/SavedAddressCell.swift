//
//  SavedAddressCell.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 18/09/24.
//

import UIKit

class SavedAddressCell: UITableViewCell {

    @IBOutlet weak var lbl_Addres: UILabel!
    
    var cloDelete:(() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btn_Delete(_ sender: UIButton) {
        self.cloDelete?()
    }
}
