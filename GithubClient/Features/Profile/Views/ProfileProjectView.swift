//
//  ProfileProjectView.swift
//  GithubClient
//
//  Created by kim on 2025/4/8.
//

import SwiftUI

struct ProfileProjectView: View {
    @StateObject private var viewModel = UserForkRepoViewModel()
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
                        HStack(spacing: 10) {
                            HStack(spacing: 2) {
                                Image(systemName: "arrow.branch")
                                    .foregroundStyle(Color(.secondaryLabel))
                                Text("\(repo.forks_count)")
                                    .font(.callout)
                                    .foregroundStyle(Color(.secondaryLabel))
                            }
                            
                            if let language = repo.language {
                                HStack(spacing: 2) {
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
        .task {
            await viewModel.fetchData()
        }
    }
    
    private func segue(repo: Repository) {
        selectedRepo = repo
        showDetailView = true
    }
}

#Preview {
    ProfileProjectView()
}
