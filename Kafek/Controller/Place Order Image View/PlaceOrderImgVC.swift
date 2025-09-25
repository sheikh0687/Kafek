//
//  PlaceOrderImgVC.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 22/07/25.
//

import UIKit

class PlaceOrderImgVC: UIViewController {

    @IBOutlet weak var orderImg: UIImageView!
    
    var imageVw: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if imageVw != nil {
            Utility.setImageWithSDWebImage(imageVw, self.orderImg)
        } else {
            self.orderImg.image = R.image.no_Image_Available()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func btnBackTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
