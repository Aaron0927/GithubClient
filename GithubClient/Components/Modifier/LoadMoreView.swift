//
//  LoadMoreView.swift
//  GithubClient
//
//  Created by kim on 2025/3/18.
//

import SwiftUI

struct LoadMoreView: View {
    let hasMoreData: Bool
    let loadMoreText: String
    let onLoadMore: () async -> Void
    
    var body: some View {
        HStack(spacing: 5) {
            if hasMoreData {
                ProgressView()
                    .progressViewStyle(.circular)
            }
            Text(loadMoreText)
                .foregroundStyle(Color.black)
                .font(.body)
        }
        .frame(maxWidth: .infinity)
        .task {
            await onLoadMore()
        }
    }
}

#Preview {
    LoadMoreView(hasMoreData: true, loadMoreText: "load more") {
        
    }
}
