//
//  RepositoryRowView.swift
//  GithubClient
//
//  Created by kim on 2025/3/17.
//

import SwiftUI
import MarkdownUI

struct RepositoryRowView: View {
    var repo: Repository
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        ImageView(urlString: repo.owner.avatarURL)
                            .frame(width: 30, height: 30)
                            .clipShape(.circle)
                        Text(repo.owner.login)
                    }
                    Text(repo.name)
                        .foregroundStyle(Color.black)
                        .font(.headline)
                    if let description = repo.description {
                        Markdown(description)
                            .foregroundStyle(.black)
                            .font(.body)
                    }
                    HStack(spacing: 20) {
                        Label("\(repo.stargazers_count)", systemImage: "star")
                        if let language = repo.language {
                            Text(language)
                        }
                    }
                    .foregroundStyle(.black)
                    .font(.body)
                }
                Spacer()
            }
            
            Rectangle()
                .fill(Color.gray.opacity(0.15))
                .frame(height: 1)
        }
        .padding(.leading)
        .padding(.vertical, 5)
    }
}

#Preview {
    RepositoryRowView(repo: DeveloperPreview.shared.repo)
}
