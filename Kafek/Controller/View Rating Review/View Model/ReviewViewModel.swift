//
//  ReviewViewModel.swift
//  Kafak Store
//
//  Created by Techimmense Software Solutions on 11/03/25.
//

import Foundation

class ReviewViewModel {
    
    var arrayReviewList: [Res_ReviewList] = []
    var cloReviewSuccess: (() -> Void)?
    
    func requestToFetchReview(vC: UIViewController) {
        Api.shared.requestToFetchUserReview(vC) { [weak self] responseData in
            guard let self = self else { return }
            
            if responseData.count > 0 {
                self.arrayReviewList = responseData
            } else {
                self.arrayReviewList = []
            }
            self.cloReviewSuccess?()
        }
    }
}
