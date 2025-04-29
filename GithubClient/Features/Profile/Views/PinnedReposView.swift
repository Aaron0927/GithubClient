//
//  PinnedReposView.swift
//  GithubClient
//
//  Created by kim on 2025/4/7.
//

import SwiftUI

/// 置顶仓库
struct PinnedReposView: View {
    var body: some View {
        VStack {
            HStack {
                Text("置顶仓库")
                    .font(.title3.bold())
                    .foregroundStyle(.primary)
                Spacer()
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 20) {
                    ForEach(0..<3) { _ in
                        card
                    }
                }
            }
        }
    }
    
    private var card: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("awesome-ios")
                .font(.headline)
                .foregroundStyle(.blue)
            Text("A curated list of awesome iOS ecosystem, including Objective-C and Swift projects")
                .lineLimit(2)
                .font(.body)
                .foregroundStyle(Color(.secondaryLabel))
            HStack(spacing: 10) {
                HStack(spacing: 0) {
                    Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)
                    Text("42K")
                        .font(.callout)
                        .foregroundStyle(Color(.secondaryLabel))
                }
                
                HStack(spacing: 0) {
                    Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)
                    Text("Swift")
                        .font(.callout)
                        .foregroundStyle(Color(.secondaryLabel))
                }
            }
        }
        .padding(15)
        .frame(width: 300)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.gray.opacity(0.5), lineWidth: 1)
        )
    }
}

#Preview {
    PinnedReposView()
}
