//
//  ProfileHeaderView.swift
//  GithubClient
//
//  Created by kim on 2025/4/7.
//

import SwiftUI

struct ProfileHeaderView: View {
    
    let user: User?
    
    var body: some View {
        if let user = user {
            HStack(alignment: .top, spacing: 20) {
                AsyncImage(url: URL(string: user.avatarURL)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Color.gray.opacity(0.2)
                }
                .frame(width: 60, height: 60)
                .clipShape(.circle)
                
                VStack(alignment: .leading, spacing: 15) {
                    Text(user.name ?? "")
                        .font(.title.bold())
                    Text(user.login)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    if let bio = user.bio {
                        Text(bio)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    
                    Button {
                        print("编辑资料")
                    } label: {
                        Text("编辑资料")
                            .font(.subheadline)
                            .foregroundStyle(.primary)
                    }
                    .buttonStyle(.plain)
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(Color.gray.opacity(0.15))
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.gray.opacity(0.3), lineWidth: 1)
                    )
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        } else {
            // TODO: 未登录页面
            HStack(spacing: 20) {
                Rectangle()
                    .fill(.gray)
                    .frame(width: 60, height: 60)
                    .clipShape(.circle)
                
                Text("去登录")
                    .font(.title)
                    .foregroundStyle(.primary)
                
                Spacer()
            }
        }
    }
}

#Preview {
    ProfileHeaderView(user: DeveloperPreview.shared.owner)
}

#Preview {
    ProfileHeaderView(user: nil)
}
