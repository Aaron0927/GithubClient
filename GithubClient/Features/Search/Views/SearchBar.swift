//
//  SearchBar.swift
//  GithubClient
//
//  Created by kim on 2025/3/28.
//

import SwiftUI

struct SearchBar: View {

    @Binding var text: String
    @Binding var scope: SearchScope
    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.secondary)

                TextField("搜索", text: $text)
                    .textFieldStyle(.plain)
                    .focused($isFocused)
                    .submitLabel(.search)
                    .onSubmit {
                        isFocused = false
                    }

                if !text.isEmpty {
                    Button {
                        text = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.secondary)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Color(.systemBackground))
            .cornerRadius(10)
            .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 2)

            Picker("搜索范围", selection: $scope) {
                ForEach(SearchScope.allCases, id: \.self) { scope in
                    Text(scope.rawValue).tag(scope)
                }
            }
            .pickerStyle(.segmented)
        }
    }
}

#Preview {
    SearchBar(text: .constant(""), scope: .constant(.repositories))
}
