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
  
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var searchBar: UISearchBar!
 
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    }

  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
   self.usersSearchString = self.usersSearchString + searchBar.text
    NetworkController.sharedInstance.fetchGitData(self.usersSearchString, completionHandler: { (data) -> Void in
      var tempArray = User.parseJSONDataIntoTweets(data)
      //      self.userArray = tempArray!
      NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
        self.userArray = tempArray!
        self.collectionView.reloadData()
      })
    })
  }

  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.userArray.count
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("USERS_CELL", forIndexPath: indexPath) as UserCollectionViewCell
    let user = self.userArray[indexPath.row]
    
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
  


}
