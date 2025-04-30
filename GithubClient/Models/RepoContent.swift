//
//  Content.swift
//  GithubClient
//
//  Created by kim on 2025/4/30.
//

import Foundation

/**
 Response:
 {
     "_links": Object{...},
     "git_url": "https:\/\/api.github.com\/repos\/Aaron0927\/Snow\/git\/blobs\/52fe2f7102c32aa7f837eaa73be2065be9d82802",
     "html_url": "https:\/\/github.com\/Aaron0927\/Snow\/blob\/main\/.gitignore",
     "download_url": "https:\/\/raw.githubusercontent.com\/Aaron0927\/Snow\/main\/.gitignore",
     "size": 1593,
     "sha": "52fe2f7102c32aa7f837eaa73be2065be9d82802",
     "path": ".gitignore",
     "type": "file",
     "name": ".gitignore",
     "url": "https:\/\/api.github.com\/repos\/Aaron0927\/Snow\/contents\/.gitignore?ref=main"
 }
 */
struct RepoContent: Codable, Identifiable {
    enum `Type`: String, Codable {
        case dir = "dir"
        case file = "file"
        
        var icon: String {
            switch self {
            case .dir: "folder.fill"
            case .file: "document.fill"
            }
        }
    }
    
    var next: [RepoContent]?
    var id: String = UUID().uuidString
    let path: String
    let name: String
    let type: `Type`
    let htmlURL: String
    let downloadURL: String?
    
    enum CodingKeys: String, CodingKey {
        case path
        case name
        case type
        case htmlURL = "html_url"
        case downloadURL = "download_url"
    }
}

