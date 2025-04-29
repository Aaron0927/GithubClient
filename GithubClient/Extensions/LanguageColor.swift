//
//  LanguageColor.swift
//  GithubClient
//
//  Created by kim on 2025/3/28.
//

import SwiftUI

struct LanguageColor: View {
    let language: String
    
    var body: some View {
        Circle()
            .fill(languageColor(language))
            .frame(width: 10, height: 10)
    }
    
    private func languageColor(_ language: String) -> Color {
        switch language.lowercased() {
        case "swift": return .orange
        case "javascript": return .yellow
        case "python": return .blue
        case "java": return .red
        case "ruby": return .red
        case "go": return .cyan
        case "c++": return .pink
        case "c": return .gray
        case "typescript": return .blue
        default: return .purple
        }
    }
}

#Preview {
    LanguageColor(language: "swift")
}
