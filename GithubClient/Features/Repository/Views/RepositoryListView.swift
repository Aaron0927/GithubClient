//
//  RepositoryListView.swift
//  GithubClient
//
//  Created by kim on 2025/3/17.
//

import SwiftUI

struct RepositoryListView: View {
    
    @StateObject private var viewModel = RepositoryListViewModel()
    
    var body: some View {
        List {
            Section {
                ForEach(viewModel.repos) { repo in
                    RepositoryRowView(repo: repo)
                }
            } header: {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Menu {
                            ForEach(viewModel.types, id: \.self) { type in
                                Button(type.rawValue) {
                                    viewModel.selectedType = type
                                }
                            }
                        } label: {
                            VStack(alignment: .leading, spacing: 10) {
                                HStack {
                                    Text("类型")
                                        .foregroundStyle(Color.black)
                                        .font(.body)
                                    Image(systemName: "arrow.down")
                                        .foregroundStyle(Color.gray)
                                        .font(.body)
                                }
                                .padding(.horizontal, 15)
                                .padding(.vertical, 5)
                                .background(
                                    Color.gray.opacity(0.2)
                                        .clipShape(.capsule)
                                )
                                .padding(.horizontal)
                            }
                        }
                        Spacer()
                    }
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 1)
                }
            }
            .listRowSeparator(.hidden) // 隐藏分割线
            .listRowInsets(EdgeInsets()) // 设置默认边距
            .listSectionSeparator(.hidden)
            
            // 加载更多
            if !viewModel.repos.isEmpty {
                LoadMoreView(hasMoreData: viewModel.hasMoreData, loadMoreText: viewModel.loadMoreText) {
                    await viewModel.loadmore()
                }
                .listRowSeparator(.hidden) // 隐藏分割线
                .listRowInsets(EdgeInsets()) // 设置默认边距
                .frame(height: 30)
            }
        }
        .listStyle(.plain)
        // 刷新
        .refreshable {
            await viewModel.refresh()
        }
        .loading(isLoading: viewModel.isLoading)
        .navigationTitle("Repositories")
        .task {
            await viewModel.loadRepositories()
        }
    }
}

#Preview {
    NavigationView {
        RepositoryListView()
    }
}
