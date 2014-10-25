//
//  WebViewController.swift
//  GitHubClient
//
//  Created by Kori Kolodziejczak on 10/24/14.
//  Copyright (c) 2014 Kori Kolodziejczak. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

  let webView = WKWebView()
  var repoURL: String?

  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.webView.loadRequest(NSURLRequest(URL: NSURL(string: self.repoURL!)!))
  }
  
  override func loadView() {
    self.view = webView
  }
  
}
