//
//  RepositoryDetailViewModel.swift
//  GithubClient
//
//  Created by kim on 2025/4/30.
//

import SwiftUI

@MainActor
final class RepositoryDetailViewModel: ObservableObject {
    
    @Published var repoContents: [RepoContent] = []
    @Published var selectedContent: RepoContent? = nil
    @Published var paths: [RepoContent] = []
    
    private(set) var repo: Repository
    private(set) var root: RepoContent
    var contentURL: String {
        selectedContent?.htmlURL ?? ""
    }
    
    init(repo: Repository) {
        self.repo = repo
        self.root = RepoContent(path: "", name: "", type: .dir, htmlURL: "", downloadURL: "")
    }
    
    // 请求结点
    func fetchData(path: String? = nil) async {
        do {
            let repoContents: [RepoContent] = try await APIClient.shared.request(GitHubEndpoint.repoContent(owner: repo.owner.login, repo: repo.name, path: path))
            if path == nil {
                self.root.next = repoContents
            } else {
                selectedContent?.next = repoContents
                if let selectedContent = selectedContent {
                    paths.append(selectedContent)
                }
            }
            self.repoContents = repoContents
        } catch {
            print(error)
        }
    }
    
    // 更新当前选择的结点
    func updateSelectRepoContent(repoContent: RepoContent?) {
        selectedContent = repoContent
        if let repoContent = repoContent {
            repoContents = repoContent.next ?? []
            if let index = paths.firstIndex(where: { $0.path == repoContent.path }) {
//                paths.removeLast(paths.count - index + 1)
            }
        } else {
            repoContents = root.next ?? []
            paths = []
        }
    }
}
