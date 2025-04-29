//
//  LoadingView.swift
//  GithubClient
//
//  Created by kim on 2025/3/28.
//

import SwiftUI

struct LoadingView: View {
    
    let text: String = "加载中..."
    
    var body: some View {
        VStack(spacing: 12) {
            ProgressView()
                .progressViewStyle(.circular)
                .tint(.accentColor)
                .scaleEffect(1.5)
            
            Text(text)
                .font(.headline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }
}

#Preview {
    LoadingView()
}
