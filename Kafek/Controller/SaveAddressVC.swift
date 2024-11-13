//
//  AddAddressVC.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 18/09/24.
//

import UIKit

class SaveAddressVC: UIViewController {

    @IBOutlet weak var address_TableVw: UITableView!
    
    let viewModel = SavedAddressViewModel()
    
    var cloAddress:((_ valAddress: String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.address_TableVw.register(UINib(nibName: "SavedAddressCell", bundle: nil), forCellReuseIdentifier: "SavedAddressCell")
        setUpAddressDelete()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = false
        setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: "Saved Address", CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "#001845", BackgroundImage: "", TextColor: "#ffffff", TintColor: "#ffffff", Menu: "")
        setUpAddressBinding()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setUpAddressBinding()
    {
        viewModel.requestUserAddress(vC: self)
        viewModel.successfulResponse = {
            DispatchQueue.main.async {
                self.address_TableVw.reloadData()
            }
        }
    }
    
    private func setUpAddressDelete()
    {
        viewModel.deletedSuccessful = {
            Utility.showAlertWithAction(withTitle: k.appName, message: "Address Deleted", delegate: nil, parentViewController: self) { bool in
                self.viewModel.requestUserAddress(vC: self)
            }
        }
    }
    
    @IBAction func btn_AddNewAddress(_ sender: UIButton) {
        viewModel.navigateToAddAddressViewController(from: self.navigationController)
    }
}

extension SaveAddressVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.arrayUserAddress.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SavedAddressCell", for: indexPath) as! SavedAddressCell
        
        let obj = viewModel.arrayUserAddress[indexPath.row]
        cell.lbl_Addres.text = "\(obj.address ?? "")\n\(obj.addresstype ?? "")"
        
        let attributedString = NSMutableAttributedString(string: cell.lbl_Addres.text ?? "")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2 // Set the desired spacing between lines
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))

        cell.lbl_Addres.attributedText = attributedString
        
        cell.cloDelete = {
            self.viewModel.requestToDeleteAddress(vC: self, address_Id: obj.id ?? "")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = viewModel.arrayUserAddress[indexPath.row]
        if let address = obj.address {
            print(address) // Make sure this prints correctly
            
            // Pass back the selected address
            cloAddress?(address)
            
            // Navigate back after sending the value
            viewModel.returnBack(from: self.navigationController)
        } else {
            print("Address is nil")
        }
    }
}
