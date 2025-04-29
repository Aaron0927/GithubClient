//
//  ProfileViewModel.swift
//  GithubClient
//
//  Created by kim on 2025/3/13.
//

import Foundation

@MainActor
final class ProfileViewModel: ObservableObject {
    
    @Published var user: User? = nil
    @Published var readme: Readme? = nil
    
    // 获取用户信息
    func getUser() async {
        do {
            let user: User = try await APIClient.shared.request(GitHubEndpoint.user)
            print(user)
            self.user = user
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // 获取README仓库
    func getReadme(owner: String, repo: String) async {
        do {
            let res: Readme = try await APIClient.shared.request(GitHubEndpoint.readme(owner: owner, repo: repo))
            print("请求达成", res.content.decodeBase64())
            self.readme = res
        } catch {
            print(error.localizedDescription)
        }
    }
}
