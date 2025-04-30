//
//  RepostoryDetailView.swift
//  GithubClient
//
//  Created by kim on 2025/4/30.
//

import SwiftUI
import MarkdownUI

struct RepoDetailLoadingView: View {
    
    @Binding var repo: Repository?
    
    var body: some View {
        ZStack {
            if let repo = repo {
                RepostoryDetailView(repo: repo)
            }
        }
    }
}

struct RepostoryDetailView: View {
    
    @StateObject private var viewModel: RepositoryDetailViewModel
    @State private var showDetail: Bool = false
        
    init(repo: Repository) {
        _viewModel = StateObject(wrappedValue: RepositoryDetailViewModel(repo: repo))
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                header
                
                branchView
                
                // 文件路径导航
                HStack(spacing: 0) {
                    Text("Root/")
                        .onTapGesture {
                            viewModel.updateSelectRepoContent(repoContent: nil)
                        }
                    ForEach(viewModel.paths) { content in
                        Text("\(content.path.components(separatedBy: "/").last ?? "")/")
                            .onTapGesture {
                                viewModel.updateSelectRepoContent(repoContent: content)
                            }
                    }
                }
                .foregroundStyle(.blue)
                .font(.callout)
                .lineLimit(1)
                .truncationMode(.head)
                
                // 文件系统
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(Color.gray.opacity(0.15))
                    
                    if let selectedContent = viewModel.selectedContent, selectedContent.type == .file {
                        if let url = URL(string: viewModel.contentURL) {
                            // TODO: 替换
                            WebView(url)
                                .frame(height: 500)
                        }
                    } else {
                        folderView
                            .task {
                                await viewModel.fetchData()
                            }
                    }
                }
                
            }
            .padding()
        }
        .navigationTitle(viewModel.repo.name)
//        .navigationDestination(isPresented: $showDetail) {
//            if let url = URL(string: viewModel.contentURL) {
//                WebView(url)
//            }
//        }
    }
    
    // 项目名称
    private var header: some View {
        HStack(alignment: .top, spacing: 10) {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(Color.blue)
                .frame(width: 50, height: 50)
                .overlay {
                    Text("</>")
                        .foregroundStyle(Color.white)
                        .font(.headline)
                }
            
            VStack(alignment: .leading, spacing: 5) {
                Text(viewModel.repo.name)
                    .font(.headline)
                Text(viewModel.repo.updatedAt.relativeDescription)
                    .font(.caption)
                    .foregroundStyle(Color.secondary)
                HStack(spacing: 5) {
                    HStack(spacing: 2) {
                        Image(systemName: "star.fill")
                        Text("\(viewModel.repo.stargazers_count)")
                    }
                    HStack(spacing: 2) {
                        Image(systemName: "arrow.branch")
                        Text("\(viewModel.repo.forks_count)")
                    }
                }
                .foregroundStyle(Color.secondary)
                .font(.caption2)
                
                Spacer()
            }
            
            Spacer()
        }
    }
    
    // 分支名称
    private var branchView: some View {
        HStack {
            HStack(spacing: 2) {
                Image(systemName: "arrow.branch")
                Text(viewModel.repo.default_branch)
            }
            
            Spacer()
            
            Button {
                // clone_url: https://github.com/Aaron0927/YuanZhi.git
            } label: {
                HStack(spacing: 2) {
                    Image(systemName: "square.and.arrow.down")
                    Text("clone")
                }
                .foregroundStyle(Color.blue)
            }
        }
        .foregroundStyle(Color.primary)
        .font(.body)
    }
    
    private var folderView: some View {
        VStack(alignment: .leading, spacing: 20) {
            ForEach(viewModel.repoContents) { content in
                HStack(spacing: 10) {
                    Image(systemName: content.type.icon)
                    Text(content.name)
                    Spacer()
                }
                .contentShape(Rectangle())
                .foregroundStyle(Color.primary)
                .font(.body)
                .onTapGesture {
                    viewModel.selectedContent = content
                    switch content.type {
                    case .file:
                        showDetail = true
                    case .dir:
                        Task {
                            await viewModel.fetchData(path: content.path)
                        }
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    RepostoryDetailView(repo: DeveloperPreview.shared.repo)
}
