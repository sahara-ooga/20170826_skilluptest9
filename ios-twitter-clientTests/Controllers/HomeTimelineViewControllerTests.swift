//
//  HomeTimelineViewControllerTests.swift
//  ios-twitter-client
//
//  Created by OkuderaYuki on 2017/08/26.
//  Copyright © 2017年 Okudera Yuki. All rights reserved.
//

import XCTest
import STV_Extensions
@testable import ios_twitter_client

final class HomeTimelineViewControllerTests: XCTestCase {
    
    var homeTimelineVC: HomeTimelineViewController!
    
    override func setUp() {
        super.setUp()
        
        guard let vc = UIStoryboard.viewController(
            storyboardName: "HomeTimelineViewController",
            identifier: "HomeTimelineViewController") as? HomeTimelineViewController else {
                XCTFail("HomeTimelineViewControllerのインスタンス生成失敗")
                return
        }
        homeTimelineVC = vc
        homeTimelineVC.loadView()
    }
    
    /// NavigationBarのタイトルを確認するテスト
    func testNavigationTitle() {
        // Verify
        XCTAssertEqual(homeTimelineVC.navigationItem.title, "タイムライン")
    }
}
