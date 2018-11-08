//
//  WebViewController.swift
//  testCaseMovie
//
//  Created by admin on 11/7/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import WebKit
import MBProgressHUD

class WebViewController: UIViewController, UIWebViewDelegate  {

    @IBOutlet var webView : UIWebView!
    @IBOutlet var backButton: UIButton!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var homeButton: UIButton!
    @IBOutlet var refreshButton: UIButton!
    var appStoreURL : String = ""
    var otherURL : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        homeButton.tintColor = UIColor.blue
        
        //webView.navigationDelegate = self
        AppDelegate.appDelegate().showLoading()
        if appStoreURL != "" {
            webView.loadRequest(URLRequest(url: URL(string: appStoreURL)!))
            self.navigationController?.isNavigationBarHidden = true
        }
        
        if otherURL != "" {
            webView.loadRequest(URLRequest(url: URL(string: otherURL)!))
            self.navigationController?.isNavigationBarHidden = false
            setUpUI()
        }

        updateToolBar()
        // Do any additional setup after loading the view.
    }
    
    func setUpUI(){
        self.navigationController?.navigationBar.barTintColor = UIColor(rgb: 0x273446)
        self.navigationController?.navigationBar.topItem?.title = "About us"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.addLeftIcon()
    }
    
    func addLeftIcon(){
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu_icon")!.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(menuAction))
    }
    
    @objc func menuAction(){
        self.sideMenuViewController.presentLeftMenuViewController()
    }

    func updateToolBar(){
        backButton.isEnabled = webView.canGoBack
        nextButton.isEnabled = webView.canGoForward
    }
    
    @IBAction func homeButtonAction(){
        if appStoreURL != "" {
            webView.loadRequest(URLRequest(url: URL(string: appStoreURL)!))
            self.navigationController?.isNavigationBarHidden = true
        }
        
        if otherURL != "" {
            webView.loadRequest(URLRequest(url: URL(string: otherURL)!))
            self.navigationController?.isNavigationBarHidden = false
        }
        updateToolBar()
    }
    
    @IBAction func nextButtonAction(){
        webView.goForward()
        updateToolBar()
        backButton.isEnabled = true
    }
    
    @IBAction func backButtonAction(){
        webView.goBack()
        updateToolBar()
        nextButton.isEnabled = true
    }
    
    @IBAction func refreshButtonAction(){
        webView.reload()
        updateToolBar()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        updateToolBar()
        AppDelegate.appDelegate().hideLoading()
    }
}
