//
//  GCLoginView.swift
//  GithubClient
//
//  Created by kim on 2025/3/12.
//

import SwiftUI

struct GCLoginView: View {
    
    @StateObject private var viewModel = GCLoginViewModel()
    @EnvironmentObject var authManager: AuthManager
    
    var body: some View {
        VStack {
            Spacer()
            Spacer()
            Image("github-mark")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
            Spacer()
            Spacer()
            
            VStack(spacing: 30) {
                VStack(spacing: 5) {
                    Button {
                        Task {
                            await viewModel.oauthLogin()
                            if let _ = KeyChainHelper.shared.token {
                                authManager.isAuthenticated = true
                            }
                        }
                    } label: {
                        Rectangle()
                            .clipShape(.capsule)
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(Color.black)
                            .overlay {
                                if viewModel.isLoading {
                                    ProgressView()
                                        .tint(Color.white)
                                } else {
                                    Text("登录到Github.com")
                                        .foregroundStyle(Color.theme.title)
                                        .font(.headline)
                                }
                            }
                    }
                    .padding(.horizontal, 30)

                    Button {
                        
                    } label: {
                        Text("使用帐户登录Github.com")
                            .foregroundStyle(Color.theme.title2)
                            .font(.subheadline)
                    }
                }
                
                VStack(spacing: 5) {
                    Button {
                        
                    } label: {
                        Text("使用GitHub Enterprise登录")
                            .foregroundStyle(Color.black)
                            .font(.headline)
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                            .background(Color.gray.opacity(0.15))
                            .clipShape(.capsule)
                    }
                    .padding(.horizontal, 30)

                    Text("需要服务器版本3.8.0或更高版本")
                        .foregroundStyle(Color.theme.title2)
                        .font(.subheadline)
                }
            }
            
            Spacer()
            HStack(spacing: 0) {
                Text("签名即表示您接受我们的")
                Button {
                    
                } label: {
                    Text(" 使用条款 ")
                        .foregroundStyle(Color.blue)
                }
                Text("和")
                Button {
                    
                } label: {
                    Text(" 隐私政策 ")
                        .foregroundStyle(Color.blue)
                }
            }
            .foregroundStyle(Color.secondary)
            .font(.footnote)
        }
        .padding(.bottom, 30)
    }
}

#Preview {
    GCLoginView()
}
