//
//  GitHubAPIService.swift
//  GithubClient
//
//  Created by kim on 2025/3/27.
//

import Foundation

class GitHubAPIService {
    // MARK: - User
    /// 用户信息
    func fetchUsersInfo(userName: String) async throws -> User {
        return try await APIClient.shared.request(GitHubEndpoint.users(userName: userName))
    }
    
    /// 用户关注的人
    func fetchFollowingUsers() async throws -> [User] {
        return try await APIClient.shared.request(GitHubEndpoint.userFollowing)
    }

    /// 搜索用户
    func searchUsers(query: String, page: Int = 1, per_page: Int = 30) async throws -> [User] {
        let result: SearchResponse<User> = try await APIClient.shared.request(
            GitHubEndpoint.searchUsers(q: query, page: page, per_page: per_page))
        return result.items
    }
    
    /// 用户贡献日历
    func fetchContributions(userName: String) async throws -> [[DayActivity]] {
        let result: DayActivityResponse = try await APIClient.shared.request(GitHubEndpoint.contributions(userName: userName))
        return result.contributions
    }
    
    /// 用户仓库
    func fetchUserRepos() async throws -> [Repository] {
        return try await APIClient.shared.request(GitHubEndpoint.userRepos(type: "all", page: 1, per_page: 30))
    }

    // MARK: - Repositories
    /// 搜索仓库
    func searchRepos(query: String, page: Int = 1, per_page: Int = 30) async throws -> [Repository]
    {
        let result: SearchResponse<Repository> = try await APIClient.shared.request(
            GitHubEndpoint.searchRepositories(q: query, page: page, per_page: per_page))
        return result.items
    }

    /// 用户starred仓库
    func fetchUserStarredRepos() async throws -> [Repository] {
        return try await APIClient.shared.request(GitHubEndpoint.userStarred)
    }

    /// 用户的仓库
    func fetchUsersRepos(user: User) async throws -> [Repository] {
        return try await APIClient.shared.request(
            GitHubEndpoint.userRepositories(username: user.login))
    }

    // MARK: - Issues
    /// 搜索issues
//    func searchIssues(query: String, page: Int = 1, per_page: Int = 30) async throws -> [Issue] {
//        let result: SearchResponse<Issue> = try await APIClient.shared.request(
//            GitHubEndpoint.searchIssues(q: query, page: page, per_page: per_page))
//        return result.items
//    }
}

extension GitHubAPIService {
    /// 获取趋势仓库
    func fetchTrendingRepos() async throws -> [Repository] {
        return try await fetchTrendingRepositories()
    }

    /// 获取推荐仓库
    func fetchRecommendRepos() async throws -> [Repository] {
        async let personalized = fetchPersonlizedRecommendations()
        //        async let trending = fetchTrendingRepositories()
        //        async let popular = fetchPopularRepositories()

        let results = (await (try? personalized) ?? [])
        //        + (await (try? trending) ?? [])
        //        + (await (try? popular) ?? [])
        return []
//        return Array(
//            Array(Set(results))
//                .sortedByRelevance()
//                .prefix(20))
    }

    /// 获取用户个性推荐
    private func fetchPersonlizedRecommendations() async throws -> [Repository] {
        var repos: [Repository] = []

        // 基于用户star历史
        if let languageBased = try? await fetchUserBasedRecommendations() {
            repos.append(contentsOf: languageBased)
        }

        // 基于用户关注的人
        if let followingBased = try? await fetchFollowingUsersRepos() {
            repos.append(contentsOf: followingBased)
        }

        return repos
    }

    /// 获取用户starred仓库推荐
    private func fetchUserBasedRecommendations() async throws -> [Repository] {
        // 获取用户star过的仓库
        let starredRepos = try await fetchUserStarredRepos()

        // 提取最常用的语言
        let topLanguages =
            starredRepos
            .compactMap { $0.language }
//            .frequencySorted()
            .prefix(3)

        // 获取这些语言的推荐仓库
        var recommendations: [Repository] = []
        for language in topLanguages {
            let repos = try await fetchLanguageBasedRecommendations(language: language)
            recommendations.append(contentsOf: repos)
        }
        return Array(recommendations.shuffled().prefix(10))
    }

    /// 获取用户关注的人的仓库
    private func fetchFollowingUsersRepos() async throws -> [Repository] {
        // 获取用户关注的人
        let following = try await fetchFollowingUsers()

        // 获取这些用户的最新仓库
        var repos: [Repository] = []
        for user in following.prefix(5) {
            let userRepos = try await fetchUsersRepos(user: user)
            repos.append(contentsOf: userRepos)
        }

        return Array(repos.sorted { $0.stargazers_count > $1.stargazers_count }.prefix(10))
    }

    /// 获取同语言热门仓库
    private func fetchLanguageBasedRecommendations(language: String) async throws -> [Repository] {
        let query = "language:\(language) stars:>100"
        return try await searchRepos(query: query)
    }

    /// 获取相关话题仓库
    private func fetchTopicBasedRecommendations(topic: String) async throws -> [Repository] {
        let query = "topic:\(topic) stars:>50"
        return try await searchRepos(query: query)
    }

    /// 获取近期趋势仓库
    private func fetchTrendingRepositories(daysAgo: Int = 30) async throws -> [Repository] {
        let date = Calendar.current.date(byAdding: .day, value: -daysAgo, to: Date())!
        let dateString = ISO8601DateFormatter().string(from: date)
        let query = "created:>\(dateString) stars:>100"
        return try await searchRepos(query: query)
    }

    /// 获取全局热门仓库
    private func fetchPopularRepositories() async throws -> [Repository] {
        let query = "stars:>1000"
        return try await searchRepos(query: query)
    }
}
