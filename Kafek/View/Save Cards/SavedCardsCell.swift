//
//  SavedCardsCell.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 10/04/25.
//

import UIKit

class SavedCardsCell: UITableViewCell {

    @IBOutlet weak var lbl_CardDetails: UILabel!
    
    var cloDelete:()->Void = { }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btn_DeleteCard(_ sender: UIButton) {
        self.cloDelete()
    }
}
