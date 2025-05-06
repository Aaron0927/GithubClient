//
//  SectionHeader.swift
//  GithubClient
//
//  Created by kim on 2025/3/27.
//

import SwiftUI

struct SectionHeader: View {
    
    let title: String
    var action: (() -> Void)?
    
    var body: some View {
        HStack(alignment: .bottom) {
            Text(title)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundStyle(.primary)
            
            Spacer()
            
            if let action = action {
                Button(action: action) {
                    HStack(spacing: 4) {
                        Text("更多")
                            .font(.subheadline)
                        Image(systemName: "chevron.right")
                            .imageScale(.small)
                    }
                    .foregroundStyle(Color.accentColor)
                }
            }
        }
        .padding(.vertical, 4)
        .accessibilityElement(children: .combine)
    }
}

#Preview {
    VStack(spacing: 20) {
        SectionHeader(title: "示例标题")
        SectionHeader(title: "带操作的标题", action: {})
    }
    .padding()
}
