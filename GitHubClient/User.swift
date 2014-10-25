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
  
  
  init(user: NSDictionary) {
    self.login = user["login"] as String
    self.avatarURL = user["avatar_url"] as String
  }
  
  class func parseJSONDataIntoTweets(rawJSONData : NSData) -> [User]? {
    var error : NSError?
    var userArray = [User]()
    var user: User
    if let JSONDictionary = NSJSONSerialization.JSONObjectWithData(rawJSONData, options: nil, error: &error) as? NSDictionary {
      if let rawJSONArray = JSONDictionary["items"] as? NSArray {
        for item in rawJSONArray {
          if let tempDictionary = item as? NSDictionary {
            user = User(user: tempDictionary)
            userArray.append(user)
          }
        }
      }else{
        println("Parsing started")
        if let JSONDictionary = NSJSONSerialization.JSONObjectWithData(rawJSONData, options: nil, error: &error) as? NSDictionary {
          user = User(user: JSONDictionary)
          userArray.append(user)
        }
      }
    }
      return userArray
  }
}