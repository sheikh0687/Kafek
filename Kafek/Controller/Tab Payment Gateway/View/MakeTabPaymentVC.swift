//
//  MakeTabPaymentVC.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 22/04/25.
//

import UIKit
import WebKit

class MakeTabPaymentVC: UIViewController {
    
    @IBOutlet weak var webVw: WKWebView!
    @IBOutlet weak var lbl_Headline: UILabel!
    
    let viewModel = MakeTabPaymentViewModel()
    
    let firstName = (k.userDefault.value(forKey: k.session.userName) as? String ?? "").components(separatedBy: " ").first ?? ""
    let lastName = (k.userDefault.value(forKey: k.session.userName) as? String ?? "").components(separatedBy: " ").last ?? ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        callWebView(orderId: k.userDefault.value(forKey: k.session.userId) as! String,
                    amount: viewModel.tabPayAmt,
                    currency: "SAR",
                    firstName: firstName.components(separatedBy: " ").first ?? "",
                    lastName: lastName.components(separatedBy: " ").last ?? "",
                    email: k.userDefault.value(forKey: k.session.userEmail) as! String)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        self.lbl_Headline.text = R.string.localizable.makePayment()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func btn_BackTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func callWebView(orderId: String, amount: String, currency: String, firstName: String, lastName: String, email: String) {
        
        let queryParams = "order_id=\(orderId)&amount=\(amount)&currency=\(currency)&first_name=\(firstName)&last_name=\(lastName)&email=\(email)"
        
        // Combine the base URL with query parameters
        let fullUrlStr = "\(Router.checkout.url())?\(queryParams)"
        
        // Percent encode the URL string to safely handle special characters
        guard let encodedUrlStr = fullUrlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: encodedUrlStr) else {
            print("Invalid URL: \(fullUrlStr)")
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        // Show the loader and load the WebView
        CustomLoader.showCustomLoader()
        self.webVw.navigationDelegate = self
        print("Loading URL: \(url)")
        self.webVw.load(urlRequest)
    }
    
    func bindViewModel() {
        viewModel.onPaymentSuccess = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                let vC = R.storyboard.main().instantiateViewController(withIdentifier: "WalletSuccessPopUp") as! WalletSuccessPopUp
                vC.cloSuccessPopUp = {
                    self.navigationController?.popViewController(animated: true)
                }
                vC.modalTransitionStyle = .crossDissolve
                vC.modalPresentationStyle = .overFullScreen
                self.present(vC, animated: true)
            }
        }
        
        viewModel.onPaymentFailure = { [weak self] message in
            guard let self = self else { return }
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                self.present(alert, animated: true)
            }
        }
    }
}

extension MakeTabPaymentVC: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        CustomLoader.hideCustomLoader()
        print("Finished loading webview")
        
        if let currentURL = webView.url?.absoluteString {
            print("Current URL: \(currentURL)")
            
            if currentURL.contains("webservice/redirect") {
                webView.evaluateJavaScript("document.body.innerText") { [weak self] result, error in
                    guard let self = self else { return }
                    if let jsonString = result as? String {
                        self.viewModel.handleRedirectResponse(jsonString: jsonString, vC: self)
                    } else if let error = error {
                        self.viewModel.onPaymentFailure?("JavaScript Error: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
}

