//
//  Repo.swift
//  GitHubClient
//
//  Created by Kori Kolodziejczak on 10/21/14.
//  Copyright (c) 2014 Kori Kolodziejczak. All rights reserved.
//

import Foundation

class Repo {
  
  var name: String
  //var description: String
  
  init(repo: NSDictionary) {
    self.name = repo["name"] as String
    //self.description = repo["description"] as String
    
  }
  
  class func parseJSONDataIntoTweets(rawJSONData : NSData) -> [Repo]? {
    var error : NSError?
    var repoArray = [Repo]()
    var repo: Repo
    if let JSONDictionary = NSJSONSerialization.JSONObjectWithData(rawJSONData, options: nil, error: &error) as? NSDictionary {
      if let rawJSONArray = JSONDictionary["items"] as? NSArray {
        for item in rawJSONArray {
          if let tempDictionary = item as? NSDictionary {
            repo = Repo(repo: tempDictionary)
            repoArray.append(repo)
          }
        }
      }
    }
    return repoArray
  }
}
