//
//  ViewController.swift
//  GitHubClient
//
//  Created by Kori Kolodziejczak on 10/20/14.
//  Copyright (c) 2014 Kori Kolodziejczak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  var appNetworkController = NetworkController()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    self.appNetworkController = appDelegate.networkController
    self.appNetworkController.requestOAuthAccess()
  
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

