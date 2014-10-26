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
  @IBOutlet weak var bio: UILabel!
  @IBOutlet weak var publicRepos: UILabel!
  @IBOutlet weak var hireable: UILabel!
  @IBOutlet weak var privateRepos: UILabel!
  override func viewDidLoad() {
    super.viewDidLoad()
    
    NetworkController.sharedInstance.fetchGitData(self.usersSearchString, completionHandler: { (data) -> Void in
      self.userArray = User.parseJSONDataIntoTweets(data)
      
      NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
       self.login.text = self.userArray[0].login
        self.bio.text = self.userArray[0].bio
        self.hireable.text = self.userArray[0].hireable
       self.publicRepos.text = "\(self.userArray[0].public_repos!)"
        self.privateRepos.text = "\(self.userArray[0].owned_private_repos!)"

        
      })
    })
  }
}
