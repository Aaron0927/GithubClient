//
//  ProfileNewView.swift
//  GithubClient
//
//  Created by kim on 2025/4/7.
//

import SwiftUI

struct ProfileNewView: View {
    
    @StateObject private var viewModel = ProfileNewViewModel()
    @State private var selectedIndex: Int = ProfileTab.repositories.rawValue
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 20, pinnedViews: [.sectionHeaders, .sectionFooters]) {
                    ProfileHeaderView(user: viewModel.user)
                    ContributionGraphView(contrbutions: viewModel.contributions, weeks: viewModel.weeks)
                    ProfileStatsView(user: viewModel.user)
                    PinnedReposView()
                    
                    Section {
                        ProfileTabsView {
                            let selectedTab = ProfileTab(rawValue: selectedIndex)!
                            switch selectedTab {
                            case .repositories:
                                ProfileReposityView(repos: viewModel.repos)
                            case .stars:
                                ProfileStarView()
                            case .projects:
                                ProfileProjectView()
                            }
                        }
                    } header: {
                        MenuTabView(currentSelected: $selectedIndex, titles: ProfileTab.allCases.map { $0.name }, selectedColor: .primary, unselectedColor: .gray)
                            .padding(.top, 5)
                            .background(.white)
                    }
                }
                .padding(.horizontal)
                .background(.white)
            }
            .navigationTitle("个人中心")
            .navigationBarTitleDisplayMode(.inline)
            .task {
                await viewModel.loadData()
            }
        }
    }
}

#Preview {
    ProfileNewView()
}
