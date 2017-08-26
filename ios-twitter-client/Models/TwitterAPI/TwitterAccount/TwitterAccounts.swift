//
//  TwitterAccounts.swift
//  ios-twitter-client
//
//  Created by OkuderaYuki on 2017/08/26.
//  Copyright © 2017年 Okudera Yuki. All rights reserved.
//

import Accounts

/// 端末に登録されているTwitterアカウントの取得結果をVCに通知するデリゲート
protocol TwitterAccountsDelegate: class {
    
    /// 端末に登録されているTwitterアカウント取得成功時の処理
    ///
    /// - Parameter accounts: 端末に登録されているTwitterアカウントの配列
    func didLoad(accounts: [ACAccount])
    
    /// 端末に登録されているTwitterアカウント取得失敗時の処理
    ///
    /// - Parameters:
    ///   - errorMessage: エラーメッセージ
    func didFailLoad(errorMessage: String)
}

final class TwitterAccounts {
    
    weak var delegate: TwitterAccountsDelegate?
    
    /// 端末に登録されているTwitterアカウントの情報を取得する
    func loadRegisteredAccounts() {
        
        let accountStore = ACAccountStore()
        let accountType = accountStore.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter)
        
        // Twitterアカウントの利用要求
        accountStore.requestAccessToAccounts(with: accountType, options: nil) { [weak self] granted, error in
            
            guard let `self` = self else { return }
            
            if let error = error {
                Logger.error(message: "error code: \(error.code)\ndomain: \(error.domain)")
                self.delegate?.didFailLoad(errorMessage: error.localizedDescription)
                return
            }
            
            if !granted {
                self.delegate?.didFailLoad(errorMessage: "notAuthorizedTwitterAccount".localized())
                return
            }
            
            guard let accounts = accountStore.accounts(with: accountType) as? [ACAccount] else {
                self.delegate?.didFailLoad(errorMessage: "failedAccessTwitterAccount".localized())
                return
            }
            
            Logger.debug(message: "アカウント取得完了(\(accounts.count)件)")
            self.delegate?.didLoad(accounts: accounts)
        }
    }
}
