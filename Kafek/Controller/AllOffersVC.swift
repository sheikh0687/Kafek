//
//  AllOffersVC.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 12/08/24.
//

import UIKit

class AllOffersVC: UIViewController {

    @IBOutlet weak var offer_TableVw: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.offer_TableVw.register(UINib(nibName: "AllOffersCell", bundle: nil), forCellReuseIdentifier: "AllOffersCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: "All Offers", CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "#001845", BackgroundImage: "", TextColor: "#ffffff", TintColor: "#ffffff", Menu: "")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
}

extension AllOffersVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllOffersCell", for: indexPath) as! AllOffersCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
