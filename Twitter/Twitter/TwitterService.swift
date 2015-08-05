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
      
      } else {println(response.statusCode)
        let tweets = TweetJSONParser.tweetsFromJSONData(data)
        completionHandler(nil,tweets)
    }

    })
  }
}
