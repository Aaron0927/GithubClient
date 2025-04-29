//
//  MockAPIClient.swift
//  iOSTemplateApp
//
//  Created by kim on 2025/2/25.
//

import Foundation

// 调试模式下使用Mock数据
class MockAPIClient: APIClient {
    
    override func request<T, E>(_ endpoint: E, decoder: JSONDecoder = JSONDecoder()) async throws -> T where T : Decodable, E : EndpointProtocol {
        if let mockData = loadMockData(for: endpoint.path) {
            return try JSONDecoder().decode(T.self, from: mockData)
        } else {
            throw NetworkError.noData
        }
    }
    
    private func loadMockData(for path: String) -> Data? {
        let filename = path.replacingOccurrences(of: "/", with: "_")
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else { return nil }
        return try? Data(contentsOf: url)
    }
}
