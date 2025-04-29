//
//  SearchViewModel.swift
//  GithubClient
//
//  Created by kim on 2025/3/28.
//

import Foundation

enum SearchScope: String, CaseIterable {
    case repositories = "仓库"
    case users = "用户"
    case issues = "issues"

    var searchType: GitHubSearchType {
        switch self {
        case .repositories:
            return .repositories
        case .users:
            return .users
        case .issues:
            return .issues
        }
    }
}

enum SearchResults {
    case repositories([Repository], hasMore: Bool)
    case users([User], hasMore: Bool)
    case issues([String], hasMore: Bool)

    var isEmpty: Bool {
        switch self {
        case .repositories(let repos, _):
            return repos.isEmpty
        case .users(let users, _):
            return users.isEmpty
        case .issues(let issues, _):
            return issues.isEmpty
        }
    }

    var hasMore: Bool {
        switch self {
        case .repositories(_, let hasMore):
            return hasMore
        case .users(_, let hasMore):
            return hasMore
        case .issues(_, let hasMore):
            return hasMore
        }
    }
}

enum GitHubSearchType {
    case repositories
    case users
    case issues
}

@MainActor
final class SearchViewModel: ObservableObject {
    enum State {
        case idle
        case loading
        case loaded(SearchResults)
        case error(Error)
    }

    @Published var state: State = .idle
    @Published private(set) var isLoadingMore = false
    private let service = GitHubAPIService()
    private var currentPage = 1
    private let perPage = 30
    private var currentQuery = ""
    private var currentScope: SearchScope = .repositories

    func search(query: String, scope: SearchScope) async {
        guard !query.isEmpty else {
            state = .idle
            return
        }

        // 如果是新的搜索，重置页码
        if query != currentQuery || scope != currentScope {
            currentPage = 1
            currentQuery = query
            currentScope = scope
        }

        state = .loading

        do {
            let results: SearchResults
            switch scope.searchType {
            case .repositories:
                let repos: [Repository] = try await service.searchRepos(
                    query: query, page: currentPage, per_page: perPage)
                results = .repositories(repos, hasMore: repos.count >= perPage)
            case .users:
                let users: [User] = try await service.searchUsers(
                    query: query, page: currentPage, per_page: perPage)
                results = .users(users, hasMore: users.count >= perPage)
            case .issues:
                results = .issues([], hasMore: true)
//                let issues: [Issue] = try await service.searchIssues(
//                    query: query, page: currentPage, per_page: perPage)
//                results = .issues(issues, hasMore: issues.count >= perPage)
            }
            state = .loaded(results)
        } catch {
            state = .error(error)
        }
    }

    func loadMore() async {
        guard case .loaded(let results) = state,
            results.hasMore,
            !isLoadingMore,
            !currentQuery.isEmpty
        else { return }

        isLoadingMore = true
        currentPage += 1

        do {
            let newResults: SearchResults
            switch currentScope.searchType {
            case .repositories:
                let repos: [Repository] = try await service.searchRepos(
                    query: currentQuery, page: currentPage, per_page: perPage)
                if case .repositories(let existingRepos, _) = results {
                    newResults = .repositories(
                        existingRepos + repos, hasMore: repos.count >= perPage)
                } else {
                    newResults = results
                }
            case .users:
                let users: [User] = try await service.searchUsers(
                    query: currentQuery, page: currentPage, per_page: perPage)
                if case .users(let existingUsers, _) = results {
                    newResults = .users(existingUsers + users, hasMore: users.count >= perPage)
                } else {
                    newResults = results
                }
            case .issues:
//                let issues: [String] = try await service.searchIssues(
//                    query: currentQuery, page: currentPage, per_page: perPage)
//                if case .issues(let existingIssues, _) = results {
//                    newResults = .issues(existingIssues + issues, hasMore: issues.count >= perPage)
//                } else {
//                    newResults = results
//                }
                newResults = results
            }
            state = .loaded(newResults)
        } catch {
            currentPage -= 1
            state = .error(error)
        }

        isLoadingMore = false
    }
}
