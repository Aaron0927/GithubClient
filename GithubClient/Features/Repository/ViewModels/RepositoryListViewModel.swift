//
//  RepositoryListViewModel.swift
//  GithubClient
//
//  Created by kim on 2025/3/17.
//

import Combine
import Foundation

enum RepositoryType: String, CaseIterable {
    case all = "Show all"
    case `public` = "Public"
    case `private` = "Private"
    case source = "Source"
    case fork = "Fork"
    case mirror = "Mirror"
    case template = "Template"
    case archived = "Archived"

    var query: String {
        switch self {
        case .all:
            return "all"
        case .public:
            return "public"
        case .private:
            return "private"
        case .source:
            return "source"
        case .fork:
            return "fork"
        case .mirror:
            return "mirror"
        case .template:
            return "template"
        case .archived:
            return "archived"
        }
    }
}

@MainActor
final class RepositoryListViewModel: ObservableObject {

    @Published private(set) var repos: [Repository] = []
    @Published var selectedType: RepositoryType = .all
    @Published private(set) var isLoading: Bool = false  // 加载状态
    @Published private(set) var loadMoreText: String = "Load more..."  // 加载更多文案
    @Published private(set) var hasMoreData: Bool = false {
        didSet {
            loadMoreText = hasMoreData ? "Load more..." : "No more data."
        }
    }

    var types: [RepositoryType] = RepositoryType.allCases

    private var page: Int = 1
    private var per_page: Int = 30

    private var cancellables = Set<AnyCancellable>()

    init() {
        addSubscribers()
    }

    private func addSubscribers() {
        $selectedType
            .dropFirst()
            .sink { type in
                Task {
                    await self.loadRepositories()
                }
            }
            .store(in: &cancellables)
    }

    // 下拉刷新
    func refresh() async {
        do {
            let repos: [Repository] = try await APIClient.shared.request(
                GitHubEndpoint.userRepos(
                    type: self.selectedType.query, page: 1, per_page: self.per_page))
            self.page = 1
            self.repos = repos
            self.hasMoreData = (repos.count >= per_page)
        } catch {

        }
    }

    // 加载更多
    func loadmore() async {
        page += 1
        do {
            let repos: [Repository] = try await APIClient.shared.request(
                GitHubEndpoint.userRepos(
                    type: self.selectedType.query, page: self.page, per_page: self.per_page))
            self.repos.append(contentsOf: repos)
            self.hasMoreData = (repos.count >= per_page)
        } catch {
            page -= 1
        }
    }

    func loadRepositories() async {
        do {
            self.isLoading = true
            self.repos = try await APIClient.shared.request(
                GitHubEndpoint.userRepos(
                    type: self.selectedType.query, page: self.page, per_page: self.per_page))
            self.isLoading = false
        } catch {
            print(error.localizedDescription)
            self.isLoading = false
        }
    }
}
