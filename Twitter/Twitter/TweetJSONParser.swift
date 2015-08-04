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
    
    if let rootObject = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &error) as? [[String : AnyObject]],
    data = rootObject[]
    {
      
      
    }

  return nil
}
}