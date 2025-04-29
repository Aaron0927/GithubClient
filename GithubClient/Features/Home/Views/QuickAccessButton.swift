//
//  QuickAccessButton.swift
//  GithubClient
//
//  Created by kim on 2025/3/27.
//

import SwiftUI

struct QuickAccessButton: View {
    
    let icon: String
    let label: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.title3)
                Text(label)
                    .font(.caption)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    QuickAccessButton(icon: "bookmark", label: "收藏", action: {})
}
