//
//  GiveRatingVC.swift
//  Kafak Store
//
//  Created by Techimmense Software Solutions on 10/03/25.
//

import UIKit
import Cosmos

class GiveRatingVC: UIViewController {

    @IBOutlet weak var cosmosRating: CosmosView!
    @IBOutlet weak var txt_Review: UITextView!
    @IBOutlet weak var lbl_Headline: UILabel!
    
    @IBOutlet weak var serviceImg: UIImageView!
    
    let viewModel = AddRatingViewModel()
    var serviceImage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let baseUrl = Router.BASE_IMAGE_URL + (serviceImage ?? "")
        Utility.setImageWithSDWebImage(baseUrl, self.serviceImg)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        self.lbl_Headline.text = R.string.localizable.giveRating()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func btn_back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setUpBinding() {
        viewModel.ratingStar = cosmosRating.rating
        viewModel.strReview = txt_Review.text ?? ""
        viewModel.requestToAddRatings(vC: self)
        viewModel.cloRateSuccess = { [weak self] in
            guard let self = self else { return }
            
            self.viewModel.requestToUpdatePayment(vC: self)
            self.viewModel.cloPaymentUpdatedSuccessfully = { [weak self] message in
                guard let self = self else { return }
                
                Utility.showAlertWithAction(withTitle: k.appName, message: message, delegate: nil, parentViewController: self) { [weak self] bool in
                    guard let self = self else { return }
                    
                    Switcher.updateRootVC()
                }
            }
        }
    }
    
    @IBAction func btn_Done(_ sender: UIButton) {
        if cosmosRating.rating.isZero {
            self.alert(alertmessage: R.string.localizable.pleaseAddRate())
        } else {
            setUpBinding()
        }
        
//        else if txt_Review.text == "" {
//           self.alert(alertmessage: R.string.localizable.pleaseEnterTheReview())
//       }
    }
}
