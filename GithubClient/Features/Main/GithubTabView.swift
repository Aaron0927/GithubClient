//
//  ContentView.swift
//  GithubClient
//
//  Created by kim on 2025/4/28.
//

import SwiftUI

struct GithubTabView: View {
    var body: some View {
        TabView {
            RepositoryView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            Text("Explore")
                .tabItem {
                    Label("Explore", systemImage: "safari.fill")
                }
            
            Text("Profile")
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
    }
}

#Preview {
    GithubTabView()
}
