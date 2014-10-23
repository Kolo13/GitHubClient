//

//  RepositoryViewController.swift
//  GitHubClient
//
//  Created by Kori Kolodziejczak on 10/20/14.
//  Copyright (c) 2014 Kori Kolodziejczak. All rights reserved.
//

import UIKit

class RepositoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate, UISearchDisplayDelegate {
  
  var reposSearchString:String = "https://api.github.com/search/repositories?q="
  var repo: Repo?
  var repoArray = [Repo]()

  var repoDescription: String?

  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var searchBar: UISearchBar!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    //NetworkController = appDelegate.networkController
    //NetworkController.sharedInstance.requestOAuthAccess()
  }
  
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
   self.reposSearchString = self.reposSearchString +
    searchBar.text
    NetworkController.sharedInstance.fetchGitData(self.reposSearchString, completionHandler: { (data) -> Void in
      var tempArray = Repo.parseJSONDataIntoTweets(data)
      self.repoArray = tempArray!
      NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
        self.repoArray = tempArray!
        self.tableView.reloadData()
      })
    })
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return repoArray.count
  }
  
  
  
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("CELL", forIndexPath: indexPath) as UITableViewCell
    cell.textLabel.text = self.repoArray[indexPath.row].name
    
    return cell
    }
  }
