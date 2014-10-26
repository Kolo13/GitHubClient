//

//  RepositoryViewController.swift
//  GitHubClient
//
//  Created by Kori Kolodziejczak on 10/20/14.
//  Copyright (c) 2014 Kori Kolodziejczak. All rights reserved.
//

import UIKit

class RepositoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate, UINavigationControllerDelegate {
  
  var reposSearchString:String = "https://api.github.com/search/repositories?q="
  var repo: Repo?
  var repoArray = [Repo]()

  var repoDescription: String?

  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var searchBar: UISearchBar!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
   self.reposSearchString = self.reposSearchString + searchBar.text
    NetworkController.sharedInstance.fetchGitData(self.reposSearchString, completionHandler: { (data) -> Void in
      self.repoArray = Repo.parseJSONDataIntoTweets(data)!
      NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
        self.tableView.reloadData()
      })
    })
  }
  
  func searchBar(searchBar: UISearchBar, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
    return text.validate()
    
  }

 
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return repoArray.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("CELL", forIndexPath: indexPath) as UITableViewCell
    cell.textLabel.text = self.repoArray[indexPath.row].name
    
    return cell
  }

  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let viewController = storyboard?.instantiateViewControllerWithIdentifier("WEB_VC") as WebViewController
    viewController.repoURL = self.repoArray[indexPath.row].url
    
    // Trigger a normal push animations; let navigation controller take over.
    self.navigationController?.pushViewController(viewController, animated: true)
  }


}

