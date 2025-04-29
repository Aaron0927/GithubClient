//
//  ExploreView.swift
//  GithubClient
//
//  Created by kim on 2025/3/24.
//

import SwiftUI

struct ExploreView: View {
    
    @State private var searchText: String = ""
    @StateObject private var viewModel = ExploreViewModel()
    
    var body: some View {
        List {
            Section {
                HStack {
                    Image(systemName: "flame")
                    Text("Trending Repositories")
                }
                HStack {
                    Image(systemName: "flame")
                    Text("Awesome Lists")
                }
            } header: {
                Text("Discover")
                    .font(.title3.bold())
                    .foregroundStyle(Color.black)
                    .padding(.vertical, 5)
                    .listRowInsets(EdgeInsets())
            }
            .textCase(nil)
            
            Section {
                
            } header: {
                HStack {
                    Text("Activity")
                        .font(.title3.bold())
                        .foregroundStyle(Color.black)
                    Spacer()
                    Image(systemName: "line.3.horizontal.decrease")
                        .font(.title3)
                }
                .padding(.vertical, 5)
                .listRowInsets(EdgeInsets())
            }
            .textCase(nil)
        }
        .searchable(text: $searchText, prompt: "Search Github")
        .navigationTitle("Explore")
        .task {
            viewModel.loadData()
        }
    }
}

#Preview {
    NavigationView {
        ExploreView()
    }
}
