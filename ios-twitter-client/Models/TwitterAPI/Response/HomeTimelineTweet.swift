//
//  HomeTimelineTweet.swift
//  ios-twitter-client
//
//  Created by OkuderaYuki on 2017/08/26.
//  Copyright © 2017年 Okudera Yuki. All rights reserved.
//

import ObjectMapper

/// ホームタイムライン取得APIレスポンス
final class HomeTimelineTweet: Mappable {
    
    /// ID
    var id = ""
    /// ユーザ名
    var name = ""
    /// スクリーン名
    var screenName = ""
    /// サムネイル画像のURL
    var profileImageUrl = ""
    /// ツイート文言
    var text = ""
    
    init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["id_str"]
        name <- map["user.name"]
        screenName <- map["user.screen_name"]
        profileImageUrl <- map["user.profile_image_url_https"]
        text <- map["text"]
    }
}
