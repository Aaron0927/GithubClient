//
//  RepositoryViewModel.swift
//  GithubClient
//
//  Created by kim on 2025/4/29.
//

import SwiftUI
import Combine

@MainActor
final class RepositoryViewModel: ObservableObject {
    
    @Published var repos: [Repository] = []
    @Published var filteredRepos: [Repository] = []
    @Published var searchText: String = ""
    
    var isSearching: Bool {
        !searchText.isEmpty
    }
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        $searchText
            .debounce(for: 0.3, scheduler: DispatchQueue.main) // 防抖，0.3秒内没有输入才调用一次
            .sink { [weak self] searchText in
                self?.filterRepos(searchText: searchText)
            }
            .store(in: &cancellable)
    }
    
    private func filterRepos(searchText: String) {
        let search = searchText.lowercased()
        filteredRepos = repos.filter { repo in
            repo.name.lowercased().contains(search)
        }
    }
    
    // 获取用户仓库
    func fetchUserRepos() async {
        do {
            self.repos = try await APIClient.shared.request(GitHubEndpoint.userRepos(type: ""))
        } catch {
            print(error)
        }
    }
}
