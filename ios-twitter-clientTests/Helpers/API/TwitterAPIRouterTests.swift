//
//  TwitterAPIRouterTests.swift
//  ios-twitter-client
//
//  Created by OkuderaYuki on 2017/08/26.
//  Copyright © 2017年 Okudera Yuki. All rights reserved.
//

import XCTest
@testable import ios_twitter_client

final class TwitterAPIRouterTests: XCTestCase {
    
    var parameters: [String: String]?
    var router: TwitterAPIRouter?
    
    override func setUp() {
        super.setUp()
        
        parameters = HomeTimelineParamsBuilder
            .create(count:Constants.RequestParameter.homeTimelineRecordCount)
        guard let parameters = parameters else {
            XCTFail("ホームタイムライン取得APIのリクエストパラメータ生成失敗")
            return
        }
        router = TwitterAPIRouter.homeTimeline(parameters: parameters)
    }
    
    /// リクエストパラメータを確認するテスト
    func testParameters() {
        
        guard let router = router else {
            XCTFail("TwitterAPIRouterがnil")
            return
        }
        
        // Exercise
        let routerParameters = router.parameters() as? [String: String]
        
        // Verify
        XCTAssertEqual(routerParameters?.count, 2)
        
        XCTAssertEqual(routerParameters?["count"], "20")
        XCTAssertEqual(routerParameters?["trim_user"], "false")
    }
    
    /// リクエストメソッドを確認するテスト
    func testRequestMethod() {
        
        // Verify
        XCTAssertEqual(router?.requestMethod(), .GET)
    }
    
    /// URLを確認するテスト
    func testUrlString() {
        
        // Verify
        XCTAssertEqual(router?.urlString(),
                       "https://api.twitter.com/1.1/statuses/home_timeline.json")
    }
}
