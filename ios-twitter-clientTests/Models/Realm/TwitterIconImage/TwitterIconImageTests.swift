//
//  TwitterIconImageTests.swift
//  ios-twitter-client
//
//  Created by OkuderaYuki on 2017/08/26.
//  Copyright © 2017年 Okudera Yuki. All rights reserved.
//

import XCTest
@testable import ios_twitter_client

final class TwitterIconImageTests: XCTestCase {
    
    /// 初期化のテスト
    func testInit() {
        // Exercise
        let twitterIconImage = TwitterIconImage()
        
        // Verify
        XCTAssertEqual(twitterIconImage.profileId, "")
        XCTAssertEqual(twitterIconImage.imageData, nil)
    }
    
    /// プライマリキーを確認するテスト
    func testPrimaryKey() {
        // Verify
        XCTAssertEqual(TwitterIconImage.primaryKey(), "profileId")
    }
}

