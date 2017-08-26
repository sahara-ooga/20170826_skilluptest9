//
//  HomeTimelineProvider.swift
//  ios-twitter-client
//
//  Created by OkuderaYuki on 2017/08/26.
//  Copyright © 2017年 Okudera Yuki. All rights reserved.
//

import UIKit
import STV_Extensions

final class HomeTimelineProvider: NSObject {
    
    fileprivate var tweets = [HomeTimelineTweet]()
    
    func set(tweets: [HomeTimelineTweet]) {
        self.tweets = tweets
    }
}

extension HomeTimelineProvider: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTimelineCell.identifier,
                                                 for: indexPath) as! HomeTimelineCell
        cell.profileImageView.image = nil
        cell.tweet = tweets[indexPath.row]
        return cell
    }
}
