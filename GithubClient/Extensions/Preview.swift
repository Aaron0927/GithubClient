//
//  Preview.swift
//  GithubClient
//
//  Created by kim on 2025/3/17.
//

import Foundation
import SwiftUI

class DeveloperPreview {
    static let shared = DeveloperPreview()
    private init() {}
    
    var owner: User {
        User(avatarURL: "https://avatars.githubusercontent.com/u/14815745?v=4", name: nil, login: "Aaron0927", bio: nil, location: nil, email: nil, twitterUsername: nil, followers: nil, following: nil, total_private_repos: nil, public_repos: nil)
    }
    
    
    var repo: Repository {
        Repository(id: 1296269, name: "Hello-World", full_name: "octocat/Hello-World", description: "This your first repo!", forks_count: 9, stargazers_count: 80, watchers_count: 80, language: "Swift", owner: owner, updatedAt: .now, default_branch: "master")
    }
    
    var contributions: [DayActivity] {
        Array(repeating: DayActivity(date: "2024-05-02", count: 10), count: 365)
    }
}


extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.shared
    }
}

extension User {
    
}

extension Repository {
    static let mockTrending: [Repository] = [
        Repository(id: 1, name: "awesome-ios", full_name: "vsouza/awesome-ios", description: "A curated list of awesome iOS ecosystem", forks_count: 6700, stargazers_count: 42000, watchers_count: 0, language: "Swift", owner: DeveloperPreview.shared.owner, updatedAt: .now, default_branch: "master"),
    ]
    
    static let mockRecommended: [Repository] = [
        Repository(id: 2, name: "Alamofire", full_name: "Alamofire/Alamofire", description: "Elegant HTTP Networking in Swift", forks_count: 7400, stargazers_count: 39000, watchers_count: 0, language: "Swift", owner: DeveloperPreview.shared.owner, updatedAt: .now, default_branch: "master"),
    ]
}
