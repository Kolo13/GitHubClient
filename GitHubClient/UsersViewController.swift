//
//  UsersViewController.swift
//  GitHubClient
//
//  Created by Kori Kolodziejczak on 10/20/14.
//  Copyright (c) 2014 Kori Kolodziejczak. All rights reserved.
//
import Foundation
import UIKit

class UsersViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate {
  
  var usersSearchString: String = "https://api.github.com/search/users?q="
  var userArray = [User]()
  var origin: CGRect?
  
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var searchBar: UISearchBar!
 
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    self.navigationController?.delegate = appDelegate

  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
  }
  

  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
   self.usersSearchString = self.usersSearchString + searchBar.text
    NetworkController.sharedInstance.fetchGitData(self.usersSearchString, completionHandler: { (data) -> Void in
      var tempArray = User.parseJSONDataIntoTweets(data)
      NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
        self.userArray = tempArray
        self.collectionView.reloadData()
      })
    })
  }
  func searchBar(searchBar: UISearchBar, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
    return text.validate()

  }

  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.userArray.count
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("USERS_CELL", forIndexPath: indexPath) as UserCollectionViewCell
    let user = self.userArray[indexPath.row]
    cell.loginName.text = self.userArray[indexPath.row].login
    
    
    if user.avatarImage != nil {
      cell.imageView.image = self.userArray[indexPath.row].avatarImage!
    }
    else{
      NetworkController.sharedInstance.downloadUserAvatar(user, completionHandler: { (image) -> (Void) in
        self.userArray[indexPath.row].avatarImage = image
        cell.imageView.image = self.userArray[indexPath.row].avatarImage!
      })
    }
    return cell
  }
  
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    // Grab the attributes of the tapped upon cell
    let attributes = collectionView.layoutAttributesForItemAtIndexPath(indexPath)
    
    // Grab the onscreen rectangle of the tapped upon cell, relative to the collection view
    let origin = self.view.convertRect(attributes!.frame, fromView: collectionView)
    
    // Save our starting location as the tapped upon cells frame
    self.origin = origin
    
    // Find tapped image, initialize next view controller
    let selectedUser = self.userArray[indexPath.row]
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let viewController = storyboard.instantiateViewControllerWithIdentifier("DETAIL_VC") as DetailViewController
    
    // Set image and reverseOrigin properties on next view controller
     viewController.image = selectedUser.avatarImage
     viewController.reverseOrigin = self.origin!
    
    // Trigger a normal push animations; let navigation controller take over.
    self.navigationController?.pushViewController(viewController, animated: true)
  }
  

  
 
  
  
}
