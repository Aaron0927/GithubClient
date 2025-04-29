//
//  ProfileProjectView.swift
//  GithubClient
//
//  Created by kim on 2025/4/8.
//

import SwiftUI

struct ProfileProjectView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(0..<1) { _ in
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("iOS客户端重构")
                            .font(.title3.bold())
                            .foregroundStyle(.primary)
                        Spacer()
                        Text("3/5 完成")
                            .font(.callout)
                            .foregroundStyle(Color(.secondaryLabel))
                    }
                    ProgressView(value: 0.5, total: 1.0)
                        .progressViewStyle(.linear)
                    Text("将现有Objective-C代码迁移到SwiftUI")
                        .font(.callout)
                        .foregroundStyle(Color(.secondaryLabel))
                    Text("更新于2天前")
                        .font(.callout)
                        .foregroundStyle(Color(.secondaryLabel))
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.gray.opacity(0.2), lineWidth: 1)
                )
            }
            Spacer()
        }
        .frame(minHeight: kScreenH - kStatusAndNavBarH)
    }
}

#Preview {
    ProfileProjectView()
}
