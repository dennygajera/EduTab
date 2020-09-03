//
//  ProductInfoVC.swift
//  Edutab
//
//  Created by Darshan on 03/09/20.
//  Copyright © 2020 Chirag Bhojani. All rights reserved.
//

import UIKit
import WebKit
class ProductInfoVC: UIViewController {

    @IBOutlet var webView: WKWebView!
    @IBOutlet var btnBack: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlId = AppPrefsManager.sharedInstance.getProductURL()!
        let url = URL(string: "https://www.youtube.com/embed/\(urlId)")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    @IBAction func btnBackClick(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
}
