//
//  UserStarRepoViewModel.swift
//  GithubClient
//
//  Created by kim on 2025/5/6.
//

import Foundation

@MainActor
final class UserStarRepoViewModel: ObservableObject {
    @Published var repos: [Repository] = []
    
    // 获取用户星标仓库
    func fetchUserStarredRepoList() async {
        do {
            self.repos = try await APIClient.shared.request(GitHubEndpoint.userStarred)
            
        } catch {
            print(error)
            
        }
    }
}
