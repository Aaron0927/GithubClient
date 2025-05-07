# GithubClient

## 项目概述

GithubClient 是一个使用 SwiftUI、MVVM 架构和 async/await 异步编程模型开发的 GitHub 客户端应用。该应用旨在提供流畅的用户体验，支持浏览和管理 GitHub 仓库、用户信息等功能。

## 技术栈

- **SwiftUI**: 用于构建用户界面，提供声明式的UI开发方式。
- **MVVM**: 使用 Model-View-ViewModel 架构来分离视图和业务逻辑，提高代码的可维护性和可测试性。
- **async/await**: 采用 Swift 的异步编程模型，简化异步代码的编写，提高代码的可读性。

## 功能模块

- **认证模块**: 使用 GitHub OAuth 进行用户认证。
- **仓库浏览**: 支持查看热门仓库、推荐仓库以及用户的仓库。
- **搜索功能**: 提供仓库、用户和问题的搜索功能。
- **用户信息**: 查看用户的基本信息、星标仓库和分叉仓库。

## 代码示例

以下是一些关键代码示例，展示了如何使用 SwiftUI 和 MVVM 结合 async/await 实现异步数据加载：

```swift
@MainActor
final class ExploreViewModel: ObservableObject {
    @Published var trendingRepos: [Repository] = []
    @Published var recommendedRepos: [Repository] = []
    @Published var isLoading = false
    
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
        }
    }
}
```

## 运行项目

1. 克隆项目到本地。
2. 使用 Xcode 打开 `GithubClient.xcodeproj`。
3. 选择目标设备并运行项目。

## 许可证

该项目使用 MIT 许可证，详情请参阅 LICENSE 文件。
