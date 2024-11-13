//
//  LandingViewModel.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 10/09/24.
//

import Foundation
import UIKit

class LandingViewModel {
    
    var currentIndex = 0
    
    var arrayMainHeading =
    [
    "Find and purchase building materials easily",
    "Book a Truck, Trolley or Any Other Vechile",
    "Purchase Accessories and Tools"
    ]
    
    var arraySubHeading =
    [
    "Browse our extensive catalog and order everything you need for your construction projects with just a few clicks.",
    "Choose the perfect vehicle for transporting your building materials efficiently, including truck, trolley and more",
    "From pipes to hammers, find all the essential tools and accessories for your building needs."
    ]

    var arrayImageList =
    [
        R.image.slide_1(),
        R.image.slide_2(),
        R.image.slide_3()
    ]

    var numberOfItmes: Int {
        return arrayImageList.count
    }
    
    var currentSlide: (images: UIImage?, mainHeading: String, subHeading: String) {
        return (arrayImageList[currentIndex], arrayMainHeading[currentIndex], arraySubHeading[currentIndex])
    }
    
    func updateCurrentIndex(to index: Int) {
        currentIndex = index
    }
    
    func incrementIndex() -> Bool {
        if currentIndex < (arrayImageList.count - 1) {
            currentIndex += 1
            return true
        } else {
            return false
        }
    }
    
    func getCurrentIndex() -> Int {
        return currentIndex
    }
    
    func navigateToLoginViewController(from navigationController: UINavigationController?) {
        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        navigationController?.pushViewController(vC, animated: true)
    }
}
