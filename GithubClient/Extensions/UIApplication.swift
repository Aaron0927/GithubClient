//
//  UIApplication.swift
//  GithubClient
//
//  Created by kim on 2025/3/12.
//

import UIKit

extension UIApplication {
    /// 获取当前key Window
    var keyWindow: UIWindow? {
        return connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first(where: { $0.isKeyWindow })
    }
}
