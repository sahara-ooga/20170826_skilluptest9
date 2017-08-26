//
//  APIClient.swift
//  ios-twitter-client
//
//  Created by OkuderaYuki on 2017/08/26.
//  Copyright © 2017年 Okudera Yuki. All rights reserved.
//

import Accounts
import Social

/// TwitterAPIリクエスト結果
///
/// - success: 成功: jsonStringを返却
/// - failure: 失敗: Errorオブジェクトを返却
enum TwitterAPIResult {
    case success(String)
    case failure(Error)
}

final class APIClient {
    
    /// TwitterAPIリクエスト
    ///
    /// - Parameters:
    ///   - account: Twitterアカウント
    ///   - router: TwitterAPIのエンドポイントを管理するenum
    ///   - completion: レスポンス取得後の処理
    static func twitterAPIRequest(with account: ACAccount,
                                  router: TwitterAPIRouter,
                                  completion: @escaping (TwitterAPIResult) -> Void) {
        
        let slRequest = SLRequest(forServiceType: SLServiceTypeTwitter,
                                  requestMethod: router.requestMethod(),
                                  url: URL(string: router.urlString()),
                                  parameters: router.parameters())
        
        slRequest?.account = account
        slRequest?.perform { responseData, _, error in
            
            if let error = error {
                Logger.error(message: "error code: \(error.code)")
                Logger.error(message: "error domain: \(error.domain)")
                completion(.failure(error))
                return
            }
            
            if let responseData = responseData,
                let jsonString = String(data: responseData, encoding: .utf8) {
                completion(.success(jsonString))
                return
            }
            fatalError(" エラーオブジェクトもレスポンスオブジェクトもnil")
        }
    }
}
