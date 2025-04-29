//
//  GCLoginViewModel.swift
//  GithubClient
//
//  Created by kim on 2025/3/12.
//

import Foundation
import SwiftUI

@MainActor
final class GCLoginViewModel: ObservableObject {
    @Published var errMsg: String? = nil
    @Published var isLoading: Bool = false
    private let authService = GitHubAuthService()
    
    // github授权登录
    func oauthLogin() async {
        self.isLoading = true
        defer {
            self.isLoading = false
        }
        do {
            let code = try await authService.startAuthentication()
            try await authService.exchangeCodeForToken(code: code)
        } catch {
            self.errMsg = error.localizedDescription
        }
    }
}


