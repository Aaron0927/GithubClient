//
//  AuthManager.swift
//  GithubClient
//
//  Created by kim on 2025/3/12.
//

import Foundation

@MainActor
final class AuthManager: ObservableObject {
    
    @Published var isAuthenticated: Bool = false
    
    init() {
        self.checkAuthentication()
    }
    
    /// 检查是否登录
    func checkAuthentication() {
        if let _ = KeyChainHelper.shared.token {
            self.isAuthenticated = true
        } else {
            self.isAuthenticated = false
        }
    }
    
    /// 退出登录
    func logout() {
        KeyChainHelper.shared.deleteAccessToken()
        self.isAuthenticated = false
    }
}
