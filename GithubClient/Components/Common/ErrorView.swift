//
//  ErrorView.swift
//  GithubClient
//
//  Created by kim on 2025/3/28.
//

import SwiftUI

struct ErrorView: View {
    
    let error: Error
    var retryAction: (() -> Void)?
    let title: String = "出错了"
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 40))
                .foregroundStyle(.yellow)
            
            Text(title)
                .font(.headline)
            
            Text(error.localizedDescription)
                .font(.headline)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
            
            if let retryAction = retryAction {
                Button(action: retryAction) {
                    Label("重试", systemImage: "arrow.clockwise")
                }
                .buttonStyle(.borderedProminent)
                .padding(.top, 8)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }
}

#Preview {
    ErrorView(error: NetworkError.invalidURL)
}
