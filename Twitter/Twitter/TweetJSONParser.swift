//
//  TweetJSONParser.swift
//  Twitter
//
//  Created by Mark Lin on 8/3/15.
//  Copyright (c) 2015 Mark Lin. All rights reserved.
//

import Foundation

class TweetJSONParser{
  class func tweetsFromJSONData(jsonData : NSData) -> [Tweet]?{
    
    var error : NSError?
    if let rootObject = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &error) as? [[String : AnyObject]]
    {
      var tweets = [Tweet]()
      for tweetObject in rootObject{
        if let text = tweetObject["text"] as? String,
        userInfo = tweetObject["user"] as? [String : AnyObject],
        id = tweetObject["id_str"] as? String,
        userName = userInfo["name"] as? String,
        screenName = userInfo["screen_name"] as? String,
        profileImage = userInfo["profile_image_url"] as? String{
          if let retweetedObject = tweetObject["retweeted_status"] as? [String : AnyObject],
          retweetText = retweetedObject["text"] as? String
          {
            if let originalUserDict = retweetedObject["user"] as? [String: AnyObject]{
              if let retweetId = originalUserDict["id_str"] as? String,
                retweetUserName = originalUserDict["name"] as? String{
                  let tweet = Tweet(username: userName, id: id,screen_name: screenName, profileImageURL: profileImage, text: text, retweetObject: retweetedObject, retweetId: retweetId, retweetUser: retweetUserName, quoteUser: nil, quoteText: nil, userProfileImage:nil)
                  tweets.append(tweet)
                  println("retweet")
              }
            }else{
               if let reQuotedObject = tweetObject["quoted_status"] as? [String : AnyObject],
          quoteText = reQuotedObject["text"] as? String
          {
            if let quoteStatusDict = reQuotedObject["user"] as? [String : AnyObject],
            quoteUser = quoteStatusDict["name"] as? String
            {
              let tweet = Tweet(username: userName, id: id,screen_name: screenName, profileImageURL: profileImage, text: text, retweetObject: nil, retweetId: nil, retweetUser: nil, quoteUser: quoteUser,quoteText: quoteText, userProfileImage:nil)
              tweets.append(tweet)

              println("quote")
            }else{
            
              
              
               let tweet = Tweet(username: userName, id: id,screen_name: screenName, profileImageURL: profileImage, text: text, retweetObject: retweetedObject, retweetId: nil, retweetUser: nil, quoteUser: nil, quoteText: nil, userProfileImage:nil)
            tweets.append(tweet)
            println("normal")
            }

           
          }
         
            }
          }
          
          else{
            let tweet = Tweet(username: userName, id: id,screen_name: screenName, profileImageURL: profileImage, text: text, retweetObject: nil, retweetId: nil, retweetUser: nil, quoteUser: nil, quoteText: nil, userProfileImage:nil)
          tweets.append(tweet)
            println("normal")
          }
        }else{
          println("WTF")
      }
      
      
    }
      println("works")
      return tweets
    }
    if let error = error{
      
    }
  println("broke")
  return nil
}
}
