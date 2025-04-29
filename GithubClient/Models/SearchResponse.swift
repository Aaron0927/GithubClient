//
//  SearchResponse.swift
//  GithubClient
//
//  Created by kim on 2025/3/27.
//

import Foundation

struct SearchResponse<T: Codable>: Codable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [T]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}
