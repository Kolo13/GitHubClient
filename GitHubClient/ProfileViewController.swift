//
//  ProfileViewController.swift
//  GitHubClient
//
//  Created by Kori Kolodziejczak on 10/20/14.
//  Copyright (c) 2014 Kori Kolodziejczak. All rights reserved.


import UIKit

class ProfileViewController: UIViewController {
  
  var name: String?
  var userArray = [User]()
  var authenticatedURLSessionConfig : NSURLSession!
  var usersSearchString: String = "https://api.github.com/user"
  

  @IBOutlet weak var login: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()
    
    NetworkController.sharedInstance.fetchGitData(self.usersSearchString, completionHandler: { (data) -> Void in
      self.userArray = User.parseJSONDataIntoTweets(data)!
      NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
        self.login.text = self.userArray[0].avatarURL
      })
    })
  }
}
