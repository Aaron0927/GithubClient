//
//  EndpointProtocol.swift
//  iOSTemplateApp
//
//  Created by kim on 2025/2/25.
//

import Foundation

enum Method: String {
    case get = "GET"
    case post = "POST"
}

/// API端点协议
protocol EndpointProtocol {
    var baseURL: String { get }
    var path: String { get }
    var method: Method { get }
    var headers: [String: String]? { get }
    var body: [String: String]? { get }
}

extension EndpointProtocol {
    var baseURL: String { return "https://api.github.com" }
    
    var commonHeaders: [String: String] {
        return [
            "Accept": "application/json",
            "Content-Type": "application/json",
            "User-Agent": "GitHubClient",
            "X-GitHub-Api-Version": "2022-11-28"
        ]
    }
    
    /// 生成 URLRequest
    func urlRequest() -> URLRequest? {
        guard let url = URL(string: baseURL + path) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        if let headers {
            request.allHTTPHeaderFields = commonHeaders.merging(headers, uniquingKeysWith: { _, second in
                return second
            })
        } else {
            request.allHTTPHeaderFields = commonHeaders
        }
        if let body = body,
           let httpBody = try? JSONSerialization.data(withJSONObject: body) {
            request.httpBody = httpBody
        }
        return request
    }
}
