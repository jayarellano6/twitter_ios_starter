//
//  TweetCell.swift
//  Twitter
//
//  Created by Jay Arellano on 2/12/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var atNameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var retweetCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var favorited:Bool = false
    var tweetId:Int = -1
    var retweeted:Bool = false
    
    func setFavorited(_ isFavorited:Bool){
        favorited = isFavorited
        if(favorited){
            likeButton.setImage(UIImage(named:"favor-icon-red"), for: UIControl.State.normal)
        }else{
            likeButton.setImage(UIImage(named:"favor-icon"), for: UIControl.State.normal)
        }
    }
    
    func setRetweeted(_ isRetweeted:Bool){
        retweeted = isRetweeted
        if(retweeted){
            retweetButton.setImage(UIImage(named:"retweet-icon-green"), for: UIControl.State.normal)
        }else{
            retweetButton.setImage(UIImage(named:"retweet-icon"), for: UIControl.State.normal)
        }
    }
    
    @IBAction func likeTweet(_ sender: Any) {
        let toBeFavorited = !favorited
        if(toBeFavorited){
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, succes: {
                self.setFavorited(true)
            }, failure: { (error) in
                print("like tweet did not succeed")
            })
        }else{
            TwitterAPICaller.client?.unFavoriteTweet(tweetId: tweetId, succes: {
                self.setFavorited(false)
            }, failure: { (error) in
                print("unlike tweet did not succeed")
            })
        }
    }
    
    @IBAction func retweetTweet(_ sender: Any) {
        let toBeRetweeted = !retweeted
        if(toBeRetweeted){
            TwitterAPICaller.client?.retweet(tweetId: tweetId, succes: {
                self.setRetweeted(true)
            }, failure: { (error) in
                print("retweet tweet did not succeed")
            })
        }else{
            TwitterAPICaller.client?.unFavoriteTweet(tweetId: tweetId, succes: {
                self.setRetweeted(false)
            }, failure: { (error) in
                print("unretweet tweet did not succeed")
            })
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
