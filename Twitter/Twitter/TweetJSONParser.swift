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
          profileImage = userInfo["profile_image_url"] as? String{

            let tweet = Tweet(username: userName, id: id, profileImageURL: profileImage, text: text)
          tweets.append(tweet)
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
