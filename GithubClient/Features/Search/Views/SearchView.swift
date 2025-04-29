//
//  SearchView.swift
//  GithubClient
//
//  Created by kim on 2025/3/28.
//

import SwiftUI
import UIKit

struct SearchView: View {

    @StateObject private var viewModel = SearchViewModel()
    @State private var searchText: String = ""
    @State private var searchScope: SearchScope = .repositories

    var body: some View {
        VStack {
            SearchBar(text: $searchText, scope: $searchScope)
                .padding(.horizontal)

            ScrollView {
                LazyVStack {
                    switch viewModel.state {
                    case .idle:
                        SuggestionsView(suggestin: $searchText)
                    case .loading:
                        LoadingView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .frame(minHeight: 300)
                    case .loaded(let searchResults):
                        SearchResultsView(results: searchResults, scope: searchScope)
                            .refreshable {
                                await viewModel.search(query: searchText, scope: searchScope)
                            }
                    case .error(let error):
                        ErrorView(error: error) {
                            Task {
                                await viewModel.search(query: searchText, scope: searchScope)
                            }
                        }
                    }

                    // 底部加载更多视图
                    if case .loaded(let results) = viewModel.state, results.hasMore {
                        HStack(spacing: 8) {
                            if viewModel.isLoadingMore {
                                ProgressView()
                                    .scaleEffect(0.8)
                                Text("正在加载更多...")
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                            } else {
                                Text("上拉加载更多")
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .onAppear {
                            Task {
                                await viewModel.loadMore()
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.top)
        .onChange(of: searchText) { newValue in
            if !newValue.isEmpty {
                Task {
                    await viewModel.search(query: newValue, scope: searchScope)
                }
            }
        }
        .onChange(of: searchScope) { newValue in
            if !searchText.isEmpty {
                Task {
                    await viewModel.search(query: searchText, scope: searchScope)
                }
            }
        }
    }
}

#Preview {
    SearchView()
}
