//
//  ProfileStatsView.swift
//  GithubClient
//
//  Created by kim on 2025/4/7.
//

import SwiftUI

/// 数据统计卡片
struct ProfileStatsView: View {
    
    var user: User?
    
    var body: some View {
        Group {
            if let user = user {
                HStack {
                    VStack {
                        Text("\(user.totalRepos)")
                            .font(.title2.bold())
                            .foregroundStyle(.primary)
                        Text("仓库")
                            .font(.body)
                            .foregroundStyle(Color(.secondaryLabel))
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    VStack {
                        Text("\(user.followers ?? 0)")
                            .font(.title2.bold())
                            .foregroundStyle(.primary)
                        Text("粉丝")
                            .font(.body)
                            .foregroundStyle(Color(.secondaryLabel))
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    VStack {
                        Text("\(user.following ?? 0)")
                            .font(.title2.bold())
                            .foregroundStyle(.primary)
                        Text("关注")
                            .font(.body)
                            .foregroundStyle(Color(.secondaryLabel))
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
            } else {
                EmptyView()
            }
        }
        .frame(height: 80)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
                .shadow(color: .gray.opacity(0.2), radius: 2)
        )
    }
}

#Preview {
    ProfileStatsView(user: DeveloperPreview.shared.owner)
}
