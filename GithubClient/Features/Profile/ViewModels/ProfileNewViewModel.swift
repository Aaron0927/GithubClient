//
//  ProfileNewViewModel.swift
//  GithubClient
//
//  Created by kim on 2025/4/7.
//

import Foundation

enum ProfileTab: Int, CaseIterable {
    case repositories = 0
    case stars = 1
    case forks = 2
    
    var name: String {
        switch self {
        case .repositories:
            "仓库"
        case .stars:
            "星标"
        case .forks:
            "项目"
        }
    }
}

@MainActor
final class ProfileNewViewModel: ObservableObject {
    @Published var user: User? = nil
    @Published private(set) var contributions: [DayActivity] = []
    @Published private(set) var weeks: [String] = []
    @Published private(set) var repos: [Repository] = []
    
    private let service = GitHubAPIService()
    
    func loadData() async {
        do {
            // 获取用户信息
            self.user = try await service.fetchUsersInfo(userName: "Aaron0927")
            
            // 获取贡献日历
            self.contributions = try await service.fetchContributions(userName: "Aaron0927").flatMap { $0 }
            self.weeks = ["Sun.", "Mon.", "Tues.", "Wed.", "Thur.", "Fri.", "Sat."]
            
            // 获取用户仓库
            self.repos = try await service.fetchUserRepos()
            
        } catch {
            print("获取失败:\(error)")
        }
    }
    
    
}
