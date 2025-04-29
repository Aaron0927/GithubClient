//
//  NetworkError.swift
//  iOSTemplateApp
//
//  Created by kim on 2025/2/25.
//

import Foundation

/// 错误处理
enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case unauthorized
    case requestFailed(error: Error)
    case timeout
    case unknown(error: Error)
    case graphQLError(message: String)

    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "无效的请求 URL"
        case .noData:
            return "服务器未返回数据"
        case .decodingError:
            return "数据解析失败"
        case .unauthorized:
            return "未授权，请重新登录"
        case .requestFailed(let error):
            return "请求失败: \(error.localizedDescription)"
        case .timeout:
            return "请求超时"
        case .unknown(let error):
            return "未知错误: \(error.localizedDescription)"
        case .graphQLError(let message):
            return "GraphQL 错误: \(message)"
        }
    }
}
