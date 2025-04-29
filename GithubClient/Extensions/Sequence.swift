//
//  Sequence.swift
//  GithubClient
//
//  Created by kim on 2025/3/27.
//

import Foundation

extension Sequence where Element: Hashable {
    func frequencySorted() -> [Element] {
        let counts = reduce(into: [:]) { $0[$1, default: 0] += 1 }
        return sorted { counts[$0]! > counts[$1]! }
    }
}

extension Sequence where Element == Repository {
    func sortedByRelevance() -> [Element] {
        sorted {
            // 综合stars数、更新时间和语言偏好计算权重
            let weight1 = $0.stargazers_count * (Calendar.current.isDateInLastWeek($0.updatedAt) ? 5 : 1)
            let weight2 = $1.stargazers_count * (Calendar.current.isDateInLastWeek($1.updatedAt) ? 5 : 1)
            return weight1 > weight2
        }
    }
}
