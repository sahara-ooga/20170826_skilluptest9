//
//  Error+NSError.swift
//  ios-twitter-client
//
//  Created by OkuderaYuki on 2017/08/26.
//  Copyright © 2017年 Okudera Yuki. All rights reserved.
//

import Foundation

extension Error {
    
    var code: Int {
        return (self as NSError).code
    }
    
    var domain: String {
        return (self as NSError).domain
    }
}
