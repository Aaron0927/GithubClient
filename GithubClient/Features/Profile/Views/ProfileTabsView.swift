//
//  ProfileTabsView.swift
//  GithubClient
//
//  Created by kim on 2025/4/7.
//

import SwiftUI

/// 主页标签页（仓库/项目/星标）
struct ProfileTabsView<Content: View>: View {
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            content()
        }
    }
}

#Preview {
    ProfileTabsView {
        EmptyView()
    }
}
