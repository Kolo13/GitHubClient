//
//  SplitContainerViewController.swift
//  GitHubClient
//
//  Created by Kori Kolodziejczak on 10/20/14.
//  Copyright (c) 2014 Kori Kolodziejczak. All rights reserved.
//

import UIKit

class SplitContainerViewController: UIViewController, UISplitViewControllerDelegate {
  var userDefaults: NSUserDefaults?
  var firstTimeLogginIn: Bool?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let splitVC = self.childViewControllers.first as UISplitViewController
    splitVC.delegate = self
    
    if NSUserDefaults.standardUserDefaults().objectForKey("OAuth") == nil {
      println("NSUserDef is empty")
      NetworkController.sharedInstance.requestOAuthAccess()
    }
  }

  
  func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController: UIViewController!, ontoPrimaryViewController primaryViewController: UIViewController!) -> Bool {
      return true
  }

}
