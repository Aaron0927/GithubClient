//
//  User.swift
//  GithubClient
//
//  Created by kim on 2025/3/13.
//

import Foundation

// MARK: - User
struct User: Codable, Hashable {
    let avatarURL: String
    let name: String?
    let login: String
    let bio: String?
    let location: String?
    let email: String?
    let twitterUsername: String?
    let followers: Int?
    let following: Int?
    let total_private_repos: Int?
    let public_repos: Int?
    
    var totalRepos: Int {
        (total_private_repos ?? 0) + (public_repos ?? 0)
    }
    
    
    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
        case name
        case login
        case bio
        case location
        case email
        case twitterUsername = "twitter_username"
        case following
        case followers
        case total_private_repos
        case public_repos
    }
}
