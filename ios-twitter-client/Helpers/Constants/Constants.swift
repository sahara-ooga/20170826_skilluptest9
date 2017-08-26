//
//  Constants.swift
//  ios-twitter-client
//
//  Created by OkuderaYuki on 2017/08/26.
//  Copyright © 2017年 Okudera Yuki. All rights reserved.
//

import Foundation

/// 定数
enum Constants {
    
    /// リクエストパラメータ
    enum RequestParameter {
        static let homeTimelineRecordCount = 20
    }
    
    /// URLScheme用のURLString
    enum UrlScheme {
        /// 設定/TwitterのURL
        static let twitterSetting = "App-prefs:root=TWITTER"
        
        /// 設定/プライバシー/TwitterのURL
        static let twitterPrivacySetting = "App-Prefs:root=Privacy&path=TWITTER"
    }
}
