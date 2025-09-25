//
//  CommonServiceViewModel.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 03/02/25.
//

import Foundation

class CommonServiceViewModel {
    
    func setupSearchBar(searchBar: UISearchBar!) {
        searchBar.placeholder = R.string.localizable.search()
       searchBar.barTintColor = UIColor.white
       searchBar.searchTextField.backgroundColor = UIColor.white
       searchBar.searchTextField.textColor = UIColor.black
       
       if let clearButton = searchBar.searchTextField.value(forKey: "_clearButton") as? UIButton {
           clearButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
       }
       
       searchBar.layer.cornerRadius = 10
       searchBar.layer.masksToBounds = true
   }
}
