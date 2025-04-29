//
//  HomeViewModel.swift
//  GithubClient
//
//  Created by kim on 2025/3/27.
//

import Foundation

@MainActor
final class HomeViewModel: ObservableObject {
    
    @Published var trendingRepos: [Repository] = []
    @Published var recommendedRepos: [Repository] = []
    @Published var isLoading = false
    @Published var error: Error?
    private let service = GitHubAPIService()
    
    
    func loadData() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            async let trending: [Repository] = service.fetchTrendingRepos()
//            async let recommended: [Repository] = service.fetchRecommendRepos()
            
            let (trendingResult) = await (try trending)
            trendingRepos = trendingResult
//            recommendedRepos = recommendedResult
        } catch {
            print(error)
            self.error = error
        }
    }
    
    func refresh() async {
        await loadData()
    }
    
}

