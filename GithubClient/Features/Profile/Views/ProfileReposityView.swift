//
//  ProfileReposityView.swift
//  GithubClient
//
//  Created by kim on 2025/4/8.
//

import SwiftUI

struct ProfileReposityView: View {
    var repos: [Repository] = []
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            ForEach(repos) { repo in
                VStack(alignment: .leading, spacing: 10) {
                    Text(repo.name)
                        .font(.headline)
                        .foregroundStyle(.blue)
                    if let description = repo.description {
                        Text(description)
                            .lineLimit(2)
                            .font(.body)
                            .foregroundStyle(Color(.secondaryLabel))
                    }
                    
                    Text("更新于\(repo.updatedAt.relativeDescription)")
                        .font(.body)
                        .foregroundStyle(Color(.secondaryLabel))
                }
                .frame(minHeight: 80)
                .padding(.vertical)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.white)
                        .shadow(color: .gray.opacity(0.2), radius: 2)
                )
            }
        }
        .frame(minHeight: kScreenH - kStatusAndNavBarH)
    }
}

#Preview {
    ProfileReposityView()
}
