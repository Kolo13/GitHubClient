//
//  SplitContainerViewController.swift
//  GitHubClient
//
//  Created by Kori Kolodziejczak on 10/20/14.
//  Copyright (c) 2014 Kori Kolodziejczak. All rights reserved.
//

import UIKit

class SplitContainerViewController: UIViewController, UISplitViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
      let splitVC = self.childViewControllers[0] as UISplitViewController
      splitVC.delegate = self
      
      
      
      
      
      
      
      
      
      
      if NSUserDefaults.standardUserDefaults().objectForKey("OAuth") == nil {
        println("NSUserDef is empty")
        NetworkController.sharedInstance.requestOAuthAccess()
      }else{
      }
      
  }


  func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController: UIViewController!, ontoPrimaryViewController primaryViewController: UIViewController!) -> Bool {
    return true
  }

}
