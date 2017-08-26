//
//  HomeTimelineTweetTests.swift
//  ios-twitter-client
//
//  Created by OkuderaYuki on 2017/08/26.
//  Copyright © 2017年 Okudera Yuki. All rights reserved.
//

import XCTest
import ObjectMapper
@testable import ios_twitter_client

final class HomeTimelineTweetTests: XCTestCase {
    
    /// ホームタイムライン取得APIレスポンスをマッピングするテスト
    func testHomeTimelineTweetMapping() {
        
        // Exercise
        let tweet = Mapper<HomeTimelineTweet>().map(JSON: DummyResponse.homeTimeline)
        
        // Verify
        XCTAssertEqual(tweet?.id, "240558470661799936")
        XCTAssertEqual(tweet?.name, "OAuth Dancer")
        XCTAssertEqual(tweet?.screenName, "oauth_dancer")
        XCTAssertEqual(tweet?.profileImageUrl, "https://si0.twimg.com/profile_images/730275945/oauth-dancer_normal.jpg")
        XCTAssertEqual(tweet?.text, "just another test")
    }
}
