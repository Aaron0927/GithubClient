//
//  ExploreView.swift
//  GithubClient
//
//  Created by kim on 2025/3/24.
//

import SwiftUI

struct ExploreView: View {
    
    @StateObject private var viewModel = ExploreViewModel()
    @State private var showTrendingRepoView: Bool = false
    @State private var showRecommendRepoView: Bool = false
    @State private var showDetailView: Bool = false
    @State private var selectedRepo: Repository? = nil
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 30) {
                    quickAccessSection
                    
                    trendingSection
                    
                    recommendedSection
                }
                .padding()
            }
            .navigationTitle("Explore")
            .navigationDestination(isPresented: $showTrendingRepoView) {
                TrendingReposView(repos: viewModel.trendingRepos)
            }
            .navigationDestination(isPresented: $showRecommendRepoView) {
                RecommendReposView(repos: viewModel.recommendedRepos)
            }
            .navigationDestination(isPresented: $showDetailView) {
                RepoDetailLoadingView(repo: $selectedRepo)
            }
            .refreshable {
                await viewModel.loadData()
            }
            .task {
                await viewModel.loadData()
            }
            .overlay {
                if viewModel.isLoading && viewModel.trendingRepos.isEmpty {
                    ProgressView()
                }
            }
            .alert("加载错误", isPresented: .constant(viewModel.error != nil)) {
                Button("重试") {
                    Task {
                        await viewModel.loadData()
                    }
                }
                Button("取消", role: .cancel) {}
            } message: {
                Text(viewModel.error?.localizedDescription ?? "未知错误")
            }
        }
    }
        
    private var trendingSection: some View {
        Section {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(viewModel.trendingRepos) { repo in
                        TrendingRepoCard(repository: repo)
                            .frame(width: 280, height: 120)
                            .onTapGesture {
                                segue(repo)
                            }
                    }
                }
                .padding(.vertical, 5)
            }
        } header: {
            SectionHeader(title: "趋势仓库", action: {
                // 查看全部操作
                showTrendingRepoView = true
            })
        }
    }
    
    private var recommendedSection: some View {
        Section {
            LazyVStack(spacing: 12) {
                ForEach(viewModel.recommendedRepos.prefix(5)) { repo in
                    RepositoryRow(repo: repo)
                        .onTapGesture {
                            segue(repo)
                        }
                }
                
                Text("查看全部推荐")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .onTapGesture {
                        showRecommendRepoView = true
                    }
            }
        } header: {
            SectionHeader(title: "为你推荐", action: {
                // 刷新推荐
                showRecommendRepoView = true
            })
        }
    }
    
    private var quickAccessSection: some View {
        Section {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))], spacing: 15) {
                QuickAccessButton(icon: "bookmark", label: "收藏") {
                    
                }
                QuickAccessButton(icon: "clock.arrow.circlepath", label: "最近") {
                    
                }
                QuickAccessButton(icon: "person.2", label: "团队") {
                    
                }
            }
        } header: {
            SectionHeader(title: "快速访问")
        }
    }
    
    private func segue(_ repo: Repository) {
        showDetailView = true
        selectedRepo = repo
    }
}

#Preview {
    ExploreView()
}
