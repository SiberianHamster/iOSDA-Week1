//
//  ViewController.swift
//  Twitter
//
//  Created by Mark Lin on 8/3/15.
//  Copyright (c) 2015 Mark Lin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  var tweets = [Tweet]()
  
  lazy var imageQueue = NSOperationQueue()
  

  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    LoginSevices.loginForTwitter { (errorDescription, account) -> (Void) in
      if let errorDescription = errorDescription {
        println("error occured")
      }
      if let account = account {TwitterService.tweetsFromHomeTimeline(account, completionHandler: { (errorDescription, tweets) -> (Void) in
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
extension ViewController: UITableViewDataSource{
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tweets.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetTableViewCell
    let tweet = tweets[indexPath.row]
    cell.tweetTextLabel?.text = tweet.text
    return cell
  }
  
  
}
