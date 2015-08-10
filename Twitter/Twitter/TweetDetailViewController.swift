//
//  TweetDetailViewController.swift
//  Twitter
//
//  Created by Mark Lin on 8/5/15.
//  Copyright (c) 2015 Mark Lin. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {
  
  @IBOutlet weak var qName: UILabel!
  
  @IBOutlet weak var qText: UILabel!
  
  @IBOutlet weak var detailedTextLabel: UILabel!
  
  @IBOutlet weak var detailedIDLabel: UILabel!
  
  @IBOutlet weak var detailedUserLabel: UILabel!
  
  @IBOutlet weak var userButtonImage: UIButton!
  
  var selectedTweet : Tweet!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      self.detailedTextLabel.text = selectedTweet.text
      self.detailedUserLabel.text = selectedTweet.username
      self.detailedIDLabel.text=selectedTweet.id
      self.userButtonImage.setBackgroundImage(self.selectedTweet.userProfileImage, forState: UIControlState.Normal)
      if let retweetObject = selectedTweet.retweetObject{
        let retweetText = selectedTweet.retweetObject?["text"] as! String
        self.detailedTextLabel.text = retweetText
        
        if let originalTweetUser = selectedTweet.retweetUser{
          self.detailedUserLabel.text = originalTweetUser
        }
        
        }
      else{
        if let quotedText = selectedTweet.quoteText,
        quotedName = selectedTweet.quoteUser
        {self.qText.text = quotedText
          self.qName.text = quotedName
        }
      }
      }

}

extension TweetDetailViewController : UINavigationControllerDelegate{

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "userSeg"{
      let segNorm = segue.destinationViewController as! UserViewController
      segNorm.selectedTweet = selectedTweet
  }
  
}
}
