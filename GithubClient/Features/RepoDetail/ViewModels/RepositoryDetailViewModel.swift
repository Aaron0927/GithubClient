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
    var contentURL: String {
        selectedContent?.htmlURL ?? ""
    }
    
    init(repo: Repository) {
        self.repo = repo
    }
    
    // 请求结点
    func fetchData(path: String? = nil) async {
        do {
            let repoContents: [RepoContent] = try await APIClient.shared.request(GitHubEndpoint.repoContent(owner: repo.owner.login, repo: repo.name, path: path))
            self.repoContents = repoContents
            if path == nil {
                var root = RepoContent(path: "root", name: "root", type: .dir, htmlURL: "", downloadURL: "")
                root.next = repoContents
                self.paths.removeAll()
                self.paths.append(root)
            } else {
                selectedContent?.next = repoContents
                if let selectedContent = selectedContent {
                    paths.append(selectedContent)
                }
            }
        } catch {
            print(error)
        }
    }
    
    // 更新当前选择的结点
    func updateSelectRepoContent(repoContent: RepoContent) {
        guard let index = paths.firstIndex(where: { $0.path == repoContent.path }),
              paths.count > 1 else {
            return
        }
        
        selectedContent = repoContent
        repoContents = repoContent.next ?? []
        paths.removeLast(paths.count - index - 1)
    }
}
