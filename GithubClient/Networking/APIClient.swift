//
//  APIClient.swift
//  iOSTemplateApp
//
//  Created by kim on 2025/2/25.
//

import Foundation

class APIClient {
    
    static let shared = APIClient()
    private let session: URLSession
    
    init() {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        self.session = URLSession(configuration: config)
    }
    
    func request<T: Decodable, E: EndpointProtocol>(_ endpoint: E, decoder: JSONDecoder = JSONDecoder()) async throws -> T {
        guard let request = endpoint.urlRequest() else {
            throw NetworkError.invalidURL
        }
        NetworkLogger.log(request)
        
        do {
            let (data, response) = try await session.data(for: request)
            NetworkLogger.logResponse(response, data: data)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.noData
            }
            
            switch httpResponse.statusCode {
            case 200...299:
                decoder.dateDecodingStrategy = .iso8601
                return try decoder.decode(T.self, from: data)
            case 401:
                throw NetworkError.unauthorized
            default:
                throw NetworkError.requestFailed(error: NetworkError.noData)
            }
        } catch let decodingError as DecodingError {
            print("解码错误：", decodingError)
            switch decodingError {
            case .typeMismatch(let type, let context):
                print("类型不匹配:", type, context.debugDescription)
            case .valueNotFound(let type, let context):
                print("值未找到:", type, context.debugDescription)
            case .keyNotFound(let key, let context):
                print("缺少键:", key, context.debugDescription)
            case .dataCorrupted(let context):
                print("数据损坏:", context.debugDescription)
            @unknown default:
                print("未知解码错误:", decodingError.localizedDescription)
            }
            throw NetworkError.decodingError
        } catch {
            throw NetworkError.unknown(error: error)
        }
    }
    
    
    func download(_ url: URL) async throws -> Data {
        let (data, response) = try await session.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.noData
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            return data
        default:
            throw NetworkError.noData
        }
    }
}
