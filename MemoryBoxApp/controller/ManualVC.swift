//
//  ManualVC.swift
//  MemoryBoxApp
//
//  Created by Upma  Sharma on 2019-12-11.
//  Copyright © 2019 Upma  Sharma. All rights reserved.
//

import UIKit
import WebKit

class ManualVC : UIViewController, WKUIDelegate {
    // Outlets
    @IBOutlet var webView : WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = Bundle.main.url(forResource: "AppManual", withExtension: ".html")
        let requestObj = URLRequest(url: url!);
        webView.load(requestObj);
    }
        
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
}
