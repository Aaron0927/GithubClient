//
//  RecommendReposView.swift
//  GithubClient
//
//  Created by kim on 2025/5/6.
//

import SwiftUI

struct RecommendReposView: View {
    @State private var showDetailView: Bool = false
    @State private var selectedRepo: Repository? = nil
    
    let repos: [Repository]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack {
                ForEach(repos) { repo in
                    RepositoryRow(repo: repo)
                        .contentShape(Rectangle()) // 追加热区设置
                        .onTapGesture {
                            segue(repo: repo)
                        }
                }
            }
        }
        .navigationTitle("Repositories")
        .navigationDestination(isPresented: $showDetailView, destination: {
            RepoDetailLoadingView(repo: $selectedRepo)
        })
    }
    
    private func segue(repo: Repository) {
        selectedRepo = repo
        showDetailView = true
    }
}

#Preview {
    RecommendReposView(repos: [DeveloperPreview.shared.repo])
}
