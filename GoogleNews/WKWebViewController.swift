//
//  WKWebViewController.swift
//  GoogleNews
//
//  Created by Engin KUK on 17.10.2020.
//

import Foundation
import WebKit

class WKWebViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var url: URL?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.load(URLRequest(url: url!))
    }
    
    
    
}
