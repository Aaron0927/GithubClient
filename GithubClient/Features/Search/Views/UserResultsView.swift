//
//  UserResultsView.swift
//  GithubClient
//
//  Created by kim on 2025/3/28.
//

import SwiftUI

struct UserResultsView: View {
    
    let users: [User]
    
    var body: some View {
        ForEach(users, id: \.login) { user in
            HStack(spacing: 12) {
                AsyncImage(url: URL(string: user.avatarURL)) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray.opacity(0.1)
                }
                .frame(width: 40, height: 40)
                .clipShape(.circle)
                
                Text(user.login)
                    .font(.headline)
                
                Spacer()
            }
            .padding(.vertical, 8)
        }
    }
}

#Preview {
    UserResultsView(users: [DeveloperPreview.shared.owner])
}
