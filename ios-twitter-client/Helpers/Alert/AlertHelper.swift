//
//  AlertHelper.swift
//  ios-twitter-client
//
//  Created by OkuderaYuki on 2017/08/26.
//  Copyright © 2017年 Okudera Yuki. All rights reserved.
//

import UIKit

final class AlertHelper {
    
    static func alert(title: String = "",
                      message: String,
                      rightButtonTitle: String = "ok".localized(),
                      leftButtonTitle: String? = nil,
                      rightButtonAction: ((UIAlertAction) -> Void)? = nil,
                      leftButtonAction: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let positiveAction = UIAlertAction(title: rightButtonTitle, style: .default, handler: rightButtonAction)
        alert.addAction(positiveAction)
        
        if let leftButtonTitle = leftButtonTitle {
            let negativeAction = UIAlertAction(title: leftButtonTitle, style: .cancel, handler: leftButtonAction)
            alert.addAction(negativeAction)
        }
        return alert
    }
}
