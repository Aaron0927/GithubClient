//
//  NetworkLogger.swift
//  iOSTemplateApp
//
//  Created by kim on 2025/2/25.
//

import Foundation

class NetworkLogger {
    static func log(_ request: URLRequest) {
        #if DEBUG
        print("📡 Request: \(request.httpMethod ?? "") \(request.url?.absoluteString ?? "")")
        if let headers = request.allHTTPHeaderFields {
            print("📝 Headers: \(headers)")
        }
        if let body = request.httpBody, let json = try? JSONSerialization.jsonObject(with: body, options: []) {
            print("📦 Body: \(json)")
        }
        #endif
    }
    
    static func logResponse(_ response: URLResponse?, data: Data?) {
        #if DEBUG
        if let httpResponse = response as? HTTPURLResponse {
            print("✅ Response: \(httpResponse.statusCode)")
        }
        if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) {
            print("📩 Response Data: \(json)")
        }
        #endif
    }
}
