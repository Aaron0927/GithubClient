//
//  ProfileView.swift
//  GithubClient
//
//  Created by kim on 2025/3/13.
//

import SwiftUI
import MarkdownUI

struct ProfileView: View {
    
    @StateObject private var viewModel = ProfileViewModel()
    @State private var showTitle: Bool = false
    @EnvironmentObject private var manager: AuthManager
    
    var body: some View {
        ZStack {
            if let user = viewModel.user {
                List {
                    Section {
                        VStack(alignment: .leading, spacing: 15) {
                            // 头像
                            HStack {
                                ImageView(urlString: user.avatarURL)
                                    .frame(width: 60, height: 60)
                                    .clipShape(.circle)
                                VStack(alignment: .leading) {
                                    Text(user.name ?? "")
                                        .foregroundStyle(Color.black)
                                        .font(.title.bold())
                                    Text("\(user.login) · \("he/him")")
                                }
                                Spacer()
                            }
                            
                            // 设置状态
                            RoundedRectangle(cornerRadius: 10)
                                .frame(height: 50)
                                .foregroundStyle(Color.gray.opacity(0.1))
                                .overlay {
                                    HStack {
                                        Image(systemName: "face.smiling")
                                        Text("设置状态")
                                        Spacer()
                                        Image(systemName: "applepencil.gen1")
                                    }
                                    .foregroundStyle(Color.gray)
                                    .padding()
                                }
                            
                            Text(user.bio ?? "")
                                .font(.body)
                            
                            HStack(spacing: 15) {
                                Label {
                                    Text(user.location ?? "")
                                        .foregroundStyle(Color.primary)
                                } icon: {
                                    Image(systemName: "location")
                                        .foregroundStyle(Color.gray)
                                }
                                Label {
                                    Text(user.twitterUsername ?? "")
                                        .bold()
                                } icon: {
                                    Image(systemName: "applelogo")
                                        .foregroundStyle(Color.gray)
                                }
                                Spacer()
                            }
                            Label {
                                Text(user.email ?? "")
                                    .bold()
                            } icon: {
                                Image(systemName: "envelope")
                                    .foregroundStyle(Color.gray)
                            }
                            
                            Label {
                                HStack(spacing: 5) {
                                    Text("\(user.followers ?? 0)")
                                        .bold()
                                    Text(" 关注者 · ")
                                    Text("\(user.following ?? 0)")
                                        .bold()
                                    Text(" 正在关注")
                                }
                            } icon: {
                                Image(systemName: "person.2")
                                    .foregroundStyle(Color.gray)
                            }
                            
                            Label {
                                
                            } icon: {
                                Image(systemName: "trophy")
                                    .foregroundStyle(Color.gray)
                            }
                        }
                    }
                    
                    Section {
                        NavigationLink {
                            
                        } label: {
                            ProfileListRow(icon: "folder.fill", title: "仓库", count: user.totalRepos)
                        }
                        NavigationLink {
                            
                        } label: {
                            ProfileListRow(icon: "star.fill", title: "已加星标", count: 183)
                        }
                        NavigationLink {
                            
                        } label: {
                            ProfileListRow(icon: "person.2.fill", title: "组织", count: 0)
                        }
                    }
                    
                    Section {
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                ImageView(urlString: user.avatarURL)
                                    .frame(width: 30, height: 30)
                                    .clipShape(.circle)
                                Text(user.login)
                                    .font(.body)
                            }
                            Text("V2EX")
                                .font(.headline.bold())
                            HStack {
                                Label("15", systemImage: "star.fill")
                                Label("Swift", systemImage: "dot.circle.fill")
                            }
                            .font(.callout)
                            .foregroundStyle(Color.secondary)
                        }
                    } header: {
                        Label("已固定", systemImage: "pin")
                    }
                    
                    Section {
                        if let readme = viewModel.readme {
                            Markdown(readme.content.decodeBase64() ?? "xxx")
                        }
                    } header: {
                        Text("Aaron0927/README.md")
                    }
                    
                    Section {
                        Button {
                            manager.logout()
                        } label: {
                            Text("退出登录")
                                .foregroundStyle(Color.red)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                .hideListBackground()
                .background(
                    ImageView(urlString: user.avatarURL)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .overlay(.thinMaterial)
                )
            } else {
                EmptyView()
            }
        }
        .navigationTitle(showTitle ? (viewModel.user?.name ?? "") : "")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.getUser()
            await viewModel.getReadme(owner: "Aaron0927", repo: "Aaron0927")
        }
    }
}

// 个人信息行组件
struct ProfileListRow: View {
    var icon: String
    var title: String
    var count: Int
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.orange)
            Text(title)
            Spacer()
            Text("\(count)")
                .foregroundColor(.gray)
        }
    }
}

#Preview {
    NavigationView {
        ProfileView()
    }
}
