//
//  TwitterAPIRouter.swift
//  ios-twitter-client
//
//  Created by OkuderaYuki on 2017/08/26.
//  Copyright © 2017年 Okudera Yuki. All rights reserved.
//

import Social

/// TwitterAPIのエンドポイントを管理するEnum
enum TwitterAPIRouter {
    
    /// ホームタイムラインを取得
    case homeTimeline(parameters: [String: Any])
    
    func parameters() -> [String: Any] {
        
        switch self {
        case .homeTimeline(let params):
            return params
        }
    }
    
    func requestMethod() -> SLRequestMethod {
        
        switch self {
        case .homeTimeline:
            return .GET
        }
    }
    
    func urlString() -> String {
        
        let baseUrlString = "https://api.twitter.com/1.1/"
        
        switch self {
        case .homeTimeline:
            return baseUrlString + "statuses/home_timeline.json"
        }
    }
}
