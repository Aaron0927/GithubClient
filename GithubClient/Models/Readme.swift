//
//  Readme.swift
//  GithubClient
//
//  Created by kim on 2025/3/14.
//


// MARK: - Readme
struct Readme: Codable {
    let type, encoding: String
    let size: Int?
    let name, path, content, sha: String
    let url: String?
    let gitURL: String?
    let htmlURL, downloadURL: String?
    let links: Links?
}

// MARK: - Links
struct Links: Codable {
    let git: String?
    let linksSelf, html: String?
}
