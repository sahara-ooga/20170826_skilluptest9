//
//  HomeTimelineAPI.swift
//  ios-twitter-client
//
//  Created by OkuderaYuki on 2017/08/26.
//  Copyright © 2017年 Okudera Yuki. All rights reserved.
//

import Accounts
import Foundation
import ObjectMapper
import STV_Extensions

/// APIステータス
enum HomeTimelineAPIStatus {
    case loading
    case loaded([HomeTimelineTweet])
    case offline
    case timeout
    case error(message: String)
}

/// APIリクエスト結果を通知するプロトコル
protocol HomeTimelineLoadable: class {
    func setResult(result: HomeTimelineAPIStatus)
}

final class HomeTimelineAPI {
    
    weak var loadable: HomeTimelineLoadable?
    
    /// HomeTimelineAPIリクエストをする
    ///
    /// - Parameters:
    ///   - account: Twitterアカウント
    func load(account: ACAccount) {
        
        if !NetworkConnection.isReachable() {
            loadable?.setResult(result: .offline)
            return
        }
        
        let parameters = HomeTimelineParamsBuilder.create(count: Constants.RequestParameter.homeTimelineRecordCount)
        let router = TwitterAPIRouter.homeTimeline(parameters: parameters)
        
        APIClient.twitterAPIRequest(with: account, router: router) { [weak self] result in
            
            switch result {
            case .success(let jsonString):
                if let result = Mapper<HomeTimelineTweet>().mapArray(JSONString: jsonString) {
                    
                    // 成功
                    self?.loadable?.setResult(result: .loaded(result))
                }
                
            case .failure(let error):
                
                if error.code == NSURLErrorTimedOut {
                    // タイムアウト
                    self?.loadable?.setResult(result: .timeout)
                } else {
                    // エラー
                    self?.loadable?.setResult(result: .error(message: error.localizedDescription))
                }
            }
        }
    }
}
