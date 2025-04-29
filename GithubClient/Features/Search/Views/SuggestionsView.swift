//
//  SuggestionsView.swift
//  GithubClient
//
//  Created by kim on 2025/3/28.
//

import SwiftUI

struct SuggestionsView: View {
    private let suggestions = [
        "SwiftUI",
        "iOS",
        "GitHub",
        "Swift",
        "React Native",
        "Flutter",
        "Kotlin",
        "Android",
    ]
    
    @Binding var suggestin: String

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("热门搜索")
                .font(.headline)
                .padding(.horizontal)

            LazyVGrid(
                columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                ], spacing: 12
            ) {
                ForEach(suggestions, id: \.self) { suggestion in
                    Button {
                        self.suggestin = suggestion
                    } label: {
                        HStack {
                            Text(suggestion)
                                .font(.subheadline)
                                .foregroundColor(.blue)
                            
                            Spacer()
                            
                            Image(systemName: "arrow.up.right")
                                .font(.caption)
                                .foregroundStyle(.blue.opacity(0.6))
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(8)
                }
            }
            .padding(.horizontal)
        }
        .padding(.vertical)
    }
}

#Preview {
    SuggestionsView(suggestin: .constant(""))
}
