//
//  AddAddressVC.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 18/09/24.
//

import UIKit

class SaveAddressVC: UIViewController {
    
    @IBOutlet weak var address_TableVw: UITableView!
    @IBOutlet weak var lbl_Headline: UILabel!
    
    let viewModel = SavedAddressViewModel()
    
    var isFrom:String = ""
    var cloAddress:((_ valAddress: String) -> Void)?
    var cloPlaceAddress:((_ valAddress: String,_ valLat:String,_ valLon:String,_ striD: String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.address_TableVw.register(UINib(nibName: "SavedAddressCell", bundle: nil), forCellReuseIdentifier: "SavedAddressCell")
        self.lbl_Headline.text = R.string.localizable.savedAddress()
        setUpAddressDelete()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        setUpAddressBinding()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    deinit {
        print("Saved Address Screen Deinit")
    }
    
    @IBAction func btn_Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_AddAddress(_ sender: UIButton) {
        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "AddAddressVC") as! AddAddressVC
        self.navigationController?.pushViewController(vC, animated: true)
    }
    
    private func setUpAddressBinding()
    {
        viewModel.requestUserAddress(vC: self, tablevW: address_TableVw)
        viewModel.successfulResponse = { [weak self] in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.address_TableVw.reloadData()
            }
        }
    }
    
    private func setUpAddressDelete()
    {
        viewModel.deletedSuccessful = { [weak self] in
            guard let self = self else { return }
            
            Utility.showAlertWithAction(withTitle: k.appName, message: R.string.localizable.addressDeleted(), delegate: nil, parentViewController: self) { [weak self] bool in
                guard let self = self else { return }
                
                self.viewModel.requestUserAddress(vC: self, tablevW: address_TableVw)
            }
        }
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
                
        cell.cloDelete = { [weak self] in
            guard let self = self else { return }
            
            self.viewModel.requestToDeleteAddress(vC: self, address_Id: obj.id ?? "")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = viewModel.arrayUserAddress[indexPath.row]
        
        if isFrom == "Home" {
            if let address = obj.addresstype {
                print(address) // Make sure this prints correctly
                
                // Pass back the selected address
                cloAddress?(address)
                
                // Navigate back after sending the value
                viewModel.returnBack(from: self.navigationController)
            } else {
                print("Address is nil")
            }
        } else if isFrom == "Cart" {
            if let address = obj.address {
                print(address) // Make sure this prints correctly
                
                // Pass back the selected address
                cloAddress?(address)
                
                // Navigate back after sending the value
                viewModel.returnBack(from: self.navigationController)
            }
        } else {
            if let address = obj.address {
                let lat = obj.lat ?? ""
                let lon = obj.lon ?? ""
                let striD = obj.id ?? ""
                
                // Pass back the selected address
                cloPlaceAddress?(address,lat,lon, striD)
                
                // Navigate back after sending the value
                viewModel.returnBack(from: self.navigationController)
            } else {
                print("Address is nil")
            }
        }
    }
}
