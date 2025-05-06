//
//  TrendingRepoCard.swift
//  GithubClient
//
//  Created by kim on 2025/3/27.
//

import SwiftUI

struct TrendingRepoCard: View {
    
    let repository: Repository
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                AsyncImage(url: URL(string: repository.owner.avatarURL)) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray
                }
                .frame(width: 20, height: 20)
                .clipShape(.circle)

                Text(repository.owner.login)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Text(repository.name)
                .font(.headline)
            
            Text(repository.description ?? "")
                .font(.subheadline)
                .lineLimit(2)
                .foregroundStyle(.secondary)
            
            HStack(spacing: 16) {
                HStack(spacing: 4) {
                    Image(systemName: "star")
                    Text("\(repository.stargazers_count)")
                }
                
                HStack(spacing: 4) {
                    Image(systemName: "arrow.triangle.branch")
                    Text("\(repository.forks_count)")
                }
                
                if let language = repository.language {
                    HStack(spacing: 4) {
                        LanguageColor(language: language)
                        Text(language)
                    }
                }
            }
            .font(.caption)
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
    }
}

#Preview {
    TrendingRepoCard(repository: DeveloperPreview.shared.repo)
}
