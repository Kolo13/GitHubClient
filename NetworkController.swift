//
//  NetworkController.swift
//  GitHubClient
//
//  Created by Kori Kolodziejczak on 10/20/14.
//  Copyright (c) 2014 Kori Kolodziejczak. All rights reserved.
//

import UIKit
import Foundation

class NetworkController: UIViewController {
  var downloadURL:NSURL?
  var gitUserPicURL: NSURL?
  var imageQueue = NSOperationQueue()
  
  var gitHubUserPic: UIImage?
  
  
  
  
  class var sharedInstance: NetworkController {
    struct Static {
      static var instance: NetworkController?
      static var token: dispatch_once_t = 0
    }
    dispatch_once(&Static.token) {
      Static.instance = NetworkController()
    }
    return Static.instance!
  }
  
  let clientID = "client_id=168b45f8332af3ad6193"
  let clientSecret = "client_secret=0792ca6b688a6dfb0fa1442e2b15c5cbb3858d4c"
  let githubOAuthURL = "https://github.com/login/oauth/authorize?"
  let scope = "scope=user,repo"
  let redirectURL = "redirect_uri=somefancyname://test"
  let gitHubPostURL = "https://github.com/login/oauth/access_token"
  
  //takes user out of app and send them to browser
  func requestOAuthAccess() {
    let url = githubOAuthURL + clientID + "&" + redirectURL + "&" + scope
    UIApplication.sharedApplication().openURL(NSURL(string: url)!)
  } 
  
  func handleOAuthURL(callbackURL: NSURL) {
    
    let query = callbackURL.query
    let components = query?.componentsSeparatedByString("code=")
    let code = components?.last
    
    let urlQuery = clientID + "&" + clientSecret + "&" + "code=\(code!)"
    
    var request = NSMutableURLRequest(URL: NSURL(string: gitHubPostURL)!)
    request.HTTPMethod = "POST"
    var postData = urlQuery.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: true)
    let length = postData!.length
    request.setValue("\(length)", forHTTPHeaderField: "Content-Length")
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.HTTPBody = postData
    let dataTask = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
      if error != nil {
        println("Hello this is an error")

      }else{
        if let httpResponse = response as? NSHTTPURLResponse {
          switch httpResponse.statusCode {
          case 200...204:
            var tokenResponse = NSString(data: data, encoding: NSASCIIStringEncoding)
            //println("token response \(tokenResponse)")
            let fullMessage = tokenResponse!.componentsSeparatedByString("=")
            let  second = fullMessage[1] as String
            let almostToken = second.componentsSeparatedByString("&")
            let finalToken = almostToken[0]
            
            NSUserDefaults.standardUserDefaults().setObject(finalToken, forKey: "OAuth")
            NSUserDefaults.standardUserDefaults().synchronize()
              
          default:
            println("status code \(httpResponse)")
            }
          }
        }
      
    })
    dataTask.resume()
  }
  
    override func viewDidLoad() {
      super.viewDidLoad()
      
  }
  
  
    func fetchGitData(searchTerm: String, completionHandler : (rawJSON: NSData) -> Void) {
      
      self.downloadURL = NSURL(string: "\(searchTerm)")
      let gitSession = NSURLSession.sharedSession()
      let request = NSMutableURLRequest(URL: self.downloadURL!)
      let token = NSUserDefaults.standardUserDefaults().objectForKey("OAuth") as String
      
      request.setValue("token" + token, forHTTPHeaderField: "Authorization")
      
      let gitTask = gitSession.dataTaskWithURL(self.downloadURL!, completionHandler: {(data, response, error) -> Void in
        var JSONerr: NSError?

        if let httpResponse = response as? NSHTTPURLResponse  {
          switch httpResponse.statusCode {
            case 200...299:
              completionHandler(rawJSON: data)
              println("This is good")
            case 400...499:
              println("Client error")
            case 500...599:
              println("Server fault")
            default:
              println("Something")
          }
        }
      })
      gitTask.resume()
    }

    
    func downloadUserAvatar(user : User, completionHandler : (image : UIImage) -> (Void)) {
      
      self.imageQueue.addOperationWithBlock { () -> Void in
        let url = NSURL(string: user.avatarURL)
        let imageData = NSData(contentsOfURL: url!) //network call
        let avatarImage = UIImage(data: imageData!)
        user.avatarImage = avatarImage
        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
          completionHandler(image: avatarImage!)
        })
      
      }
    }


}