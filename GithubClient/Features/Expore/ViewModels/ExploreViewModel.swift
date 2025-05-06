//
//  ExploreViewModel.swift
//  GithubClient
//
//  Created by kim on 2025/3/25.
//

import Foundation

@MainActor
final class ExploreViewModel: ObservableObject {
    @Published var trendingRepos: [Repository] = []
    @Published var recommendedRepos: [Repository] = []
    @Published var isLoading = false
    @Published var error: Error? = nil
    
    private let service = GitHubAPIService()
    
    func loadData() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            async let trending: [Repository] = service.fetchTrendingRepos()
            async let recommended: [Repository] = service.fetchRecommendRepos()
            
            let (trendingResult, recommendedResult) = await (try trending, try recommended)
            trendingRepos = trendingResult
            recommendedRepos = recommendedResult
        } catch {
            print(error)
            self.error = error
        }
    }
}
