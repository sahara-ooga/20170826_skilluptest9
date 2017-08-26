//
//  HomeTimelineCellTests.swift
//  ios-twitter-client
//
//  Created by OkuderaYuki on 2017/08/26.
//  Copyright © 2017年 Okudera Yuki. All rights reserved.
//

import XCTest
import STV_Extensions
import ObjectMapper
@testable import ios_twitter_client

final class HomeTimelineCellTests: XCTestCase {
    
    let dataSource = FakeDataSource()
    var tableView: UITableView!
    var cell: HomeTimelineCell!
    
    override func setUp() {
        super.setUp()
        
        guard let homeTimelineVC = UIStoryboard.viewController(
            storyboardName: "HomeTimelineViewController",
            identifier: "HomeTimelineViewController") as? HomeTimelineViewController else {
                XCTFail("HomeTimelineViewControllerのインスタンス生成失敗")
                return
        }
        homeTimelineVC.loadView()
        
        tableView = homeTimelineVC.tableView
        tableView.dataSource = dataSource
        
        cell = tableView?.dequeueReusableCell(withIdentifier: HomeTimelineCell.identifier,
                                              for: IndexPath(row: 0, section: 0)) as! HomeTimelineCell
    }
    
    /// HomeTimelineCell上のラベルの文言を確認するテスト
    func testSetTweet() {
        // Setup
        let tweet = Mapper<HomeTimelineTweet>().map(JSON: DummyResponse.homeTimeline)
        
        // Exercise
        cell.tweet = tweet
        
        // Verify
        XCTAssertEqual(cell.userNameLabel.text, "OAuth Dancer")
        XCTAssertEqual(cell.userScreenNameLabel.text, "oauth_dancer")
        XCTAssertEqual(cell.tweetLabel.text, "just another test")
    }
}

extension HomeTimelineCellTests {
    
    final class FakeDataSource: NSObject, UITableViewDataSource {
        
        func tableView(_ tableView: UITableView,
                       numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView,
                       cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
        }
    }
}
