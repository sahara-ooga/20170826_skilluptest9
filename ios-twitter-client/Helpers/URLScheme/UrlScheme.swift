//
//  UrlScheme.swift
//  ios-twitter-client
//
//  Created by OkuderaYuki on 2017/08/26.
//  Copyright © 2017年 Okudera Yuki. All rights reserved.
//

import UIKit

/// カスタムURLスキーム
final class UrlScheme {
    
    /// URLStringを指定して、URLSchemeでアプリを開く
    ///
    /// - Parameter urlString: URLString
    static func open(with urlString: String) {
        guard let url = URL(string: urlString) else {
            Logger.error(message: "Failed to create URL from string.\n->\(urlString)")
            return
        }
        if UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}
