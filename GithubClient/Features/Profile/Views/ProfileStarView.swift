//
//  ProfileStarView.swift
//  GithubClient
//
//  Created by kim on 2025/4/8.
//

import SwiftUI

struct ProfileStarView: View {
    @StateObject private var viewModel = UserStarRepoViewModel()
    @State private var showDetailView: Bool = false
    @State private var selectedRepo: Repository? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(viewModel.repos) { repo in
                HStack(alignment: .top, spacing: 15) {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(Color.blue)
                        .frame(width: 50, height: 50)
                        .overlay {
                            Text("</>")
                                .foregroundStyle(Color.white)
                                .font(.headline)
                        }

                    VStack(alignment: .leading, spacing: 10) {
                        Text(repo.name)
                            .font(.headline.bold())
                        if let description = repo.description {
                            Text(description)
                                .font(.subheadline)
                                .foregroundStyle(Color(.secondaryLabel))
                        }
                        HStack {
                            HStack(spacing: 0) {
                                Image(systemName: "star.fill")
                                    .foregroundStyle(.yellow)
                                Text("\(repo.stargazers_count)")
                                    .font(.callout)
                                    .foregroundStyle(Color(.secondaryLabel))
                            }
                            
                            if let language = repo.language {
                                HStack(spacing: 0) {
                                    LanguageColor(language: language)
                                    Text(language)
                                        .font(.callout)
                                        .foregroundStyle(Color(.secondaryLabel))
                                }
                            }
                            Spacer()
                        }
                    }
                }
                .padding(.vertical)
                .onTapGesture {
                    segue(repo: repo)
                }
            }
            Spacer()
        }
        .frame(minHeight: kScreenH - kStatusAndNavBarH)
        .task {
            await viewModel.fetchUserStarredRepoList()
        }
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
    ProfileStarView()
}
