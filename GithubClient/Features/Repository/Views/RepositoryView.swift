//
//  RepositoryView.swift
//  GithubClient
//
//  Created by kim on 2025/4/29.
//

import SwiftUI

struct RepositoryView: View {
    
    @StateObject private var viewModel = RepositoryViewModel()
    @State private var showDetailView: Bool = false
    @State private var selectedRepo: Repository? = nil
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack {
                    ForEach(viewModel.isSearching ? viewModel.filteredRepos : viewModel.repos) { repo in
                        RepositoryRow(repo: repo)
                            .contentShape(Rectangle()) // 追加热区设置
                            .onTapGesture {
                                segue(repo: repo)
                            }
                    }
                }
            }
            .searchable(text: $viewModel.searchText, prompt: "Search repositories...")
            .navigationTitle("Repositories")
            .navigationDestination(isPresented: $showDetailView, destination: {
                RepoDetailLoadingView(repo: $selectedRepo)
            })
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "bell.fill")
                            .foregroundStyle(.gray)
                            .font(.caption)
                    }
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "magnifyingglass")
                    }
                }
            }
            .task {
                await viewModel.fetchUserRepos()
            }
        }
    }
    
    private func segue(repo: Repository) {
        selectedRepo = repo
        showDetailView = true
    }
}

#Preview {
    RepositoryView()
}
