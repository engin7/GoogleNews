//
//  WKWebViewController.swift
//  GoogleNews
//
//  Created by Engin KUK on 17.10.2020.
//

import Foundation
import WebKit

class WKWebViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var url: URL?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        webView.navigationDelegate = self
        webView.load(URLRequest(url: url!))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(pop))
    }
    
    @objc func pop() {
        let transition:CATransition = CATransition()
        transition.duration = 0.6
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromBottom
        self.navigationController?.view.layer.add(transition, forKey: kCATransition)
        self.navigationController?.popViewController(animated: false)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
         DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
         }
    }
    
 }
