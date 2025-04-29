//
//  RepositoryView.swift
//  GithubClient
//
//  Created by kim on 2025/4/29.
//

import SwiftUI

struct RepositoryView: View {
    
    @StateObject private var viewModel = RepositoryViewModel()
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack {
                    ForEach(viewModel.repos) { repo in
                        RepositoryRow(repo: repo)
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Search repositories...")
            .navigationTitle("Repositories")
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
}

#Preview {
    RepositoryView()
}
