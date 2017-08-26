//
//  HomeTimelineParamsBuilder.swift
//  ios-twitter-client
//
//  Created by OkuderaYuki on 2017/08/26.
//  Copyright © 2017年 Okudera Yuki. All rights reserved.
//

import Foundation

final class HomeTimelineParamsBuilder {
    
    
    /// ホームタイムライン取得APIのリクエストパラメータを生成する
    ///
    /// - Parameter count: 取得するレコード数
    /// - Returns: リクエストパラメータ
    static func create(count: Int) -> [String: String] {
        var params = [String: String]()
        params["count"] = count.description
        params["trim_user"] = "false"
        
        return params
    }
}
