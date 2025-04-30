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
        if let data = data {
            do {
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                let prettyJsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
                if let prettyJsonString = String(data: prettyJsonData, encoding: .utf8) {
                    print("📩 Response JSON:\n\(prettyJsonString)")
                }
            } catch {
                print("❌ JSON 解析失败: \(error)")
            }
        }
        #endif
    }
}
