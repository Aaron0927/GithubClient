//
//  HomeView.swift
//  GithubClient
//
//  Created by kim on 2025/3/27.
//

import SwiftUI
import Foundation

/// 首页主视图
struct HomeView: View {
    
    @StateObject private var viewModel = HomeViewModel()
    @State private var showSearchView: Bool = false
    @State private var showTrendingRepoView: Bool = false
    
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
            .navigationTitle("首页")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        // 搜索操作
                        showSearchView = true
                    } label: {
                        Image(systemName: "magnifyingglass")
                    }
                }
            }
            .sheet(isPresented: $showSearchView, content: {
                SearchView()
            })
            .navigationDestination(isPresented: $showTrendingRepoView, destination: {
                TrendingReposView(repos: viewModel.trendingRepos)
            })
            .refreshable {
                await viewModel.refresh()
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
                }
                
                NavigationLink {
                   // 查看更多推荐仓库视图
                } label: {
                    Text("查看全部推荐")
                        .foregroundStyle(Color.blue)
                        .font(.body)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                }

            }
        } header: {
            SectionHeader(title: "为你推荐", action: {
                // 刷新推荐
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
                QuickAccessButton(icon: "magnifyingglass", label: "搜索") {
                    showSearchView = true
                }
            }
        } header: {
            SectionHeader(title: "快速访问")
        }
    }
}

#Preview("加载中") {
    let vm = HomeViewModel()
    vm.isLoading = true
    return HomeView()
        .environmentObject(vm)
}

//#Preview("有数据") {
//    let vm = HomeViewModel()
//    vm.trendingRepos = Repository.mockTrending
//    vm.recommendedRepos = Repository.mockRecommended
//    return HomeView()
//        .environmentObject(vm)
//}

#Preview("错误") {
    let vm = HomeViewModel()
    vm.error = NSError(domain: "test", code: 1, userInfo: [NSLocalizedDescriptionKey: "测试错误"])
    return HomeView()
        .environmentObject(vm)
}
