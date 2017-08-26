//
//  TwitterIconImage.swift
//  ios-twitter-client
//
//  Created by OkuderaYuki on 2017/08/26.
//  Copyright © 2017年 Okudera Yuki. All rights reserved.
//

import RealmSwift

final class TwitterIconImage: Object {
    
    dynamic var profileId = ""
    dynamic var imageData: Data?
    
    override static func primaryKey() -> String? {
        return "profileId"
    }
}
