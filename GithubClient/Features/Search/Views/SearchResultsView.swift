//
//  SearchResultsView.swift
//  GithubClient
//
//  Created by kim on 2025/3/28.
//

import SwiftUI

struct SearchResultsView: View {

    let results: SearchResults
    let scope: SearchScope

    var body: some View {
        if results.isEmpty {
            EmptyResultsView(scope: scope)
        } else {
            switch results {
            case .repositories(let repos, _):
                RepositoryResultsView(repositories: repos)
            case .users(let users, _):
                UserResultsView(users: users)
            case .issues(let issues, _):
                Text("")
//                IssueResultsView(issues: issues)
            }
        }
    }
}

struct EmptyResultsView: View {

    let scope: SearchScope

    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 40))
                .foregroundStyle(.secondary)
            Text("没有找到\(scope.rawValue)")
                .font(.headline)
            Text("尝试不同的搜索词")
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}

#Preview {
    SearchResultsView(results: .issues([], hasMore: false), scope: .issues)
}
