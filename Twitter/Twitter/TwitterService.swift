//
//  TwitterService.swift
//  Twitter
//
//  Created by Mark Lin on 8/4/15.
//  Copyright (c) 2015 Mark Lin. All rights reserved.
//

import Foundation
import Accounts
import Social

class TwitterService{
  class func tweetsFromHomeTimeline(account : ACAccount, completionHandler : (String?, [Tweet]?) -> (Void)){
    let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: NSURL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json")!, parameters: nil)
    request.account = account
    
    request.performRequestWithHandler({ (data, response, error) -> Void in
      if let error = error {
        println("error")
        completionHandler("could not connect to server", nil)
      
      } else {switch response.statusCode{
      case 200 :
        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
        let tweets = TweetJSONParser.tweetsFromJSONData(data)
        completionHandler(nil,tweets)  
        })
        
        
      case 300 :
        println("no new data")
        let tweets = TweetJSONParser.tweetsFromJSONData(data)
        completionHandler(nil,tweets)
      
      case 400...499 :
        println("A 400s code, sorry we did something wrong.")
        
      case 500...599 :
        println("A 500s code, Something is wrong with Twitter's Server, most likely try again later.")
      
      default: println("something else went wrong and there shoudln't")}
      
      }
      })
}
}