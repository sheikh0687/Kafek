//
//  LandingVC.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 08/08/24.
//

import UIKit

class LandingVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var btnNextOt: UIButton!
    @IBOutlet weak var lbl_Language: UILabel!
    @IBOutlet weak var languagevW: UIView!
    @IBOutlet weak var btn_SkipOt: UIButton!
    @IBOutlet weak var btn_BackOt: UIButton!
    
    let identifier = "LandingCell"
    var currentIndex = 0
    
    let viewModel = LoginViewModel()

    var arrayOfBanners: [Res_OnBoarding] = []
    var isFrom:String = "User"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        
        bingdataWithAdmin()
        
        if L102Language.currentAppleLanguage() == "en" {
            self.lbl_Language.text = "English"
            self.lbl_Language.textAlignment = .left
        } else {
            self.lbl_Language.text = "الإنجليزية"
            self.lbl_Language.textAlignment = .right
        }
        
        if isFrom != "User" {
            self.btn_SkipOt.isHidden = true
            self.languagevW.isHidden = true
            self.btnNextOt.setTitle(R.string.localizable.getStarted(), for: .normal)
            self.pageControl.isHidden = true
            self.btn_BackOt.isHidden = false
        }
    }
    
    deinit {
        print("Deinit Called Free Memory")
//        viewModel.dropDown.selectionAction = nil
    }
    
    @IBAction func btnNext(_ sender: UIButton) {
//        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "WelcomeVC") as! WelcomeVC
//        self.navigationController?.pushViewController(vc, animated: true)

        if isFrom == "User" {
            if self.currentIndex < (self.arrayOfBanners.count - 1) {
                self.currentIndex = self.currentIndex + 1
                self.pageControl.currentPage = self.currentIndex
                print(pageControl.currentPage)
                print(currentIndex)
                print(self.arrayOfBanners.count)
                DispatchQueue.main.async {
                    self.collectionView.isPagingEnabled = false
                    self.collectionView.scrollToItem(at: IndexPath(item: self.currentIndex, section: 0), at: .centeredHorizontally, animated: true
                    )
                    self.collectionView.isPagingEnabled = true
                }
            } else {
                let vC = R.storyboard.main().instantiateViewController(withIdentifier: "WelcomeVC") as! WelcomeVC
                self.navigationController?.pushViewController(vC, animated: true)
            }
        } else {
            let appScheme = "KafakDriverApp://"  // <-- Change this to your actual app's scheme
            
            // 2. App Store URL of the Driver app
            let appStoreURL = "https://apps.apple.com/app/idYOUR_APP_ID"  // <-- Replace YOUR_APP_ID

            if let appUrl = URL(string: appScheme), let storeUrl = URL(string: appStoreURL) {
                if UIApplication.shared.canOpenURL(appUrl) {
                    // Driver app is installed, open it
                    UIApplication.shared.open(appUrl, options: [:], completionHandler: nil)
                } else {
                    // Driver app is not installed, open App Store page
                    UIApplication.shared.open(storeUrl, options: [:], completionHandler: nil)
                }
            }
        }
    }
    
    func switchToWelcomeVC() {
        let welcomeVC = R.storyboard.main().instantiateViewController(withIdentifier: "WelcomeVC")
        let nav = UINavigationController(rootViewController: welcomeVC)
        kAppDelegate.window?.rootViewController = nav
    }
    
    @IBAction func btn_Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSkip(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "WelcomeVC") as! WelcomeVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btn_DropLanguage(_ sender: UIButton) {
        viewModel.configureDropDown(sender: sender, vC: self)
    }
}

extension LandingVC {
    
    func bingdataWithAdmin() {
        
        var paramDict: [String : AnyObject] = [:]
        if isFrom == "User" {
            paramDict["type"] = "USER" as AnyObject
        } else {
            paramDict["type"] = "DRIVER" as AnyObject
        }
        
        print(paramDict)
        
        Api.shared.requestToWelcomeBanner(self, paramDict) { [weak self] responseData in
            guard let self = self else { return }
            if responseData.count > 0 {
                self.arrayOfBanners = responseData
            } else {
                self.arrayOfBanners = []
            }
            self.collectionView.reloadData()
        }
    }
}

extension LandingVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfBanners.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LandingCell", for: indexPath) as! LandingCell
        
        let obj = self.arrayOfBanners[indexPath.row]
        
        if L102Language.currentAppleLanguage() == "en" {
            cell.lbl_Main.text = obj.title ?? ""
            cell.lbl_Sub.text = obj.description ?? ""
        } else {
            cell.lbl_Main.text = obj.title_ar ?? ""
            cell.lbl_Sub.text = obj.description_ar ?? ""
        }
        
        if Router.BASE_IMAGE_URL != obj.image {
            Utility.setImageWithSDWebImage(obj.image ?? "", cell.img)
        } else {
            cell.img.image = R.image.slide_1()
        }
        
        return cell
    }
}

extension LandingVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
}

extension LandingVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.currentIndex = indexPath.row
        self.pageControl.currentPage = indexPath.row
        if indexPath.row == 2 {
            self.btnNextOt.setTitle(R.string.localizable.start(), for: .normal)
        } else {
            self.btnNextOt.setTitle(R.string.localizable.next(), for: .normal)
        }
    }
}
