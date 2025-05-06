//
//  UserForkRepoViewModel.swift
//  GithubClient
//
//  Created by kim on 2025/5/6.
//

import Foundation

@MainActor
final class UserForkRepoViewModel: ObservableObject {
    @Published var repos: [Repository] = []
    
    func fetchData() async {
        do {
            self.repos = try await APIClient.shared.request(GitHubEndpoint.userForkRepos(userName: "Aaron0927"))
        } catch {
            print(error)
        }
    }
}
