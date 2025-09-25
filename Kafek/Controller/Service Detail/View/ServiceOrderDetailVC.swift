//
//  OrderDetailVC.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 10/08/24.
//

import UIKit
import DropDown
import Gallery

class ServiceOrderDetailVC: UIViewController {
    
//    MARK: PROPERTIES
    @IBOutlet weak var equipementCollectionVw: UICollectionView!
    @IBOutlet var collec_Photo: UICollectionView!
    @IBOutlet weak var lbl_ProductName: UILabel!
    @IBOutlet weak var lbl_Description: UILabel!
    @IBOutlet weak var lbl_Price: UILabel!
    @IBOutlet weak var lbl_Address: UILabel!
    @IBOutlet weak var txtNotes: UITextView!
    @IBOutlet weak var lbl_TotalAmount: UILabel!
    @IBOutlet weak var lbl_TotalCount: UILabel!
    @IBOutlet weak var selectPriceVw: UIView!
    @IBOutlet weak var btn_PriceOt: UIButton!
    @IBOutlet weak var addCounterVw: UIView!
    @IBOutlet weak var lbl_Notes: UILabel!
    @IBOutlet weak var lbl_Headline: UILabel!
    
//    MARK: VARIABLES
    let viewModel = ServiceOrderViewModel()
    var dropDown = DropDown()
    
    var arrImage:[[String : AnyObject]] = []
    var servicePriceList = [String]()
    var image = UIImage()
    
    var staticItemPrice:Int = 0
    var itmePrice:Int = 0
    var finalTotalPrice = 0
    var totalCount:Int = 1

    var perMonth:Int = 0
    var perDay:Int = 0
    var perHour:Int = 0
    
    var itemName:String = ""
    var productImg:String = ""
    var provideriD:String = ""
    var vehicleiD:String = ""
    var priceType:String = ""
    var strAddress:String = ""
    var strLat:String = ""
    var strLong:String = ""
    var strAddressiD:String = ""
    var perUnit:String = "Per Month"
    var strPaymentMethod:String = ""
    
    var strOrderMethod:String = ""
    
    var timer:Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(addressPicker))
        lbl_Address.isUserInteractionEnabled = true
        lbl_Address.addGestureRecognizer(tapGesture)
        equipementCollectionVw.register(UINib(nibName: "BannerCell", bundle: nil), forCellWithReuseIdentifier: "BannerCell")
        self.setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func btn_Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    deinit {
        print("ServiceOrderdetail Screen deinit")
    }
    
//    MARK: ALL ACTIONS
    @objc func addressPicker() {
        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "SaveAddressVC") as! SaveAddressVC
        vC.isFrom = "Service"
        vC.cloPlaceAddress = { [weak self] addressVal, valLat, valLon, strID in
            print(addressVal)
            guard let self = self else { return }
            self.lbl_Address.text = addressVal
            self.strAddress = addressVal
            self.strLat = valLat
            self.strLong = valLon
            self.strAddressiD = strID
            viewModel.caculateServicePriceWithZone(vC: self, strItmePrice: String(finalTotalPrice), strLat: valLat, strLon: valLon, totalCount: self.totalCount)
            self.txtNotes.becomeFirstResponder()
            self.txtNotes.textAlignment = L102Language.currentAppleLanguage() == "en" ? .left : .right
        }
        self.navigationController?.pushViewController(vC, animated: true)
    }
    
    @IBAction func btn_SelectPrice(_ sender: UIButton) {
        dropDown.anchorView = sender
        let priceList = servicePriceList
        dropDown.dataSource =  priceList
        dropDown.show()
        dropDown.bottomOffset = CGPoint(x: 0, y: 45)
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            guard let self
                    = self else { return }
            
            sender.setTitle(item, for: .normal)
            if item.contains("Per Month") {
                self.lbl_Price.text = "\(R.string.localizable.price()):\(item.replacingOccurrences(of: "Per Month", with: ""))"
                self.lbl_TotalAmount.text = "\(item.replacingOccurrences(of: "Per Month", with: ""))"
                self.itmePrice = self.perMonth
                self.finalTotalPrice = self.perMonth
//                self.finalTotalPrice = (self.perMonth * self.totalCount)
                self.lbl_TotalAmount.text = "\(self.finalTotalPrice).0 SR"
                self.perUnit = "Per Month"
            } else if item.contains("Per Day") {
                self.lbl_Price.text = "\(R.string.localizable.price()): \(item.replacingOccurrences(of: "Per Day", with: ""))"
                self.lbl_TotalAmount.text = "\(item.replacingOccurrences(of: "Per Day", with: ""))"
                self.itmePrice = self.perDay
                self.finalTotalPrice = self.perDay
//                self.finalTotalPrice = (self.perDay * self.totalCount)
                self.lbl_TotalAmount.text = "\(self.finalTotalPrice).0 SR"
                self.perUnit = "Per Day"
            } else {
                self.lbl_Price.text = "\(R.string.localizable.price()): \(item.replacingOccurrences(of: "Per Hour", with: ""))"
                self.lbl_TotalAmount.text = "\(item.replacingOccurrences(of: "Per Hour", with: ""))"
                self.itmePrice = self.perHour
                self.finalTotalPrice = self.perHour
//                self.finalTotalPrice = (self.perHour * self.totalCount)
                self.lbl_TotalAmount.text = "\(self.finalTotalPrice).0 SR"
                self.perUnit = "Per Hour"
            }
        }
    }
    
    @IBAction func btn_LoadPicture(_ sender: UIButton) {
        Config.Camera.recordLocation = true
        Config.Camera.imageLimit = 3
        Config.tabsToShow = [.imageTab, .cameraTab]
        let gallery = GalleryController()
        gallery.delegate = self
        present(gallery, animated: true, completion: nil)
    }
    
    @IBAction func btn_Plus(_ sender: UIButton) {
        finalTotalPrice += itmePrice
        print(finalTotalPrice)
        print(itmePrice)
        totalCount += 1
        self.lbl_TotalCount.text = "\(totalCount)"
        if strAddress != "" {
            viewModel.caculateServicePriceWithZone(vC: self, strItmePrice: String(finalTotalPrice), strLat: strLat, strLon: strLong, totalCount: self.totalCount)
            print(finalTotalPrice)
        }
    }
    
    @IBAction func btn_Minus(_ sender: UIButton) {
        if totalCount != 1 {
            finalTotalPrice -= itmePrice
            totalCount -= 1
            self.lbl_TotalCount.text = "\(totalCount)"
//            self.lbl_TotalAmount.text = "\(finalTotalPrice).0 SR"
            viewModel.caculateServicePriceWithZone(vC: self, strItmePrice: String(finalTotalPrice), strLat: strLat, strLon: strLong, totalCount: self.totalCount)
        }
    }
    
    @IBAction func btn_SendRequest(_ sender: UIButton) {
        if self.strAddress != "" {
            let vC = R.storyboard.main().instantiateViewController(withIdentifier: "SrviceOrderFinalCheckOutVC") as! SrviceOrderFinalCheckOutVC
            
            // Just For Expected Asking Price
            vC.expectedAmt = String(Int(viewModel.finalPriceWithZonePrice)
                                    /** totalCount*/)
            print(vC.expectedAmt)
            vC.strUnit = perUnit
            print(perUnit)
            
            vC.strOrderMethod = self.strOrderMethod
            vC.strPaymentMethod = self.strPaymentMethod
            
            vC.itemCount = String(self.totalCount)
            
            vC.itemName = self.itemName
            vC.itemImg = self.productImg

            vC.viewModel.totalAmt = String(viewModel.finalPriceWithZonePrice)
            
            print(vC.viewModel.totalAmt)
            print(viewModel.finalPriceWithZonePrice)
            
            vC.viewModel.totalCount = String(totalCount)
            
            vC.viewModel.orderiD = viewModel.orderiD
            vC.viewModel.productiD = viewModel.productiD
            
            vC.viewModel.provideriD = provideriD
            vC.viewModel.vehicleiD = vehicleiD
            vC.viewModel.priceType = priceType

            vC.viewModel.strDeliveryFee = String(staticItemPrice)
            vC.viewModel.arrayOfServiceDetails = viewModel.arrayOfServiceDetails
            vC.viewModel.arrayOfProductImages = viewModel.arrayOfProductImages
            vC.viewModel.arrImage = self.arrImage
            vC.viewModel.valAddress = self.strAddress
            vC.viewModel.valLat = self.strLat
            vC.viewModel.valLon = self.strLong
            vC.viewModel.valAddressId = self.strAddressiD
            vC.viewModel.zoneiD = self.viewModel.strZoneiD
            vC.viewModel.zonePriceiD = self.viewModel.strZonePriceiD
            vC.viewModel.zonePrice = self.viewModel.strZonePrice
            vC.viewModel.zoneName = self.viewModel.strZoneName
            vC.viewModel.strNotes = self.txtNotes.text ?? ""
            
            vC.serviceDetailModel.orderiD = viewModel.orderiD
            vC.serviceDetailModel.productiD = viewModel.productiD
            vC.serviceDetailModel.type = viewModel.type
            self.navigationController?.pushViewController(vC, animated: true)
        } else {
            self.alert(alertmessage: R.string.localizable.pleaseSelectTheAddress())
        }
    }
}

// MARK: NETWORK CALLING
extension ServiceOrderDetailVC {
    
    private func setupBindings() {
        self.viewModel.requestToGetServiceDt(vC: self)
        self.viewModel.successResponse = { [weak self] in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                let obj = self.viewModel.arrayOfServiceDetails
                if L102Language.currentAppleLanguage() == "ar" {
                    self.lbl_ProductName.text = obj?.item_name_ar ?? ""
                    self.lbl_Description.text = obj?.description_ar ?? ""
                    self.lbl_Notes.text = obj?.note_for_user_ar ?? ""
                } else {
                    self.lbl_ProductName.text = obj?.item_name ?? ""
                    self.lbl_Description.text = obj?.description ?? ""
                    self.lbl_Notes.text = obj?.note_for_user ?? ""
                }
                self.itemName = L102Language.currentAppleLanguage() == "en" ? obj?.item_name ?? "" : obj?.item_name_ar ?? ""
                self.provideriD = obj?.provider_id ?? ""
                self.vehicleiD = obj?.vehicle_id ?? ""
                self.priceType = obj?.service_type ?? ""
            
                self.strOrderMethod = obj?.order_method ?? ""
                self.strPaymentMethod = obj?.payment_method ?? ""
            
                self.staticItemPrice = Int(obj?.item_price ?? "") ?? 0
                self.itmePrice = Int(obj?.item_price ?? "") ?? 0
                self.finalTotalPrice = Int(obj?.item_price ?? "") ?? 0
                
                print(obj?.item_price ?? "")

                if obj?.service_type == "rental_service" {
                    self.servicePriceList.removeAll()
                    self.servicePriceList.append("Per Month \(obj?.per_month_price ?? "").0 SR")
                    self.servicePriceList.append("Per Day \(obj?.per_day_price ?? "").0 SR")
                    self.servicePriceList.append("Per Hour \(obj?.per_hour_price ?? "").0 SR")
                    self.perMonth = Int(obj?.per_month_price ?? "") ?? 0
                    self.perDay = Int(obj?.per_day_price ?? "") ?? 0
                    self.perHour = Int(obj?.per_hour_price ?? "") ?? 0
                    self.lbl_Price.text = "\(R.string.localizable.price()): \(obj?.per_month_price ?? "").0 SR"
                    self.lbl_TotalAmount.text = "\(obj?.per_month_price ?? "").0 SR"
                    self.btn_PriceOt.setTitle("\(R.string.localizable.perMonth()) \(obj?.per_month_price ?? "").0 SR", for: .normal)
                    self.itmePrice = Int(obj?.per_month_price ?? "") ?? 0
                    self.finalTotalPrice = Int(obj?.per_month_price ?? "") ?? 0
                } else {
                    self.selectPriceVw.isHidden = true
                    self.lbl_Price.text = "\(R.string.localizable.price()): \(obj?.item_price ?? "") SR"
                    self.lbl_TotalAmount.text = "\(obj?.item_price ?? "").0 SR"
                }
                
                if obj?.service_type == "general_service" {
                    self.addCounterVw.isHidden = true
                } else {
                    self.addCounterVw.isHidden = false
                }
                
                if let productImg = obj?.product_images {
                    self.productImg = productImg[0].image ?? ""
                }
                
                self.equipementCollectionVw.reloadData()
            }
        }
    }
}

// MARK: TEXTVIEW
extension ServiceOrderDetailVC: UITextViewDelegate {
        
    func textViewDidChange(_ textView: UITextView) {
        if textView.tag == 0 {
            if textView.text != "" {
                self.lbl_Notes.isHidden = true
                print("dd")
            } else {
                self.lbl_Notes.isHidden = false
                print("nothing")
            }
        }
    }
}

// MARK: COLLECTIONVIEW
extension ServiceOrderDetailVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collec_Photo {
            arrImage.count
        } else {
            viewModel.arrayOfProductImages.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collec_Photo {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotoCell
            if let img = arrImage[indexPath.row]["image"] as? UIImage {
                cell.btn_Image.setImage(img, for: .normal)
            }
            
            cell.btn_cross.isHidden = false
            cell.btn_cross.tag = indexPath.row
            cell.btn_cross.addTarget(self, action: #selector(click_On_Cross(button:)), for: .touchUpInside)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as! BannerCell
            
            let obj = self.viewModel.arrayOfProductImages[indexPath.row]
            
            if Router.BASE_IMAGE_URL != obj.image {
                Utility.setImageWithSDWebImage(obj.image ?? "", cell.banner_Img)
            } else {
                cell.banner_Img.image = R.image.no_Image_Available()
            }
            
            return cell
        }
    }
    
    @objc func click_On_Cross(button:UIButton)  {
        print(button.tag)
        arrImage.remove(at: button.tag)
        self.collec_Photo.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collec_Photo {
            let size = collectionView.frame.size
            return CGSize(width: 100, height: size.height)
        } else {
            let size = collectionView.frame.size
            return CGSize(width: size.width, height: size.height)
        }
    }
}

// MARK: GALLERYPICKER
extension ServiceOrderDetailVC: GalleryControllerDelegate {
    
    func galleryController(_ controller: GalleryController, didSelectImages images: [Image]) {
        
        Image.resolve(images: images, completion: { [weak self] resolvedImages in
            print(resolvedImages.compactMap({ $0 }))
            for img in resolvedImages {
                var dict : [String:AnyObject] = [:]
                dict["image"] = img as AnyObject
                dict["type"] = "local" as AnyObject
                self?.arrImage.append(dict)
            }
            self!.collec_Photo.reloadData()
        })
        self.dismiss(animated: true, completion: nil)
    }
    
    func galleryController(_ controller: GalleryController, didSelectVideo video: Video) {
        print(video)
    }
    
    func galleryController(_ controller: GalleryController, requestLightbox images: [Image]) {
        print([Image].self)
    }
    
    func galleryControllerDidCancel(_ controller: GalleryController) {
        self.dismiss(animated: true, completion: nil)
    }
}

