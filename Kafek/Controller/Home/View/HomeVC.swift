//
//  HomeVC.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 08/08/24.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var main_BannerCollectionVw: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var recommendedShops_CollectionVw: UICollectionView!
    
    @IBOutlet weak var service_CollectionVw: UICollectionView!
    @IBOutlet weak var service_CollectionHeight: NSLayoutConstraint!
    @IBOutlet weak var lbl_NotifyCount: UILabel!
    @IBOutlet weak var notifyVw: UIView!
    @IBOutlet weak var lbl_ChatCount: UILabel!
    @IBOutlet weak var chatVw: UIView!
    @IBOutlet weak var btn_CartOt: UIButton!
    @IBOutlet weak var shopsVw: UIStackView!
    
    @IBOutlet weak var lbl_Address: UILabel!
    
    @IBOutlet weak var btn_SeeServiceOt: UIButton!
    @IBOutlet weak var btn_SeeShopsOt: UIButton!

    let viewModel = HomeViewModel()
    
    private let bannerRTL = RTLCollectionViewFlowLayout()
    private let shopRTL = RTLCollectionViewFlowLayout()
    
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectAddress))
        lbl_Address.isUserInteractionEnabled = true
        lbl_Address.addGestureRecognizer(tapGesture)
        self.lbl_NotifyCount.roundCorners(corners: [.allCorners], radius: 9)
        self.lbl_ChatCount.roundCorners(corners: [.allCorners], radius: 9)
        self.btn_SeeServiceOt.titleLabel?.font = R.font.cairoRegular(size: 12)!
        self.btn_SeeShopsOt.titleLabel?.font = R.font.cairoRegular(size: 12)!
        initIndentifier()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchAddressType()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
        
    }
    
    func fetchAddressType()
    {
        Api.shared.requestTopUserProfile(self) { [weak self] responseData in
            guard let self = self else { return }
            
            if responseData.status != "1" {
                Switcher.updateRootVC()
            }

            let obj = responseData.result!
            
            if obj.addresstype == "" {
                self.lbl_Address.text = L102Language.currentAppleLanguage() == "en" ? "Choose Address" : R.string.localizable.chooseAddress()
            } else {
                self.lbl_Address.text = obj.addresstype ?? ""
            }
            
            if obj.message_count != "0" {
                self.lbl_ChatCount.text = obj.message_count ?? ""
                self.chatVw.isHidden = false
            } else {
                self.chatVw.isHidden = true
            }
            
            if obj.noti_count != "0" {
                self.lbl_NotifyCount.text = obj.noti_count ?? ""
                self.notifyVw.isHidden = false
            } else {
                self.notifyVw.isHidden = true
            }
            
            if obj.booking_notifi_count != "0" {
                if let items = self.tabBarController?.tabBar.items as NSArray? {
                    let tabItem = items.object(at: 1) as! UITabBarItem
                    tabItem.badgeValue = obj.booking_notifi_count ?? ""
                }
            } else {
                if let items = self.tabBarController?.tabBar.items as NSArray? {
                    let tabItem = items.object(at: 1) as! UITabBarItem
                    tabItem.badgeValue = nil
                    print("All Count")
                }
            }
            
            if obj.store_visibility_status == "Yes" {
                self.btn_CartOt.isHidden = false
                self.shopsVw.isHidden = false
                self.setUpStoreBinding()
            } else {
                self.btn_CartOt.isHidden = true
                self.shopsVw.isHidden = true
            }
            
            setUpBannerBinding()
            setUpServiceBinding()
        }
    }
        
    @objc func selectAddress()
    {
        viewModel.navigateToSavedAddressViewController(from: self.navigationController, addressValue: lbl_Address)
    }
    
    private func setUpBannerBinding()
    {
        viewModel.requestBannerList(vC: self)
        viewModel.bannerSuccessResponse = { [weak self] in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                if L102Language.currentAppleLanguage() == "ar" {
                    self.bannerRTL.scrollDirection = .horizontal
                    self.main_BannerCollectionVw.collectionViewLayout = self.bannerRTL
                    self.main_BannerCollectionVw.semanticContentAttribute = .forceLeftToRight
                    self.pageControl.numberOfPages = self.viewModel.arrayBannerList.count
                } else {
                    self.bannerRTL.scrollDirection = .horizontal
                    self.main_BannerCollectionVw.collectionViewLayout = self.bannerRTL
                    self.main_BannerCollectionVw.semanticContentAttribute = .forceRightToLeft
                    self.pageControl.numberOfPages = self.viewModel.arrayBannerList.count
                }
                self.main_BannerCollectionVw.reloadData()
                self.configureSlider()
            }
        }
    }
    
    func configureSlider() {
        self.pageControl.numberOfPages = self.viewModel.arrayBannerList.count
        self.main_BannerCollectionVw.reloadData()
        
        // Invalidate existing timer before creating a new one
        timer?.invalidate()
        timer = nil
        
        // Start the timer only if there are multiple slides
        if self.viewModel.arrayBannerList.count > 1 {
            timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(runTimer), userInfo: nil, repeats: true)
        }
    }
    
    @objc func runTimer() {
        guard self.viewModel.arrayBannerList.count > 1 else { return } // Prevent execution if there's only one item
        
        let currentIndex = pageControl.currentPage
        let nextIndex = (currentIndex + 1) % self.viewModel.arrayBannerList.count  // Loop back to 0 when reaching the last index
        
        let indexPath = IndexPath(item: nextIndex, section: 0)
        main_BannerCollectionVw.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        pageControl.currentPage = nextIndex
    }
    
    private func setUpStoreBinding()
    {
        viewModel.requestStoreList(vC: self)
        viewModel.storeSuccessResponse = { [weak self] in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                if L102Language.currentAppleLanguage() == "ar" {
                    self.shopRTL.scrollDirection = .horizontal
                    self.recommendedShops_CollectionVw.collectionViewLayout = self.shopRTL
                    self.recommendedShops_CollectionVw.semanticContentAttribute = .forceLeftToRight
                } else {
                    self.shopRTL.scrollDirection = .horizontal
                    self.recommendedShops_CollectionVw.collectionViewLayout = self.shopRTL
                    self.recommendedShops_CollectionVw.semanticContentAttribute = .forceRightToLeft
                }
                self.recommendedShops_CollectionVw.reloadData()
            }
        }
    }
    
    private func setUpServiceBinding()
    {
        viewModel.collectionVwHeight = service_CollectionHeight
        viewModel.requestServiceList(vC: self)
        viewModel.serviceSuccessResponse = { [weak self] in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.service_CollectionVw.reloadData()
            }
        }
    }
    
    @IBAction func btn_Search(_ sender: UIButton) {
        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "CommonServicesVC") as! CommonServicesVC
        vC.arrayServiceList = self.viewModel.arrayServiceList
        vC.arrayServiceFiltered = self.viewModel.arrayServiceList
        vC.strTitle = R.string.localizable.allServices()
        self.navigationController?.pushViewController(vC, animated: true)
    }
    
    @IBAction func btn_SeeShops(_ sender: UIButton) {
        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "CommonServicesVC") as! CommonServicesVC
        vC.arrayStoreList = self.viewModel.arrayStoreList
        vC.arrayStoreFiltered = self.viewModel.arrayStoreList
        vC.strTitle = R.string.localizable.allShops()
        self.navigationController?.pushViewController(vC, animated: true)
    }
    
    @IBAction func btn_SeeService(_ sender: UIButton) {
        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "CommonServicesVC") as! CommonServicesVC
        vC.arrayServiceList = self.viewModel.arrayServiceList
        vC.arrayServiceFiltered = self.viewModel.arrayServiceList
        vC.strTitle = R.string.localizable.allServices()
        self.navigationController?.pushViewController(vC, animated: true)
    }
    
    @IBAction func btn_Cart(_ sender: UIButton) {
        viewModel.navigateToCartViewController(from: self.navigationController!, isFor: "Cart")
    }
    
    @IBAction func btn_Chat(_ sender: UIButton) {
        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "LastChatVC") as! LastChatVC
        self.navigationController?.pushViewController(vC, animated: true)
    }
    
    @IBAction func btn_Notification(_ sender: UIButton) {
        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        self.navigationController?.pushViewController(vC, animated: true)
    }
}

extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == main_BannerCollectionVw {
            return self.viewModel.arrayBannerList.count
        } else if collectionView == recommendedShops_CollectionVw {
            return self.viewModel.arrayStoreList.count
        } else {
            return self.viewModel.arrayServiceList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == main_BannerCollectionVw {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as! BannerCell
            let obj = viewModel.arrayBannerList[indexPath.row]
            
            if Router.BASE_IMAGE_URL != obj.image {
                Utility.setImageWithSDWebImage(obj.image ?? "", cell.banner_Img)
            } else {
                cell.banner_Img.image = R.image.no_Image_Available()
            }
            
            return cell
        } else if collectionView == recommendedShops_CollectionVw {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ServiceCell", for: indexPath) as! ServiceCell
            let obj = viewModel.arrayStoreList[indexPath.row]
            
            cell.mainVw.cornerRadius = 0
            cell.mainVw.shadowRadius = 0
            cell.lbl_ServiceName.isHidden = true
            
            if Router.BASE_IMAGE_URL != obj.provider_logo {
                Utility.setImageWithSDWebImage(obj.provider_logo ?? "", cell.service_Img)
            } else {
                cell.service_Img.image = R.image.no_Image_Available()
            }
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ServiceCell", for: indexPath) as! ServiceCell
            let obj = viewModel.arrayServiceList[indexPath.row]
            cell.mainVw.cornerRadius = 10
            cell.service_Img.roundCorners(corners: [.allCorners], radius: 10)
//            cell.lbl_ServiceName.text = L102Language.currentAppleLanguage() == "en" ? obj.category_name ?? "" : obj.category_name_ar ?? ""
            cell.lbl_ServiceName.isHidden = true
            if Router.BASE_IMAGE_URL != obj.image {
                Utility.setImageWithSDWebImage(obj.image ?? "", cell.service_Img)
            } else {
                cell.service_Img.image = R.image.no_Image_Available()
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == main_BannerCollectionVw {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        } else if collectionView == recommendedShops_CollectionVw {
            return CGSize(width: 100, height: collectionView.frame.height - 10)
        } else {
            let height: CGFloat = 150
            let spacing: CGFloat = 5
            
            // First two items - custom width
            if indexPath.item == 0 {
                let width = (collectionView.frame.width - (spacing * 3)) * 0.5 // 55% of total width
                return CGSize(width: width, height: height)
            } else if indexPath.item == 1 {
                let width = (collectionView.frame.width - (spacing * 3)) * 0.5 // 40% of total width
                return CGSize(width: width, height: height)
            } else {
                // Remaining 3 items per row
                let width = (collectionView.frame.width - (spacing * 4)) / 3
                return CGSize(width: width, height: height)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if collectionView == recommendedShops_CollectionVw {
            let obj = viewModel.arrayStoreList[indexPath.row]
            viewModel.navigateToStoreDetailViewController(from: self.navigationController!, providerId: obj.id ?? "")
        } else if collectionView == service_CollectionVw {
            let obj = viewModel.arrayServiceList[indexPath.row]
            if L102Language.currentAppleLanguage() == "en" {
                viewModel.navigateToServiceDetailViewController(from: self.navigationController!, catiD: obj.id ?? "", serviceImg: obj.image ?? "", serviceName: obj.category_name ?? "")
            } else {
                viewModel.navigateToServiceDetailViewController(from: self.navigationController!, catiD: obj.id ?? "", serviceImg: obj.image ?? "", serviceName: obj.category_name_ar ?? "")
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == main_BannerCollectionVw {
            let pageIndex = round(scrollView.contentOffset.x / scrollView.frame.width)
            pageControl.currentPage = Int(pageIndex)
        }
    }
}

extension HomeVC {
    
    func initIndentifier()
    {
        self.service_CollectionVw.register(UINib(nibName: "ServiceCell", bundle: nil),forCellWithReuseIdentifier: "ServiceCell")
        self.main_BannerCollectionVw.register(UINib(nibName: "BannerCell", bundle: nil),forCellWithReuseIdentifier: "BannerCell")
        self.recommendedShops_CollectionVw.register(UINib(nibName: "ServiceCell", bundle: nil), forCellWithReuseIdentifier: "ServiceCell")
    }
}
