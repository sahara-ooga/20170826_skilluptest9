//
//  TwitterIconImageDao.swift
//  ios-twitter-client
//
//  Created by OkuderaYuki on 2017/08/26.
//  Copyright © 2017年 Okudera Yuki. All rights reserved.
//

import RealmSwift

final class TwitterIconImageDao {
    
    static let dao = RealmDaoHelper<TwitterIconImage>()
    
    // MARK: - find
    
    /// アイコン画像を取得する
    ///
    /// - Parameter profileId: プロフィールID
    /// - Returns: アイコン画像の情報
    static func findByID(profileId: String) -> TwitterIconImage? {
        guard let object = dao.findFirst(key: profileId as AnyObject) else { return nil }
        return TwitterIconImage(value: object)
    }
    
    // MARK: - add
    
    /// アイコン画像を登録する
    ///
    /// - Parameter model: アイコン画像の情報
    static func add(model: TwitterIconImage) {
        
        // 登録済みであればreturn
        if let _ = findByID(profileId: model.profileId) { return }
        
        let newObject = TwitterIconImage()
        newObject.profileId = model.profileId
        newObject.imageData = model.imageData
        dao.add(d: newObject)
    }
}

