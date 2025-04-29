//
//  RepositoryRow.swift
//  GithubClient
//
//  Created by kim on 2025/3/28.
//

import SwiftUI

struct RepositoryRow: View {
    let repo: Repository

    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top, spacing: 10) {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(Color.blue)
                    .frame(width: 50, height: 50)
                    .overlay {
                        Text("</>")
                            .foregroundStyle(Color.white)
                            .font(.headline)
                    }
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(repo.name)
                        .font(.headline)
                    Text(repo.updatedAt.relativeDescription)
                        .font(.caption)
                        .foregroundStyle(Color.secondary)
                    HStack(spacing: 5) {
                        HStack(spacing: 2) {
                            Image(systemName: "star.fill")
                            Text("\(repo.stargazers_count)")
                        }
                        HStack(spacing: 2) {
                            Image(systemName: "arrow.branch")
                            Text("\(repo.forks_count)")
                        }
                    }
                    .foregroundStyle(Color.secondary)
                    .font(.caption2)
                    
                    Spacer()
                }
                
                Spacer()
                
                if let language = repo.language {
                    Text(language)
                        .foregroundStyle(Color.secondary)
                        .font(.caption)
                }
            }
            
            Rectangle()
                .fill(Color.gray.opacity(0.15))
                .frame(height: 1)
                .frame(maxWidth: .infinity)
        }
        .padding(.horizontal, 10)
    }

}

#Preview {
    RepositoryRow(repo: DeveloperPreview.shared.repo)
}
