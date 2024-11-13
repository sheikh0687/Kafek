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
    
    let identifier = "LandingCell"
    let viewModel = LandingViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
        self.navigationController?.navigationBar.isHidden = true
    }

    @IBAction func btnNext(_ sender: UIButton) {
        if viewModel.incrementIndex() {
            updateUi()
        } else {
            viewModel.navigateToLoginViewController(from: self.navigationController)
        }
    }
    
    @IBAction func btnSkip(_ sender: UIButton) {
        viewModel.navigateToLoginViewController(from: self.navigationController)
    }
    
    func updateUi()
    {
        let currentIndex = viewModel.currentIndex
        self.pageControl.currentPage = currentIndex
        DispatchQueue.main.async {
            self.collectionView.isPrefetchingEnabled = false
            self.collectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
            self.collectionView.isPagingEnabled = true
        }
    }
}

extension LandingVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.arrayImageList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LandingCell", for: indexPath) as! LandingCell
        
        let slide = viewModel.currentSlide
        
        cell.img.image = slide.images
        cell.lbl_Main.text = slide.mainHeading
        cell.lbl_Sub.text = slide.subHeading
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
        viewModel.updateCurrentIndex(to: indexPath.row)
        self.pageControl.currentPage = indexPath.row
        if indexPath.row == 2 {
            self.btnNextOt.setTitle("Start", for: .normal)
        } else {
            self.btnNextOt.setTitle("Next", for: .normal)
        }
    }
}
