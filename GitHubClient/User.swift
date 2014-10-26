//
//  User.swift
//  GitHubClient
//
//  Created by Kori Kolodziejczak on 10/22/14.
//  Copyright (c) 2014 Kori Kolodziejczak. All rights reserved.
//

import Foundation
import UIKit

class User {
  
  var login: String
  var avatarURL: String
  var avatarImage: UIImage?
  
  var bio: String?
  var hireable: String?
  var public_repos: Int?
  var owned_private_repos: Int?
  
  init(user: NSDictionary) {
    self.login = user["login"] as String
    self.avatarURL = user["avatar_url"] as String
  }
  
  class func parseJSONDataIntoTweets(rawJSONData : NSData) -> [User] {
    var error : NSError?
    var userArray = [User]()
    var user: User
  
    if let JSONDictionary = NSJSONSerialization.JSONObjectWithData(rawJSONData, options: nil, error: &error) as? NSDictionary {
      if let JSONArray = JSONDictionary["items"] as? NSArray {
        for item in JSONArray {
          if let tempDictionary = item as? NSDictionary {
            user = User(user: tempDictionary)
            userArray.append(user)
          }
        }
      }else{
        user = User(user: JSONDictionary)
        user.bio = JSONDictionary["bio"] as? String
        user.hireable = JSONDictionary["hireable"] as? String
        user.public_repos = JSONDictionary["public_repos"] as? Int
        user.owned_private_repos = JSONDictionary["owned_private_repos"] as? Int
        userArray.append(user)
      }
    }
      return userArray
  }
}