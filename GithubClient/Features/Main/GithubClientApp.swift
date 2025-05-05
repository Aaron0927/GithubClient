//
//  GithubClientApp.swift
//  GithubClient
//
//  Created by kim on 2025/4/28.
//

import SwiftUI

@main
struct GithubClientApp: App {
    @StateObject private var auth = AuthManager()
    
    var body: some Scene {
        WindowGroup {
            if auth.isAuthenticated {
                GithubTabView()
                    .environmentObject(auth)
            } else {
                GCLoginView()
                    .environmentObject(auth)
            }
        }
    }
}
