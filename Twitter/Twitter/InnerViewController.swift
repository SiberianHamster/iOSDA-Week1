//
//  ViewController.swift
//  Twitter
//
//  Created by Mark Lin on 8/3/15.
//  Copyright (c) 2015 Mark Lin. All rights reserved.
//

import UIKit

class InnerViewController: UIViewController {
  
  var tweets = [Tweet]()
  
  lazy var imageQueue = NSOperationQueue()
  

  @IBOutlet weak var tableView: UITableView!
  
  var userName : String = ""
  
  override func viewDidLoad() {

    LoginSevices.loginForTwitter{(errorDescription, account) -> (Void) in
      if let errorDescription = errorDescription {
        println("error occured")
      }
      if let account = account {
        TwitterService.tweetsFromUserTimeline(account, userName: self.userName, completionHandler: { (errorDescription, tweets) -> (Void) in

        if let tweets = tweets{
          self.tweets = tweets
          self.tableView.reloadData()
          
        }
      })
      }
    }
    
    super.viewDidLoad()
    tableView.dataSource = self
    tableView.reloadData()
    
    
  }
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "tweetDetailSegue" {
      var segueNorm = segue.destinationViewController as! TweetDetailViewController
      var selectedRow = self.tableView.indexPathForSelectedRow()
      var tweetToPass = self.tweets[selectedRow!.row]
      segueNorm.selectedTweet = tweetToPass
    }
  }
  
  
}


//MARK UITableViewDataSource
extension InnerViewController: UITableViewDataSource{
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tweets.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("innerTweetCell", forIndexPath: indexPath) as! TweetTableViewCell
    cell.tag++
    let tag = cell.tag
    let tweet = tweets[indexPath.row]
    cell.tweetTextLabel?.text = tweet.text
    if let profileImage = tweet.userProfileImage
    {
      
      cell.userButtonImage.setBackgroundImage(profileImage, forState: UIControlState.Normal)
      
      
    } else {
      imageQueue.addOperationWithBlock({ () -> Void in
        if let imageURL = NSURL(string: tweet.profileImageURL),
          imageData = NSData(contentsOfURL: imageURL),
          image = UIImage(data: imageData){
            var size : CGSize
            switch UIScreen.mainScreen().scale{
            case 2:
              size = CGSize(width: 160, height: 160)
            case 3:
              size = CGSize(width: 240, height: 240)
            default:
              size = CGSize(width: 80, height: 80)
            }
            let resizedImage = ImageResizer.resizeImage(image, size: size)
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
              //              tweet.userProfileImage = resizedImage
              self.tweets[indexPath.row] = tweet
              if cell.tag == tag {
                cell.userButtonImage.setBackgroundImage(resizedImage, forState: UIControlState.Normal)
                
              }
            })
        }
      })
    }
    return cell
  }
  
  
}
