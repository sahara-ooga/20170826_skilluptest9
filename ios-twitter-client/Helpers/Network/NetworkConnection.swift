//
//  NetworkConnection.swift
//  ios-twitter-client
//
//  Created by OkuderaYuki on 2017/08/26.
//  Copyright © 2017年 Okudera Yuki. All rights reserved.
//

import ReachabilitySwift

final class NetworkConnection {
    
    /// ネットワーク接続状況確認
    ///
    /// - Returns: true: オンライン, false: オフライン
    static func isReachable() -> Bool {
        return Reachability()?.isReachable ?? false
    }
}
