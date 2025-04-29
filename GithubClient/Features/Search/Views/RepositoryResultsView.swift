//
//  RepositoryResultsView.swift
//  GithubClient
//
//  Created by kim on 2025/3/28.
//

import SwiftUI

struct RepositoryResultsView: View {
    let repositories: [Repository]
    
    var body: some View {
        ForEach(repositories) { repo in
            RepositoryRow(repo: repo)
        }
    }
}

#Preview {
    RepositoryResultsView(repositories: [])
}
