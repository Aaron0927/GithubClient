//
//  RepositoryViewModel.swift
//  GithubClient
//
//  Created by kim on 2025/4/29.
//

import SwiftUI

@MainActor
final class RepositoryViewModel: ObservableObject {
    
    @Published var repos: [Repository] = []
    
    // 获取用户仓库
    func fetchUserRepos() async {
        do {
            self.repos = try await APIClient.shared.request(GitHubEndpoint.userRepos(type: ""))
        } catch {
            print(error)
        }
    }
}
