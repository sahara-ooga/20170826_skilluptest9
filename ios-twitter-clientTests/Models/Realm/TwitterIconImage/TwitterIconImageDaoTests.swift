//
//  TwitterIconImageDaoTests.swift
//  ios-twitter-client
//
//  Created by OkuderaYuki on 2017/08/26.
//  Copyright © 2017年 Okudera Yuki. All rights reserved.
//

import XCTest
@testable import ios_twitter_client

final class TwitterIconImageDaoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        UTRealm.removeUTDirectory()
    }
    
    override func tearDown() {
        UTRealm.removeUTDirectory()
        super.tearDown()
    }
    
    /// アイコン画像を登録する処理と取得する処理のテスト
    func testAddAndFind() {
        
        TwitterIconImageDao.add(model: dummyModel())
        let addedModel = TwitterIconImageDao.findByID(profileId: "240558470661799936")
        
        XCTAssertNotNil(addedModel)
        XCTAssertEqual(addedModel?.profileId, "240558470661799936")
        XCTAssertEqual(addedModel?.imageData, Data())
    }
    
    // MARK: - private methods
    
    /// TwitterIconImageのダミー
    private func dummyModel() -> TwitterIconImage {
        let model = TwitterIconImage()
        model.profileId = "240558470661799936"
        model.imageData = Data()
        
        return model
    }
}
