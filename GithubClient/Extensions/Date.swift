//
//  Date.swift
//  GithubClient
//
//  Created by kim on 2025/4/18.
//

import Foundation

extension Date {
    var relativeDescription: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full // 可选：.abbreviated（3d ago）.short（3 days ago）.full（3 days ago）
        formatter.locale = Locale(identifier: "zh_CN")
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}
