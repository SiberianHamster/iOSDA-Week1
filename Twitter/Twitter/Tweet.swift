//
//  Tweet.swift
//  Twitter
//
//  Created by Mark Lin on 8/3/15.
//  Copyright (c) 2015 Mark Lin. All rights reserved.
//

import UIKit

struct Tweet {
  let username : String
  let id : String
  let screen_name : String
  let profileImageURL : String
  let text : String
  let retweetObject : [String : AnyObject]?
  let retweetId : String?
  let retweetUser : String?
  let quoteUser : String?
  let quoteText : String?
  var userProfileImage : UIImage?
}