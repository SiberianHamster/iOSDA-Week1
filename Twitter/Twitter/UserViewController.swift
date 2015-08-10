//
//  UserViewController.swift
//  Twitter
//
//  Created by Mark Lin on 8/9/15.
//  Copyright (c) 2015 Mark Lin. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
  
  
  var selectedTweet : Tweet!
  
  var tweets = [Tweet]()
  
  @IBOutlet weak var tableView: UITableView!
  
  lazy var imageQueue = NSOperationQueue()

    override func viewDidLoad() {
        super.viewDidLoad()
      
      var userName = selectedTweet.screen_name
      
      tableView.registerNib(UINib(nibName: "TweetCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "TweetCell")
       
      LoginSevices.loginForTwitter { (errorDescription, account) -> (Void) in
        if let errorDescription = errorDescription {
          println("error occured")
        }
        if let account = account{TwitterService.tweetsFromUserTimeline(account, userName: userName, completionHandler: { (errorDescription, tweets) -> (Void) in
  
          if let tweets = tweets{
            self.tweets = tweets
            self.tableView.reloadData()
            
          }
        })
        }
      }
      
      tableView.dataSource = self
      tableView.reloadData()
      
      
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UserViewController: UITableViewDataSource{
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tweets.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetTableViewCell
    cell.tag++
    let tag = cell.tag
    var tweet = tweets[indexPath.row]
    cell.tweetTextLabel.text = tweet.text
    
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
              tweet.userProfileImage = resizedImage
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
