//
//  GitHubEndpoint.swift
//  GithubClient
//
//  Created by kim on 2025/3/13.
//

import Foundation

enum GitHubEndpoint {

    // 搜索排序
    enum Sort: String {
        case stars
    }

    case access_token(code: String)
    // MARK: - User
    case user
    case users(userName: String)
    case readme(owner: String, repo: String)
    case userRepos(type: String = "all", page: Int = 1, per_page: Int = 30) // 授权用户仓库列表
    case userStarred  // 用户Starred过的仓库
    case userFollowing  // 用户关注的人
    case userRepositories(username: String)  // 用户仓库
    case searchUsers(q: String, page: Int = 1, per_page: Int = 30)  // 搜索用户接口
    case contributions(userName: String) // 用户贡献日历

    // MARK: - Repository
    case repositories(page: Int = 1, per_page: Int = 30)
    case searchRepositories(
        q: String, sort: Sort = .stars, order: String = "desc", page: Int = 1, per_page: Int = 30)  // 搜索仓库接口
    case repoContent(owner: String, repo: String, path: String? = nil)

    // MARK: - Issue
    case searchIssues(
        q: String, sort: Sort = .stars, order: String = "desc", page: Int = 1, per_page: Int = 30)  // 搜索issues接口

    // MARK: - Topics
    case topics(page: Int = 1, per_page: Int = 30)
}

extension GitHubEndpoint: EndpointProtocol {
    var baseURL: String {
        switch self {
        case .access_token:
            return "https://github.com/login/oauth"
        case .contributions:
            return "https://github-calendar-api.meta-code.top"
        default:
            return "https://api.github.com"
        }
    }

    var path: String {
        switch self {
        case .access_token:
            return "/access_token"
        // MARK: - User
        case .user:
            return "/user"
        case .users(let userName):
            return "/users/\(userName)"
        case .readme(let owner, let repo):
            return "/repos/\(owner)/\(repo)/readme"
        case .userStarred:
            return "/user/starred"
        case .userFollowing:
            return "/user/following"
        case .searchUsers(let q, let page, let per_page):
            return "/search/users?q=\(q.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&page=\(page)&per_page=\(per_page)"
        case .contributions(let userName):
            return "/api?user=\(userName)"

        // MARK: - Repos
        case .userRepos(let type, let page, let per_page):
            return "/user/repos?type=\(type)&page=\(page)&per_page=\(per_page)&sort=updated"
        case .repositories(let page, let per_page):
            return "/repositories?page=\(page)&per_page=\(per_page)"
        case .searchRepositories(let q, let sort, let order, let page, let per_page):
            return "/search/repositories?q=\(q.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&sort=\(sort.rawValue)&order=\(order)&page=\(page)&per_page=\(per_page)"
        case .userRepositories(let username):
            return "/users/\(username)/repos"
        case .repoContent(let owner, let repo, let path):
            if let path = path {
                return "/repos/\(owner)/\(repo)/contents/\(path)"
            } else {
                return "/repos/\(owner)/\(repo)/contents"
            }

        // MARK: - Issue
        case .searchIssues(let q, let sort, let order, let page, let per_page):
            return "/search/issues?q=\(q.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&sort=\(sort.rawValue)&order=\(order)&page=\(page)&per_page=\(per_page)"

        // MARK: - Topics
        case .topics(let page, let per_page):
            return "/topics?page=\(page)&per_page=\(per_page)"
        }
    }
    var method: Method {
        switch self {
        case .access_token:
            return .post
        default:
            return .get
        }
    }

    var headers: [String: String]? {
        switch self {
        case .access_token:
            return nil
        default:
            if let token = KeyChainHelper.shared.token {
                return [
                    "Authorization": "Bearer \(token)"
                ]
            }
            return nil
        }
    }

    var body: [String: String]? {
        switch self {
        case .access_token(let code):
            return [
                "client_id": clientID,
                "client_secret": clientSecret,
                "code": code,
                "redirect_uri": redirectURI,
            ]
        default:
            return nil
        }
    }
}
