//
//  Calendar.swift
//  GithubClient
//
//  Created by kim on 2025/3/28.
//

import Foundation

extension Calendar {
    func isDateInLastWeek(_ date: Date) -> Bool {
        let oneWeekAgo = self.date(byAdding: .weekOfYear, value: -1, to: Date())!
        return date >= oneWeekAgo && date <= Date()
    }
}
